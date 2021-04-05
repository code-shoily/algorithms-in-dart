import 'adt/binary_tree_adt.dart';

/// A binary node has at most two children, which are referred to as the
///  [left] child and the [right] child.
class BinaryNode<V extends Comparable> extends BinaryNodeADT<BinaryNode<V>, V> {
  V? value;

  /// Creates a node with [value].
  BinaryNode(this.value);
}

/// A binary tree is defined recursively as a collection of
///  [BinaryNode]s (starting at a [root] node).
class BinaryTree<V extends Comparable> {
  /// Root of tree.
  BinaryNode? root;

  /// Creates an empty Binary tree.
  BinaryTree();

  /// Creates a new Binary tree with a single [value].
  BinaryTree.withSingleValue(V value) : root = BinaryNode(value);
}
