import 'package:algorithms/trie/radix_tree.dart';
import 'package:test/test.dart';

void main() {
  late RadixTree emptyTree, tree;

  setUp(() {
    emptyTree = RadixTree();
    tree = RadixTree();
    for (var word in [
      'romane',
      'romanus',
      'romulus',
      'rubens',
      'ruber',
      'rubicon',
      'rubicundus'
    ]) {
      tree.add(word);
    }
  });

  test('Empty tree', () {
    expect(emptyTree.isEmpty, isTrue);
    expect(emptyTree.contains('anything'), isFalse);
  });

  test('Add and contains single value', () {
    emptyTree.add('hello');
    expect(emptyTree.isEmpty, isFalse);
    expect(emptyTree.contains('hello'), isTrue);
    expect(emptyTree.contains('hell'), isFalse);
    expect(emptyTree.contains('helloo'), isFalse);
  });

  test('Contains multiple values', () {
    expect(tree.contains('romane'), isTrue);
    expect(tree.contains('romanus'), isTrue);
    expect(tree.contains('romulus'), isTrue);
    expect(tree.contains('rubens'), isTrue);
    expect(tree.contains('ruber'), isTrue);
    expect(tree.contains('rubicon'), isTrue);
    expect(tree.contains('rubicundus'), isTrue);
    expect(tree.contains('roma'), isFalse);
    expect(tree.contains('rubiconus'), isFalse);
    expect(tree.contains('x'), isFalse);
  });

  test('Add duplicate', () {
    tree.add('romane');
    expect(tree.contains('romane'), isTrue);
    expect(tree.contains('romanus'), isTrue);
  });

  test('Add prefix of existing value', () {
    tree.add('rom');
    expect(tree.contains('rom'), isTrue);
    expect(tree.contains('romane'), isTrue);
    expect(tree.contains('romanus'), isTrue);
  });

  test('Add value that is a prefix of existing', () {
    tree.add('romanusmaximus');
    expect(tree.contains('romanusmaximus'), isTrue);
    expect(tree.contains('romanus'), isTrue);
  });

  test('Nullify', () {
    tree.nullify();
    expect(tree.isEmpty, isTrue);
    expect(tree.contains('romane'), isFalse);
  });

  group('Delete ', () {
    test('Delete leaf value', () {
      tree.delete('romulus');
      expect(tree.contains('romulus'), isFalse);
      expect(tree.contains('romane'), isTrue);
      expect(tree.contains('romanus'), isTrue);
    });

    test('Delete value that is prefix of others', () {
      tree.add('rom');
      tree.delete('rom');
      expect(tree.contains('rom'), isFalse);
      expect(tree.contains('romane'), isTrue);
      expect(tree.contains('romanus'), isTrue);
    });

    test('Delete all values one by one', () {
      var words = [
        'romane',
        'romanus',
        'romulus',
        'rubens',
        'ruber',
        'rubicon',
        'rubicundus'
      ];
      for (var word in words) {
        tree.delete(word);
        expect(tree.contains(word), isFalse);
      }
      expect(tree.isEmpty, isTrue);
    });

    test('Delete non-existent value', () {
      tree.delete('nonexistent');
      expect(tree.contains('romane'), isTrue);
    });

    test('Delete from empty tree', () {
      emptyTree.delete('anything');
      expect(emptyTree.isEmpty, isTrue);
    });
  });

  group('Prefix search ', () {
    test('Find with prefix', () {
      expect(
        tree.findWithPrefix('rom'),
        equals(['romane', 'romanus', 'romulus']),
      );
      expect(
        tree.findWithPrefix('rube'),
        equals(['rubens', 'ruber']),
      );
    });

    test('Find exact match prefix', () {
      expect(tree.findWithPrefix('romane'), equals(['romane']));
    });

    test('Find with no match', () {
      expect(tree.findWithPrefix('xyz'), isEmpty);
    });

    test('Find with empty prefix returns all', () {
      var result = tree.findWithPrefix('');
      expect(result.length, equals(7));
    });
  });
}
