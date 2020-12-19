import 'package:algorithms/trees/avl_tree.dart';
import 'package:algorithms/trees/binary_search_tree.dart';
import 'package:test/test.dart';

import 'binary_search_tree_test.dart';

void main() {
  late AvlTree<String> emptyTree, multipleNodetree;
  late AvlTree<int> singleNodeTree;
  setUp(() {
    emptyTree = AvlTree();
    singleNodeTree = AvlTree.withSingleValue(0);

    /*----------------------
        tree:
                n
               / \
              /   \
             /     \ 
            i       p
           / \     / \ 
          h   l   o   q
         /   / \
        a   k   m
    ----------------------*/
    multipleNodetree =
        AvlTree.fromList(['m', 'n', 'o', 'l', 'k', 'q', 'p', 'h', 'i', 'a']);
  });

  test('Test empty tree', () {
    expect(emptyTree.isEmpty, isTrue);
    expect(singleNodeTree.isEmpty, isFalse);
    expect(multipleNodetree.isEmpty, isFalse);
  });

  test('Test single node tree', () {
    expect(singleNodeTree.root!.value, equals(0));
    expect(multipleNodetree.root!.value, equals('n'));
  });

  test('Multiple node tree', () {
    /*----------------------
               1
                n
               / \
              /   \
             /     \ 
            i       p
         1 / \     / \ 
          h   l   o   q
         /   / \
        a   k   m
    ----------------------*/
    expect(multipleNodetree.root!.value, equals('n'));
    expect(multipleNodetree.root!.balanceFactor, equals(1));

    expect(multipleNodetree.root!.left!.value, equals('i'));
    expect(multipleNodetree.root!.left!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.left!.left!.value, equals('h'));
    expect(multipleNodetree.root!.left!.left!.balanceFactor, equals(1));
    expect(multipleNodetree.root!.left!.left!.left!.value, equals('a'));
    expect(multipleNodetree.root!.left!.left!.left!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.left!.left!.left!.left, isNull);
    expect(multipleNodetree.root!.left!.left!.left!.right, isNull);
    expect(multipleNodetree.root!.left!.right!.value, equals('l'));
    expect(multipleNodetree.root!.left!.right!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.left!.right!.left!.value, equals('k'));
    expect(multipleNodetree.root!.left!.right!.left!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.left!.right!.left!.left, isNull);
    expect(multipleNodetree.root!.left!.right!.left!.right, isNull);
    expect(multipleNodetree.root!.left!.right!.right!.value, equals('m'));
    expect(multipleNodetree.root!.left!.right!.right!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.left!.right!.right!.left, isNull);
    expect(multipleNodetree.root!.left!.right!.right!.right, isNull);

    expect(multipleNodetree.root!.right!.value, equals('p'));
    expect(multipleNodetree.root!.right!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.right!.left!.value, equals('o'));
    expect(multipleNodetree.root!.right!.left!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.right!.left!.left, isNull);
    expect(multipleNodetree.root!.right!.left!.right, isNull);
    expect(multipleNodetree.root!.right!.right!.value, equals('q'));
    expect(multipleNodetree.root!.right!.right!.balanceFactor, equals(0));
    expect(multipleNodetree.root!.right!.right!.left, isNull);
    expect(multipleNodetree.root!.right!.right!.right, isNull);
  });

  test('Add', () {
    var avlTree = AvlTree<int>();
    avlTree.add(50);
    expect(avlTree.preOrder(), <int>[50]);
    avlTree.add(40);
    expect(avlTree.preOrder(), <int>[50, 40]);

    avlTree.add(35);
    // RR: Right rotation about 50
    expect(true, isValidAvlTree(multipleNodetree));
    avlTree.add(58);
    expect(true, isValidAvlTree(multipleNodetree));
    avlTree.add(48);
    expect(true, isValidAvlTree(multipleNodetree));

    avlTree.add(42);
    // RL: Right rotation about 50, Left rotation about 40
    expect(true, isValidAvlTree(multipleNodetree));

    avlTree.add(60);
    // LL: Left rotation about 50
    expect(true, isValidAvlTree(multipleNodetree));
    avlTree.add(30);
    expect(true, isValidAvlTree(multipleNodetree));

    avlTree.add(33);
    // LR: Left rotation about 30, Right rotation about 35
    expect(true, isValidAvlTree(multipleNodetree));

    avlTree.add(25);
    // RR: Right rotation about 40
    expect(true, isValidAvlTree(multipleNodetree));
  });

  test('Nullify', () {
    var tree = AvlTree<int>.fromList([1, 2, 3]);
    tree.nullify();
    expect(tree.isEmpty, isTrue);
  });

  test('Check contains', () {
    expect(emptyTree.contains('10'), isFalse);

    expect(singleNodeTree.contains(10), isFalse);
    expect(singleNodeTree.contains(0), isTrue);

    expect(multipleNodetree.contains('z'), isFalse);
    for (var i in ['m', 'n', 'o', 'l', 'k', 'q', 'p', 'h', 'i', 'a']) {
      expect(multipleNodetree.contains(i), isTrue);
    }
  });

  group('Traversal', () {
    test('Pre-order', () {
      expect(emptyTree.preOrder(), <int>[]);
      expect(singleNodeTree.preOrder(), <int>[0]);
      expect(multipleNodetree.preOrder(),
          equals(<String>['n', 'i', 'h', 'a', 'l', 'k', 'm', 'p', 'o', 'q']));
    });

    test('Post-order', () {
      expect(emptyTree.postOrder(), <int>[]);
      expect(singleNodeTree.postOrder(), <int>[0]);
      expect(multipleNodetree.postOrder(),
          equals(<String>['a', 'h', 'k', 'm', 'l', 'i', 'o', 'q', 'p', 'n']));
    });

    test('In-order', () {
      expect(emptyTree.inOrder(), <int>[]);
      expect(singleNodeTree.inOrder(), <int>[0]);
      expect(multipleNodetree.inOrder(),
          equals(<String>['a', 'h', 'i', 'k', 'l', 'm', 'n', 'o', 'p', 'q']));
    });
  });

  test('Delete node', () {
    emptyTree.delete('1');
    expect(emptyTree.inOrder(), <int>[]);

    singleNodeTree.delete(0);
    expect(emptyTree.inOrder(), <int>[]);

    multipleNodetree.delete('q');
    expect(true, isValidAvlTree(multipleNodetree));
    multipleNodetree.delete('n');
    // RR: Right rotation about 'o'
    expect(true, isValidAvlTree(multipleNodetree));

    multipleNodetree.delete('a');
    // RL: Right rotation about 'o', Left rotation about 'i'
    expect(true, isValidAvlTree(multipleNodetree));
    multipleNodetree.delete('h');
    expect(true, isValidAvlTree(multipleNodetree));
    multipleNodetree.delete('k');
    expect(true, isValidAvlTree(multipleNodetree));

    multipleNodetree.delete('i');
    // LL: Left rotation about 'l'
    expect(true, isValidAvlTree(multipleNodetree));

    multipleNodetree.delete('p');
    // LR: Left rotation about 'l', Right rotation about 'o'
    expect(true, isValidAvlTree(multipleNodetree));
  });
}

/// Checks if [tree] is a valid Avl tree or not.
///
/// Valid Avl tree must be a valid Binary Search tree
///  and balance (difference between height of left and right subtree) of all
///  it's nodes must belong to the set `{-1, 0, 1}`.
bool isValidAvlTree(AvlTree<Comparable> tree) {
  if (tree.isEmpty) return true;

  var test = BinarySearchTree.withSingleValue(tree.root!.value!);
  createBinarySearchTree(test.root!, tree.preOrder(), tree.inOrder());
  expect(true, isValidBinarySearchTree(test));

  var balance = _leftBalance(tree.root!.left) + _rightBlance(tree.root!.right);
  return -1 <= balance && balance <= 1 ? true : false;
}

/// Returns height of left sub-tree, a positive integer.
int _leftBalance(AvlNode? node) {
  if (node == null) return 0;

  // [left] and [right] are heights of respective sub-trees.
  var left = _leftBalance(node.left);
  var right = _rightBlance(node.right);

  var balance = left + right;
  expect(true, -1 <= balance && balance <= 1);

  // Add [node] to either [left] or [right], whichever is bigger.
  return 1 + (left >= right.abs() ? left : right.abs());
}

/// Returns height of right sub-tree, a negative integer.
int _rightBlance(AvlNode? node) {
  if (node == null) return 0;

  // [left] and [right] are heights of respective sub-trees.
  var left = _leftBalance(node.left);
  var right = _rightBlance(node.right);

  var balance = left + right;
  expect(true, -1 <= balance && balance <= 1);

  // Add [node] to either [left] or [right], whichever is bigger.
  return (right.abs() >= left ? right : -left) - 1;
}
