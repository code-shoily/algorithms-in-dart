import 'package:test/test.dart';
import 'package:algorithms_in_dart/trees/binary_search_tree.dart';

/// Adds left subtree to [root].
void _addLeft<T extends Comparable>(
    Node root, List<T> preOrder, List<T> inOrder) {
  root.left = Node(preOrder[0]);

  if (preOrder.length > 1) {
    createBinarySearchTree(root.left, preOrder, inOrder);
  }
}

/// Adds right subtree to [root].
void _addRight<T extends Comparable>(
    Node root, List<T> preOrder, List<T> inOrder) {
  root.right = Node(preOrder[0]);

  if (preOrder.length > 1) {
    createBinarySearchTree(root.right, preOrder, inOrder);
  }
}

/// Creates a Binary Search tree from the given [preOrder] and [inOrder]
///  traversals.
///
/// [root] must not be null.
void createBinarySearchTree<T extends Comparable>(
    Node root, List<T> preOrder, List<T> inOrder) {
  expect(root, isNotNull);
  expect(true, preOrder.length == inOrder.length);

  // [root] is the only node in subtree.
  if (preOrder.length <= 1) {
    return;
  }

  // [root] has only one child.
  else if (preOrder.length == 2) {
    if (preOrder[0] == inOrder[0]) {
      root.right = Node(preOrder[1]);
    } else {
      root.left = Node(preOrder[1]);
    }
  }

  // Multiple nodes present.
  else {
    // BST must have unique values.
    final uniqueValues = {...preOrder}.length == preOrder.length &&
        {...inOrder}.length == inOrder.length;
    expect(true, uniqueValues);

    // Index of [root] in [inOrder] list.
    var iIndex = inOrder.indexOf(preOrder[0]);

    // Set of values in the left subtree of [root].
    var set = {...inOrder.sublist(0, iIndex)};

    // Index of last value in the left subtree of [root] in [preOrder] list.
    var pIndex = preOrder.indexOf(set.last);
    for (var i = pIndex + 1; set.contains(preOrder[i]); i++) {
      pIndex = i;
    }

    _addLeft(root, preOrder.sublist(1, pIndex + 1), inOrder.sublist(0, iIndex));

    _addRight(root, preOrder.sublist(pIndex + 1), inOrder.sublist(iIndex + 1));
  }
}

/// Checks if [tree] is a valid Binary Search Tree or not.
///
/// If inOrder traversal of [tree] has values in order, it is valid.
bool isValidBinarySearchTree<T extends Comparable>(BinarySearchTree tree) {
  var inOrder = tree.inOrder();

  if (inOrder.isNotEmpty) {
    for (var i = 0; i < inOrder.length - 1; i++) {
      if (inOrder[i].compareTo(inOrder[i + 1]) > 0) return false;
    }
  }
  return true;
}

void main() {
  BinarySearchTree emptyTree, singleNodeTree, tree;
  setUp(() {
    emptyTree = BinarySearchTree();
    singleNodeTree = BinarySearchTree.withSingleValue(0);
    tree = BinarySearchTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
  });

  test('BST property', () {
    expect(true, isValidBinarySearchTree(tree));
  });

  test('Test empty tree', () {
    expect(emptyTree.isEmpty, isTrue);
    expect(singleNodeTree.isEmpty, isFalse);
    expect(tree.isEmpty, isFalse);
  });

  test('Test single node', () {
    expect(singleNodeTree.root.value, equals(0));
    expect(tree.root.value, equals(11));
  });

  test('Multiple node', () {
    /*----------------------
               11
             /    \
           -2     21
          /  \    /
        -3    1  17
             / \
            0   9
    ----------------------*/
    expect(tree.root.value, equals(11));
    expect(tree.root.left.value, equals(-2));
    expect(tree.root.left.left.value, equals(-3));
    expect(tree.root.left.left.left, isNull);
    expect(tree.root.left.left.right, isNull);
    expect(tree.root.left.right.value, equals(1));
    expect(tree.root.left.right.left.value, equals(0));
    expect(tree.root.left.right.left.left, isNull);
    expect(tree.root.left.right.left.right, isNull);
    expect(tree.root.left.right.right.value, equals(9));
    expect(tree.root.left.right.right.left, isNull);
    expect(tree.root.left.right.right.right, isNull);

    expect(tree.root.right.value, equals(21));
    expect(tree.root.right.right, isNull);
    expect(tree.root.right.left.value, equals(17));
    expect(tree.root.right.left.left, isNull);
    expect(tree.root.right.left.right, isNull);
  });

  test('Add', () {
    var ascendingTree = BinarySearchTree();
    ascendingTree.add(10);
    ascendingTree.add(20);
    ascendingTree.add(30);
    expect(ascendingTree.root.value, equals(10));
    expect(ascendingTree.root.right.value, equals(20));
    expect(ascendingTree.root.left, equals(null));
    expect(ascendingTree.root.right.right.value, equals(30));
    expect(ascendingTree.root.right.left, equals(null));
    expect(ascendingTree.root.right.right.left, isNull);
    expect(ascendingTree.root.right.right.right, isNull);

    var descendingTree = BinarySearchTree();
    descendingTree.add(-10);
    descendingTree.add(-20);
    descendingTree.add(-30);
    expect(descendingTree.root.value, equals(-10));
    expect(descendingTree.root.left.value, equals(-20));
    expect(descendingTree.root.right, equals(null));
    expect(descendingTree.root.left.left.value, equals(-30));
    expect(descendingTree.root.left.right, equals(null));
    expect(descendingTree.root.left.left.right, isNull);
    expect(descendingTree.root.left.left.left, isNull);
  });

  test('Nullify', () {
    var tree = BinarySearchTree.fromList([1, 2, 3]);
    tree.nullify();
    expect(tree.isEmpty, isTrue);
  });

  test('Check contains', () {
    expect(emptyTree.contains(10), isFalse);
    expect(singleNodeTree.contains(10), isFalse);
    expect(singleNodeTree.contains(0), isTrue);
    expect(tree.contains(1230), isFalse);

    for (var i in [11, -2, 1, 0, 21, 17, 9, -3]) {
      expect(tree.contains(i), isTrue);
    }
  });

  test('Pre-order traversal', () {
    expect(emptyTree.preOrder(), <int>[]);
    expect(singleNodeTree.preOrder(), <int>[0]);
    expect(tree.preOrder(), equals(<int>[11, -2, -3, 1, 0, 9, 21, 17]));
  });

  test('Post-order traversal', () {
    expect(emptyTree.postOrder(), <int>[]);
    expect(singleNodeTree.postOrder(), <int>[0]);
    expect(tree.postOrder(), equals(<int>[-3, 0, 9, 1, -2, 17, 21, 11]));
  });

  test('In-order traversal', () {
    expect(emptyTree.inOrder(), <int>[]);
    expect(singleNodeTree.inOrder(), <int>[0]);
    expect(tree.inOrder(), equals(<int>[-3, -2, 0, 1, 9, 11, 17, 21]));
  });

  test('Balance Tree', () {
    /*----------------------
      tree before balance()
             -1
            /  \
          -2    0
                 \
                  2
                   \
                    5
                   /
                  4
                 /
                3
    ----------------------*/
    var test = BinarySearchTree.fromList([-1, -2, 0, 2, 5, 4, 3]);
    test.balance();
    /*----------------------
      tree after balance()
              2
            /   \
          -1     4
          / \   / \
        -2   0 3   5
    ----------------------*/
    expect(test.preOrder(), equals(<int>[2, -1, -2, 0, 4, 3, 5]));
    expect(true, isValidBinarySearchTree(test));
  });

  test('Delete node', () {
    emptyTree.delete(1);
    expect(emptyTree.inOrder(), <int>[]);
    singleNodeTree.delete(0);
    expect(emptyTree.inOrder(), <int>[]);

    /*----------------------
               11
             /    \
           -2     21
          /  \    /
        -3    1  17
             / \
            0   9
    ----------------------*/

    var test = BinarySearchTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
    // delete node with no child
    test.delete(-3);
    expect(true, isValidBinarySearchTree(test));

    test = BinarySearchTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
    // delete node with one child
    test.delete(21);
    expect(true, isValidBinarySearchTree(test));

    test = BinarySearchTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
    // delete node with two children
    test.delete(-2);
    expect(true, isValidBinarySearchTree(test));

    test = BinarySearchTree.fromList([11, -2, 1, 0, 21, 17, 9, -3]);
    // delete root node
    test.delete(11);
    expect(true, isValidBinarySearchTree(test));
  });
}
