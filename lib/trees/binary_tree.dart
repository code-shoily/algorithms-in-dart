/// Defines the methods common to all the variations of a Binary Tree.
abstract class BinaryTree<T extends Comparable> {
  /// Adds [value] to the tree.
  void add(T value);

  /// Checks if [value] is contained in the tree.
  bool contains(T value);

  /// Deletes [value] from the tree and updates it's [root].
  void delete(T value);

  /// In Order Traversal.
  List<T> inOrder();

  /// Empty the tree.
  void nullify();

  /// PostOrder Traversal.
  List<T> postOrder();

  /// PreOrder Traversal.
  List<T> preOrder();
}
