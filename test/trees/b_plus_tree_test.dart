import 'package:algorithms/trees/b_plus_tree.dart';
import 'package:test/test.dart';

void main() {
  late BPlusTree<int> emptyTree, singleNodeTree, multiNodeTree;
  late List<BPlusTree<int>> treeList;

  setUp(() {
    emptyTree = BPlusTree();
    singleNodeTree = BPlusTree.fromList([10]);
    multiNodeTree = BPlusTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
    treeList = [emptyTree, singleNodeTree, multiNodeTree];
  });

  test('Test empty tree', () {
    expect(emptyTree.isEmpty, isTrue);
    expect(singleNodeTree.isEmpty, isFalse);
    expect(multiNodeTree.isEmpty, isFalse);
  });

  test('Test single node', () {
    expect(singleNodeTree.root!.keys, equals([10]));
    expect(singleNodeTree.root!.isLeaf, isTrue);
  });

  test('Multiple nodes', () {
    for (var tree in treeList) {
      if (!tree.isEmpty) {
        expect(isSorted(tree.inOrder()), isTrue);
      }
    }
  });

  test('Add', () {
    var tree = BPlusTree<int>();
    tree.add(10);
    tree.add(20);
    tree.add(30);
    tree.add(5);
    tree.add(15);
    expect(tree.inOrder(), equals([5, 10, 15, 20, 30]));
    expect(isSorted(tree.inOrder()), isTrue);
  });

  test('Add duplicates', () {
    var tree = BPlusTree<int>.fromList([1, 2, 3, 2, 1]);
    expect(tree.inOrder(), equals([1, 2, 3]));
  });

  test('Nullify', () {
    var tree = BPlusTree<int>.fromList([1, 2, 3]);
    tree.nullify();
    expect(tree.isEmpty, isTrue);
  });

  test('Check contains', () {
    expect(emptyTree.contains(10), isFalse);
    expect(singleNodeTree.contains(10), isTrue);
    expect(singleNodeTree.contains(99), isFalse);
    expect(multiNodeTree.contains(1230), isFalse);

    for (var i in [11, -2, 1, 0, 21, 17, 9, -3]) {
      expect(multiNodeTree.contains(i), isTrue);
    }
  });

  test('In-order traversal', () {
    expect(emptyTree.inOrder(), <int>[]);
    expect(singleNodeTree.inOrder(), <int>[10]);
    expect(
      multiNodeTree.inOrder(),
      equals(<int>[-3, -2, 0, 1, 9, 11, 17, 21]),
    );
  });

  group('Delete ', () {
    test('Delete from empty tree', () {
      emptyTree.delete(1);
      expect(emptyTree.isEmpty, isTrue);
    });

    test('Delete single node', () {
      singleNodeTree.delete(10);
      expect(singleNodeTree.isEmpty, isTrue);
    });

    test('Delete leaf key', () {
      var tree = BPlusTree<int>.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
      tree.delete(-3);
      expect(tree.contains(-3), isFalse);
      expect(isSorted(tree.inOrder()), isTrue);
    });

    test('Delete causing borrow from right', () {
      var tree = BPlusTree<int>.fromList([1, 2, 3, 4, 5]);
      tree.delete(1);
      expect(tree.contains(1), isFalse);
      expect(isSorted(tree.inOrder()), isTrue);
    });

    test('Delete causing borrow from left', () {
      var tree = BPlusTree<int>.fromList([1, 2, 3, 4, 5, 6, 7]);
      tree.delete(7);
      expect(tree.contains(7), isFalse);
      expect(isSorted(tree.inOrder()), isTrue);
    });

    test('Delete causing merge', () {
      var tree = BPlusTree<int>.fromList([1, 2, 3, 4, 5]);
      tree.delete(3);
      expect(tree.contains(3), isFalse);
      expect(tree.inOrder(), equals([1, 2, 4, 5]));
    });

    test('Delete all nodes one by one', () {
      var values = [11, -2, 1, 0, 21, 17, 9, -3];
      var tree = BPlusTree<int>.fromList(values);
      for (var value in values) {
        tree.delete(value);
        expect(tree.contains(value), isFalse);
        expect(isSorted(tree.inOrder()), isTrue);
      }
      expect(tree.isEmpty, isTrue);
    });
  });

  test('Range search', () {
    var tree = BPlusTree<int>.fromList([10, 20, 30, 40, 50, 60, 70]);
    expect(tree.rangeSearch(25, 55), equals([30, 40, 50]));
    expect(tree.rangeSearch(60, 100), equals([60, 70]));
    expect(tree.rangeSearch(0, 15), equals([10]));
    expect(tree.rangeSearch(80, 100), isEmpty);
  });

  test('Higher degree tree', () {
    var tree = BPlusTree<int>(degree: 3);
    for (var i = 1; i <= 20; i++) {
      tree.add(i);
    }
    expect(tree.inOrder(), equals(List.generate(20, (i) => i + 1)));
    expect(isSorted(tree.inOrder()), isTrue);

    for (var i = 1; i <= 20; i++) {
      expect(tree.contains(i), isTrue);
    }
  });
}

bool isSorted(List<int> list) {
  for (var i = 0; i < list.length - 1; i++) {
    if (list[i] > list[i + 1]) return false;
  }
  return true;
}
