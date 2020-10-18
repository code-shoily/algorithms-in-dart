/// A node consists of a [value],
///  together with a list of references to nodes (the [_children]),
///  with the constraints that no reference is duplicated,
///  and none points to the root.
abstract class NodeADT<N, V extends Comparable> {
  /// [value] of the node.
  V value;

  /// List of children this node is connected to.
  List<N> children;
}

/// A tree data structure can be defined recursively as a collection of nodes
///  (starting at a [root] node).
abstract class TreeADT<N extends NodeADT, V extends Comparable> {
  /// Root of tree.
  N root;

  /// Tests if this tree is empty.
  bool get isEmpty;

  /// Adds [value] to the tree.
  void add(V value);

  /// Checks if [value] is contained in the tree.
  bool contains(V value);

  /// Deletes [value] from the tree and updates it's [root].
  void delete(V value);

  /// In Order Traversal.
  List<V> inOrder();

  /// Empty the tree.
  void nullify();

  /// PostOrder Traversal.
  List<V> postOrder();

  /// PreOrder Traversal.
  List<V> preOrder();
}
