import './binary_search_tree.dart';
import './binary_tree.dart';

/// Sentinel node to represent leaf nodes in [RedBlackTree].
final RedBlackNode nil = RedBlackNode.sentinalNode();

/// Color states a [RedBlackNode] can be in.
enum Color {
  /// Red colored node.
  red,

  /// Black colored node.
  black
}

/// Data structure similar to [_Node], differs in having connection to it's
///  [parent] and an extra [color] attribute.
class RedBlackNode<T extends Comparable> {
  /// Value of the node.
  T value;

  /// [color] of the node.
  Color color;

  /// [parent] of the node.
  RedBlackNode parent;

  /// [left] child node.
  RedBlackNode left;

  /// [right] child node.
  RedBlackNode right;

  /// Default constructor for a new node.
  RedBlackNode(this.value, this.parent) {
    color = Color.red;
    left = right = nil;
  }

  /// Creates root with [value].
  RedBlackNode.root(this.value) {
    color = Color.black;
    left = right = nil;
  }

  /// Creates a sentinal node.
  RedBlackNode.sentinalNode() : color = Color.black;
}

/// A self-balancing [BinarySearchTree].
///
/// [RedBlackTree] has following properties:
/// * Each node is either red or black.
/// * The [root] is black.
/// * All leaves ([nil]) are black.
/// * If a node is red, then both its children are black.
/// * Every path from a given node to any of its descendant [nil] nodes goes
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

  @override
  void delete(T value) {
    if (!isEmpty) {
      _delete(root, value);
    }
  }

  @override
  List<T> inOrder() {
    var result = <T>[];
    if (!isEmpty) {
      _inOrder(root, result);
    }
    return result;
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
      if (node.left != nil) {
        return _add(node.left, value);
      } else {
        return (node.left = RedBlackNode(value, node));
      }
    } else if (value.compareTo(node.value) > 0) {
      if (node.right != nil) {
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
      node.color = Color.black;
      return;
    }

    // [parent] is black, tree is valid.
    else if (parent.color == Color.black) {
      return;
    }

    // Double red problem encountered with red [uncle].
    else if (uncle.color == Color.red) {
      // Recolor [parent], [uncle] and [grandparent] of node.
      uncle.color = parent.color = Color.black;
      grandparent.color = Color.red;

      // Check if [grandparent] is not voilating any property.
      _addReorder(grandparent);
    }

    // Double red problem encountered with black or nil [uncle].
    else {
      // [parent] is left child.
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

      // [parent] is right child.
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

      grandparent.color = Color.red;
      parent.color = Color.black;
    }
  }

  bool _compareAndCheck(RedBlackNode node, T value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != nil ? _compareAndCheck(node.left, value) : false)
        : (node.right != nil ? _compareAndCheck(node.right, value) : false));
  }

  void _delete(RedBlackNode node, T value) {
    // Base Case, [value] not found.
    if (node == nil) return;

    if (node.value.compareTo(value) > 0) {
      _delete(node.left, value);
    } else if (node.value.compareTo(value) < 0) {
      _delete(node.right, value);
    } else {
      // [node] with [value] found.

      // [node] has two children.
      if (node.left != nil && node.right != nil) {
        // Successor to [node] is the next inOrder node.
        var successor = node.right;
        while (successor.left != nil) {
          successor = successor.left;
        }
        node.value = successor.value;
        _delete(node.right, successor.value);
      } else {
        // Delete [node] and reorder.
        node = _deleteReorder(node);
      }
    }
  }

  RedBlackNode _deleteReorder(RedBlackNode node) {
    // Childless red node.
    if (node.color == Color.red) {
      return nil;
    } else {
      // Childless black node.
      if (node.left == nil && node.right == nil) {
        var sibling = _sibling(node);
        var parent = _parent(node);
        var nearNephew = _nearNephew(node);
        var farNephew = _farNephew(node);

        // [sibling] is red.
        if (sibling?.color == Color.red) {
          if (parent.left == node) {
            _rotateLeft(parent);
          } else {
            _rotateRight(parent);
          }
          parent.color = Color.red;
          sibling.color = Color.black;
        }

        // [sibling] and both the nephews are black..
        if (sibling?.color == Color.black &&
            nearNephew.color == Color.black &&
            farNephew.color == Color.black) {
          // ..with red parent.
          if (parent.color == Color.red) {
            sibling.color = Color.red;
            parent.color = Color.black;
          }

          // ..with black parent.
          else {
            sibling.color = Color.red;
            _deleteReorder(parent);
          }
          return nil;
        }

        // [sibling] is black and at least one nephew is red.
        if (sibling?.color == Color.black &&
            (nearNephew.color == Color.red || farNephew.color == Color.red)) {
          // Far nephew is black.
          if (farNephew.color == Color.black) {
            if (node == parent.left) {
              _rotateRight(sibling);
            } else {
              _rotateLeft(sibling);
            }
            nearNephew.color = Color.black;
            sibling.color = Color.red;
          }

          // Far newphew is red.
          else {
            if (node == parent.left) {
              _rotateLeft(parent);
            } else {
              _rotateRight(parent);
            }
            sibling.color = parent.color;
            parent.color = farNephew.color = Color.black;
          }
          return nil;
        }

        // [node] is root
        return root = null;
      }

      // Black node with one child.
      else {
        RedBlackNode child;
        var parent = _parent(node);
        if (node.left != nil) {
          child = node.left;
        } else {
          child = node.right;
        }
        if (node == parent.left) {
          parent.left = child;
        } else {
          parent.right = child;
        }
        child.parent = parent;
        child.color = Color.black;
        return child;
      }
    }
  }

  /// Right child of [node]' sibling.
  RedBlackNode _farNephew(RedBlackNode node) {
    var sibling = _sibling(node);
    return sibling?.right;
  }

  /// Parent of [node]'s parent.
  RedBlackNode _grandParent(RedBlackNode node) => _parent(_parent(node));

  void _inOrder(RedBlackNode node, List<T> list) {
    if (node == nil) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  /// Left child of [node]' sibling.
  RedBlackNode _nearNephew(RedBlackNode node) {
    var sibling = _sibling(node);
    return sibling?.left;
  }

  /// Parent of [node].
  RedBlackNode _parent(RedBlackNode node) => node?.parent;

  void _postOrder(RedBlackNode node, List<T> list) {
    if (node == nil) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(RedBlackNode node, List<T> list) {
    if (node == nil) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }

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
    if (node.right != nil) {
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
    if (node.left != nil) {
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
