import 'package:test/test.dart';
import 'package:algorithms/trie/trie.dart';

void main() {
  late Trie emptyTrie, trie, customTrie;

  setUp(() {
    emptyTrie = Trie.ofAlphabets();

    trie = Trie.ofAlphabets();
    trie.add('algorithms');

    customTrie = Trie(
        {'a', 'b', 'f', 'o', 'r', 'z'}, (value) => value.toString().split(''));
    customTrie.add('foo');
  });

  test('Components', () {
    expect(trie.components,
        equals({...List.generate(26, (i) => String.fromCharCode(122 - i))}));

    expect(customTrie.components, equals({'f', 'o', 'b', 'a', 'r', 'z'}));
  });

  test('Empty trie', () {
    expect(emptyTrie.isEmpty, isTrue);
    expect(trie.isEmpty, isFalse);
  });

  test('Add value', () {
    trie.add('hi');
    expect(trie.root!.children![7]!.children![8]!.isValue, isTrue);

    customTrie.add('bar');
    expect(customTrie.root!.children![1]!.children![0]!.children![4]!.isValue,
        isTrue);

    customTrie.add('baz');
    expect(customTrie.root!.children![1]!.children![0]!.children![5]!.isValue,
        isTrue);
  });

  test('Contains value', () {
    expect(emptyTrie.contains('test'), isFalse);

    expect(trie.contains('algorithm'), isFalse);
    expect(trie.contains('algorithms'), isTrue);

    expect(customTrie.contains('boar'), isFalse);
    expect(customTrie.contains('foo'), isTrue);
  });

  test('Delete value', () {
    emptyTrie.delete('');
    emptyTrie.delete('test');

    expect(trie.contains('algorithms'), isTrue);
    trie.delete('algorithms');
    expect(trie.contains('algorithms'), isFalse);

    expect(customTrie.contains('foo'), isTrue);
    customTrie.delete('foo');
    expect(customTrie.contains('foo'), isFalse);
  });
}
