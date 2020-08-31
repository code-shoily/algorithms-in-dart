/// Data structure containing `value` and connection to children
class Node<T extends Comparable> {
  /// Value of the node
  T value;

  /// Left child node
  Node<T> left;

  /// Right child node
  Node<T> right;

  /// Creates a node with `value`
  Node(this.value);
}

/// Hierarchical data structure of individual `Node`.
class BinaryTree<T extends Comparable> {
  /// Root of the tree
  Node<T> root;

  /// Creates an empty binary tree
  BinaryTree();

  /// Creates a binary tree with all values of `list` added.
  /// First value becomes `root`.
  BinaryTree.fromList(List<T> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new tree with a single value of `value`
  BinaryTree.withSingleValue(T value) : root = Node(value);

  /// Tests if this tree is empty
  bool get isEmpty => root == null;

  /// Empty the tree
  void nullify() => root = null;

  /// Adds `value` to the tree
  void add(T value) {
    var node = Node(value);
    if (isEmpty) {
      root = node;
    } else {
      _compareAndAdd(root, node);
    }
  }

  void _compareAndAdd(Node<T> root, Node<T> newNode) {
    // Don't allow duplicate values in Binary Search Tree
    if (root.value == newNode.value) {
      return;
    }

    if (root.value.compareTo(newNode.value) > 0) {
      if (root.left == null) {
        root.left = newNode;
      } else {
        _compareAndAdd(root.left, newNode);
      }
    } else {
      if (root.right == null) {
        root.right = newNode;
      } else {
        _compareAndAdd(root.right, newNode);
      }
    }
  }

  /// Deletes `value` from the tree and updates `root`
  void delete(T value) {
    if (!isEmpty) {
      root = _delete(root, value);
    }
  }

  Node<T> _delete(Node<T> node, T value) {
    if (node == null) return node;

    if (value.compareTo(node.value) < 0) {
      node.left = _delete(node.left, value);
    } else if (value.compareTo(node.value) > 0) {
      node.right = _delete(node.right, value);
    } else {
      if (node.left != null && node.right != null) {
        // successor to the node is the next inOrder node
        var successor = node.right;
        while (successor.left != null) {
          successor = successor.left;
        }
        node.value = successor.value;
        node.right = _delete(node.right, successor.value);
      } else {
        if (node.left != null) {
          node = node.left;
        } else if (node.right != null) {
          node = node.right;
        } else {
          node = null;
        }
      }
    }
    return node;
  }

  /// Checks if `value` is contained in the tree
  bool contains(T value) => isEmpty ? false : _compareAndCheck(root, value);

  bool _compareAndCheck(Node<T> root, T value) {
    if (root.value == value) return true;
    return (root.value.compareTo(value) >= 0
        ? (root.left != null ? _compareAndCheck(root.left, value) : false)
        : (root.right != null ? _compareAndCheck(root.right, value) : false));
  }

  /// PreOrder Traversal
  List<T> preOrder() {
    var result = <T>[];
    _preOrder(root, result);
    return result;
  }

  void _preOrder(Node<T> node, List<T> list) {
    if (node == null) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }

  /// PostOrder Traversal
  List<T> postOrder() {
    var result = <T>[];
    _postOrder(root, result);
    return result;
  }

  void _postOrder(Node<T> node, List<T> list) {
    if (node == null) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  /// In Order Traversal
  List<T> inOrder() {
    var result = <T>[];
    _inOrder(root, result);
    return result;
  }

  void _inOrder(Node<T> node, List<T> list) {
    if (node == null) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }
}
