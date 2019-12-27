class Node<T extends Comparable> {
  /// Value of the node
  T value;

  /// Left node
  Node<T> left;

  /// Right node
  Node<T> right;

  Node(this.value);
}

class BinaryTree<T extends Comparable> {
  Node<T> _root;

  /// Root of the tree
  Node<T> get root => _root;

  /// Creates and empty binary tree
  BinaryTree();

  /// Creates a binary tree with all values of `list` added
  BinaryTree.fromList(List<T> list) {
    for (var value in list) add(value);
  }

  /// Creates a new tree with a single value of `value`
  BinaryTree.withSingleValue(T value) : _root = Node(value);

  /// Tests if this tree is empty
  bool get isEmpty => _root == null;

  /// Empty the tree
  void nullify() => _root = null;

  /// Adds `value` to the tree
  void add(T value) {
    var node = Node(value);
    if (isEmpty) {
      this._root = node;
    } else {
      _compareAndAdd(_root, node);
    }
  }

  void _compareAndAdd(Node<T> root, Node<T> newNode) {
    if (root.value.compareTo(newNode.value) >= 0) {
      if (root.left == null)
        root.left = newNode;
      else
        _compareAndAdd(root.left, newNode);
    } else {
      if (root.right == null)
        root.right = newNode;
      else
        _compareAndAdd(root.right, newNode);
    }
  }

  /// Checks if `value` is contained in the tree
  bool contains(T value) => isEmpty ? false : _compareAndCheck(_root, value);

  bool _compareAndCheck(Node<T> root, T value) {
    if (root.value == value) return true;
    return (root.value.compareTo(value) >= 0
        ? (root.left != null ? _compareAndCheck(root.left, value) : false)
        : (root.right != null ? _compareAndCheck(root.right, value) : false));
  }
}
