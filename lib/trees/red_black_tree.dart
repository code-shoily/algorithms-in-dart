import './binary_search_tree.dart';
import './binary_tree.dart';

/// Sentinel node to represent leaf nodes in [RedBlackTree].
final RedBlackNode _nil = RedBlackNode.sentinalNode();

enum _Color { red, black }

/// A self-balancing [BinarySearchTree].
///
/// [RedBlackTree] has following properties:
/// * Each node is either red or black.
/// * The [root] is black.
/// * All leaves ([_nil]) are black.
/// * If a node is red, then both its children are black.
/// * Every path from a given node to any of its descendant [_nil] nodes goes
///    through the same number of black nodes.
class RedBlackTree<T extends Comparable> implements BinaryTree<T> {
  /// Root of the tree.
  RedBlackNode root;

  /// Creates an empty Red Back tree.
  RedBlackTree();

  /// Creates a Red Back tree with all the values of [list].
  RedBlackTree.fromList(List<T> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new Red Back tree with a single [value].
  RedBlackTree.withSingleValue(T value) {
    root = RedBlackNode.root(value);
  }

  /// Tests if this tree is empty.
  bool get isEmpty => root == null;

  @override
  void add(T value) {
    root = isEmpty ? RedBlackNode.root(value) : _add(root, value);

    _addReorder(root);

    while (_parent(root) != null) {
      root = _parent(root);
    }
  }

  @override
  bool contains(T value) => isEmpty ? false : _compareAndCheck(root, value);

  bool _compareAndCheck(RedBlackNode node, T value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != null ? _compareAndCheck(node.left, value) : false)
        : (node.right != null ? _compareAndCheck(node.right, value) : false));
  }

  @override
  void delete(T value) {
    // TODO: implement delete
  }

  @override
  List<T> inOrder() {
    var result = <T>[];
    if (!isEmpty) {
      _inOrder(root, result);
    }
    return result;
  }

  void _inOrder(RedBlackNode node, List<T> list) {
    if (node == _nil) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  void _postOrder(RedBlackNode node, List<T> list) {
    if (node == _nil) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(RedBlackNode node, List<T> list) {
    if (node == _nil) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }

  @override
  void nullify() {
    root = null;
  }

  @override
  List<T> postOrder() {
    var result = <T>[];
    if (!isEmpty) {
      _postOrder(root, result);
    }
    return result;
  }

  @override
  List<T> preOrder() {
    var result = <T>[];
    if (!isEmpty) {
      _preOrder(root, result);
    }
    return result;
  }

  RedBlackNode _add(RedBlackNode node, T value) {
    if (value.compareTo(node.value) < 0) {
      if (node.left != _nil) {
        return _add(node.left, value);
      } else {
        return (node.left = RedBlackNode(value, node));
      }
    } else if (value.compareTo(node.value) > 0) {
      if (node.right != _nil) {
        return _add(node.right, value);
      } else {
        return (node.right = RedBlackNode(value, node));
      }
    } else {
      // Duplicate value found.
      return root;
    }
  }

  void _addReorder(RedBlackNode node) {
    var parent = _parent(node);
    var uncle = _uncle(node);
    var grandparent = _grandParent(node);

    // [node] is [root].
    if (parent == null) {
      node.color = _Color.black;
      return;
    }

    // [parent] is black, tree is valid.
    else if (parent.color == _Color.black) {
      return;
    }

    // Double red problem encountered with red [uncle].
    else if (uncle != _nil && uncle.color == _Color.red) {
      // Recolor [parent], [uncle] and [grandparent] of node.
      uncle.color = parent.color = _Color.black;
      grandparent.color = _Color.red;

      // Check if [grandparent] is not voilating any property.
      _addReorder(grandparent);
    }

    // Double red problem encountered with black or nil [uncle].
    else {
      // Parent is left child.
      if (parent == grandparent.left) {
        // [node] is right child, rotate left about [parent].
        if (node == parent.right) {
          _rotateLeft(parent);

          // Update [parent] and [node].
          parent = grandparent.left;
          node = parent.left;
        }

        // [node] is left child, rotate right about [grandparent].
        _rotateRight(grandparent);
      }

      // Parent is right child.
      else if (parent == grandparent.right) {
        // [node] is left child, rotate right about [parent].
        if (node == parent.left) {
          _rotateRight(parent);

          // Update [parent] and [node].
          parent = grandparent.right;
          node = parent.right;
        }

        // [node] is right child, rotate left about [grandparent].
        _rotateLeft(grandparent);
      }

      grandparent.color = _Color.red;
      parent.color = _Color.black;
    }
  }

  /// Parent of [node]'s parent.
  RedBlackNode _grandParent(RedBlackNode node) => _parent(_parent(node));

  /// Parent of [node].
  RedBlackNode _parent(RedBlackNode node) => node?.parent;

  /// Rotates [node] N to left and makes C it's parent.
  ///
  ///          N                 C
  ///         /↶\              /  \
  ///             C     ⟶     N
  ///            / \          / \
  ///           ⬤               ⬤
  /// Left subtree of C becomes right subtree of N.
  _rotateLeft(RedBlackNode node) {
    var child = node.right;
    var parent = _parent(node);

    node.right = child.left;
    child.left = node;
    node.parent = child;

    // Update other parent/child connections.
    if (node.right != _nil) {
      node.right.parent = node;
    }

    // In case [node] is not [root].
    if (parent != null) {
      if (node == parent.left) {
        parent.left = child;
      } else if (node == parent.right) {
        parent.right = child;
      }
    }

    child.parent = parent;
  }

  /// Rotates [node] N to right and makes C it's parent.
  ///
  ///            N             C
  ///           /↷\    ⟶    /  \
  ///          C                  N
  ///         / \                / \
  ///            ⬤             ⬤
  /// Right subtree of C becomes left subtree of N.
  _rotateRight(RedBlackNode node) {
    var child = node.left;
    var parent = _parent(node);

    node.left = child.right;
    child.right = node;
    node.parent = child;

    // Update other parent/child connections.
    if (node.left != _nil) {
      node.left.parent = node;
    }

    // In case [node] is not [root].
    if (parent != null) {
      if (node == parent.left) {
        parent.left = child;
      } else if (node == parent.right) {
        parent.right = child;
      }
    }

    child.parent = parent;
  }

  /// Sibling of [node].
  RedBlackNode _sibling(RedBlackNode node) {
    var parent = _parent(node);
    return node == parent?.left ? parent?.right : parent?.left;
  }

  /// Sibling of [node]'s parent.
  RedBlackNode _uncle(RedBlackNode node) {
    var parent = _parent(node);
    return (_sibling(parent));
  }
}

/// Data structure similar to [_Node], differs in having connection to it's
///  [parent] and an extra [color] attribute.
class RedBlackNode<T extends Comparable> {
  /// Value of the node.
  T value;

  /// [color] of the node.
  _Color color;

  /// [parent] of the node.
  RedBlackNode<T> parent;

  /// [left] child node.
  RedBlackNode<T> left;

  /// [right] child node.
  RedBlackNode<T> right;

  /// Default constructor for a new node.
  RedBlackNode(this.value, this.parent) {
    color = _Color.red;
    left = right = _nil;
  }

  /// Creates root with [value].
  RedBlackNode.root(this.value) {
    color = _Color.black;
    left = right = _nil;
  }

  /// Creates a sentinal node.
  RedBlackNode.sentinalNode() : color = _Color.black;
}
