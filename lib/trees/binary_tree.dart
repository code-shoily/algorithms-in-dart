import 'binary_tree_adt.dart';

/// A binary node has at most two children, which are referred to as the
///  [left] child and the [right] child.
class BinaryNode<V extends Comparable> implements BinaryNodeADT<BinaryNode, V> {
  V value;

  // ignore: prefer_final_fields
  List<BinaryNode> _children = List(2);

  /// Creates a node with [value].
  BinaryNode(this.value);

  @override
  BinaryNode get left => _children[0];
  set left(BinaryNode node) => _children[0] = node;

  @override
  BinaryNode get right => _children[1];
  set right(BinaryNode node) => _children[1] = node;
}

/// A binary tree is defined recursively as a collection of
///  [BinaryNode]s (starting at a [root] node).
class BinaryTree<V extends Comparable> {
  /// Root of tree.
  BinaryNode root;

  /// Creates an empty Binary tree.
  BinaryTree();

  /// Creates a new Binary tree with a single [value].
  BinaryTree.withSingleValue(V value) : root = BinaryNode(value);
}
