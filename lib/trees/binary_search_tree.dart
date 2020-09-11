import './binary_tree.dart';

/// Hierarchical data structure of individual [_Node]s.
///
/// Every [_Node] of Binary Seach Tree(BST) has following properties:
/// * It's left subtree has nodes which have lesser value.
/// * It's right subtree has nodes which have greater value.
/// * Left and right subtrees are also be BST.
class BinarySearchTree<T extends Comparable> implements BinaryTree<T> {
  /// Root of the tree
  _Node<T> root;

  /// Creates an empty BST.
  BinarySearchTree();

  /// Creates a BST with all the values of [list].
  BinarySearchTree.fromList(List<T> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new BST with a single [value].
  BinarySearchTree.withSingleValue(T value) : root = _Node(value);

  /// Tests if this tree is empty.
  bool get isEmpty => root == null;

  @override
  void add(T value) {
    var node = _Node(value);
    if (isEmpty) {
      root = node;
    } else {
      _compareAndAdd(root, node);
    }
  }

  /// Balances the height of the binary tree.
  void balance() {
    var list = inOrder();
    if (list.length > 2) {
      nullify();
      _balance(list);
    }
  }

  @override
  bool contains(T value) => isEmpty ? false : _compareAndCheck(root, value);

  @override
  void delete(T value) {
    if (!isEmpty) {
      root = _delete(root, value);
    }
  }

  @override
  List<T> inOrder() {
    var result = <T>[];
    _inOrder(root, result);
    return result;
  }

  @override
  void nullify() => root = null;

  @override
  List<T> postOrder() {
    var result = <T>[];
    _postOrder(root, result);
    return result;
  }

  @override
  List<T> preOrder() {
    var result = <T>[];
    _preOrder(root, result);
    return result;
  }

  void _balance(List<T> list) {
    if (list.length == 0) return;
    var middle = list.length ~/ 2;
    add(list[middle]);
    _balance(list.sublist(0, middle));
    _balance(list.sublist(middle + 1));
  }

  void _compareAndAdd(_Node<T> node, _Node<T> newNode) {
    // Don't allow duplicate values in Binary Search Tree.
    if (node.value == newNode.value) {
      return;
    }

    if (node.value.compareTo(newNode.value) > 0) {
      if (node.left == null) {
        // newNode has lower value and becomes left child of the node.
        node.left = newNode;
      } else {
        _compareAndAdd(node.left, newNode);
      }
    } else {
      if (node.right == null) {
        // newNode has greater value and becomes right child of node.
        node.right = newNode;
      } else {
        _compareAndAdd(node.right, newNode);
      }
    }
  }

  bool _compareAndCheck(_Node<T> node, T value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != null ? _compareAndCheck(node.left, value) : false)
        : (node.right != null ? _compareAndCheck(node.right, value) : false));
  }

  _Node<T> _delete(_Node<T> node, T value) {
    // Base Case, Key not found
    if (node == null) return node;

    if (node.value.compareTo(value) > 0) {
      node.left = _delete(node.left, value);
    } else if (node.value.compareTo(value) < 0) {
      node.right = _delete(node.right, value);
    } else {
      // Node with value found.

      // Node has two children.
      if (node.left != null && node.right != null) {
        // Successor to the node is the next inOrder node.
        var successor = node.right;
        while (successor.left != null) {
          successor = successor.left;
        }
        node.value = successor.value;
        node.right = _delete(node.right, successor.value);
      } else {
        if (node.left != null) {
          // Node only has left child.
          node = node.left;
        } else if (node.right != null) {
          // Node only has right child.
          node = node.right;
        } else {
          // Childless node.
          node = null;
        }
      }
    }
    return node;
  }

  void _inOrder(_Node<T> node, List<T> list) {
    if (node == null) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  void _postOrder(_Node<T> node, List<T> list) {
    if (node == null) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(_Node<T> node, List<T> list) {
    if (node == null) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }
}

/// Data structure containing a [value] and connection to children.
class _Node<T extends Comparable> {
  /// Value of the node.
  T value;

  /// [left] child node.
  _Node<T> left;

  /// [right] child node.
  _Node<T> right;

  /// Creates a node with [value].
  _Node(this.value);
}
