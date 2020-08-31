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

  /// Deletes `value` from the tree and updates `root`
  void delete(T value) {
    if (!isEmpty) {
      var ptr = root, parent;
      while (ptr != null) {
        if (ptr.value == value) {
          break;
        }
        parent = ptr;
        if (ptr.value.compareTo(value) > 0) {
          ptr = ptr.left;
        } else {
          ptr = ptr.right;
        }
      }

      if (ptr.left != null && ptr.right != null) {
        // node with 2 children
        root = _deleteNodeWithTwoChildren(root, parent, ptr);
      } else if (ptr.left != null) {
        // node with only left child
        root = _deleteNodeWithSingleChild(root, parent, ptr);
      } else if (ptr.right != null) {
        // node with only right child
        root = _deleteNodeWithSingleChild(root, parent, ptr);
      } else {
        // node with no child
        root = _deleteChildlessNode(root, parent, ptr);
      }
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

  Node<T> _deleteNodeWithTwoChildren(
    Node<T> root,
    Node<T> parent,
    Node<T> ptr,
  ) {
    var parsucc = ptr, succ = ptr.right;
    while (succ.left != null) {
      parsucc = succ;
      succ = succ.left;
    }
    ptr.value = succ.value;
    if (succ.left == null && succ.right == null) {
      root = _deleteChildlessNode(root, parsucc, succ);
    } else {
      root = _deleteNodeWithSingleChild(root, parsucc, succ);
    }

    return root;
  }

  Node<T> _deleteNodeWithSingleChild(
    Node<T> root,
    Node<T> parent,
    Node<T> ptr,
  ) {
    var child;
    if (ptr.left != null) {
      child = ptr.left;
    } else {
      child = ptr.right;
    }
    if (parent == null) {
      root = child;
    } else if (ptr == parent.left) {
      parent.left = child;
    } else {
      parent.right = child;
    }
    return root;
  }

  Node<T> _deleteChildlessNode(
    Node<T> root,
    Node<T> parent,
    Node<T> ptr,
  ) {
    if (parent == null) {
      root = null;
    } else if (ptr == parent.left) {
      parent.left = null;
    } else {
      parent.right = null;
    }
    return root;
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
