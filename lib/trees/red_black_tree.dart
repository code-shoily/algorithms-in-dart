import 'adt/binary_tree_adt.dart';
import 'binary_search_tree.dart';
import 'binary_tree.dart';

/// Color states a [RedBlackNode] can be in.
enum Color {
  /// Red colored node.
  red,

  /// Black colored node.
  black
}

/// Data structure similar to [BinaryNode], differs in having connection to it's
///  [parent] and an extra [color] attribute.
class RedBlackNode<V extends Comparable>
    extends BinaryNodeADT<RedBlackNode<V>, V> {
  /// Value of the node.
  V? value;

  /// [color] of the node.
  late Color color;

  /// [parent] of the node.
  RedBlackNode<V>? parent;

  /// Default constructor for a new node.
  RedBlackNode(this.value, this.parent, RedBlackNode<V> nil) {
    color = Color.red;
    left = right = nil;
  }

  /// Creates root with [value].
  RedBlackNode.root(this.value, RedBlackNode<V> nil) {
    color = Color.black;
    left = right = nil;
  }

  /// Creates a sentinel node.
  RedBlackNode.sentinelNode() : color = Color.black;
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
class RedBlackTree<V extends Comparable>
    extends BinaryTreeADT<RedBlackNode<V>, V> {
  /// Designated node used as a traversal path terminator. This node does not
  /// hold or reference any data managed by the [RedBlackTree].
  RedBlackNode<V> nil = RedBlackNode<V>.sentinelNode();

  /// Root of the tree.
  RedBlackNode<V>? root;

  /// Creates an empty Red Back tree.
  RedBlackTree();

  /// Creates a Red Back tree with all the values of [list].
  RedBlackTree.fromList(List<V> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new Red Back tree with a single [value].
  RedBlackTree.withSingleValue(V value) {
    root = RedBlackNode.root(value, nil);
  }

  @override
  void add(V value) {
    root = isEmpty ? RedBlackNode<V>.root(value, nil) : _add(root!, value);

    _addReorder(root!);

    // Update root.
    while (_parent(root!) != null) {
      root = _parent(root);
    }
  }

  @override
  bool contains(V value) => isEmpty ? false : _compareAndCheck(root!, value);

  @override
  void delete(V value) {
    if (!isEmpty) {
      _delete(root!, value);
    }

    // Update root.
    while (_parent(root) != null) {
      root = _parent(root);
    }
  }

  @override
  List<V> inOrder() {
    var result = <V>[];
    if (!isEmpty) {
      _inOrder(root!, result);
    }
    return result;
  }

  @override
  List<V> postOrder() {
    var result = <V>[];
    if (!isEmpty) {
      _postOrder(root!, result);
    }
    return result;
  }

  @override
  List<V> preOrder() {
    var result = <V>[];
    if (!isEmpty) {
      _preOrder(root!, result);
    }
    return result;
  }

  RedBlackNode<V> _add(RedBlackNode<V> node, V value) {
    if (value.compareTo(node.value) < 0) {
      if (node.left != nil) {
        return _add(node.left!, value);
      } else {
        return (node.left = RedBlackNode<V>(value, node, nil));
      }
    } else if (value.compareTo(node.value) > 0) {
      if (node.right != nil) {
        return _add(node.right!, value);
      } else {
        return (node.right = RedBlackNode<V>(value, node, nil));
      }
    } else {
      // Duplicate value found.
      return root!;
    }
  }

  void _addReorder(RedBlackNode<V> node) {
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
    else if (uncle!.color == Color.red) {
      // Recolor [parent], [uncle] and [grandparent] of node.
      uncle.color = parent.color = Color.black;
      grandparent!.color = Color.red;

      // Check if [grandparent] is not violating any property.
      _addReorder(grandparent);
    }

    // Double red problem encountered with black [uncle].
    else {
      // [parent] is left child.
      if (parent == grandparent!.left) {
        // [node] is right child, rotate left about [parent].
        if (node == parent.right) {
          _rotateLeft(parent);

          // Update [parent] and [node].
          parent = grandparent.left;
          node = parent!.left!;
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
          node = parent!.right!;
        }

        // [node] is right child, rotate left about [grandparent].
        _rotateLeft(grandparent);
      }

      grandparent.color = Color.red;
      parent.color = Color.black;
    }
  }

  bool _compareAndCheck(RedBlackNode<V> node, V value) {
    if (node.value == value) return true;
    return (node.value!.compareTo(value) >= 0
        ? (node.left != nil ? _compareAndCheck(node.left!, value) : false)
        : (node.right != nil ? _compareAndCheck(node.right!, value) : false));
  }

  void _delete(RedBlackNode<V> node, V value) {
    // Base Case, [value] not found.
    if (node == nil) return;

    if (node.value!.compareTo(value) > 0) {
      _delete(node.left!, value);
    } else if (node.value!.compareTo(value) < 0) {
      _delete(node.right!, value);
    } else {
      // [node] with [value] found.

      // [node] has two children.
      if (node.left != nil && node.right != nil) {
        // Successor to [node] is the next inOrder node.
        var successor = node.right;
        while (successor!.left != nil) {
          successor = successor.left;
        }
        node.value = successor.value;
        _delete(node.right!, successor.value!);
      } else {
        // Delete [node] and reorder.
        var parent = _parent(node);

        // [node] is root.
        parent ?? nullify();

        node == parent?.left
            ? parent?.left = _deleteReorder(node)
            : parent?.right = _deleteReorder(node);
      }
    }
  }

  RedBlackNode<V>? _deleteReorder(RedBlackNode<V> node) {
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

        // [node]'s [sibling] is red.
        if (sibling?.color == Color.red) {
          // Rotate with [parent] as pivot and convert to case with
          //  black [sibling].
          if (parent!.left == node) {
            _rotateLeft(parent);
          } else {
            _rotateRight(parent);
          }
          parent.color = Color.red;
          sibling!.color = Color.black;

          // Update relations.
          sibling = _sibling(node);
          parent = _parent(node);
          nearNephew = _nearNephew(node);
          farNephew = _farNephew(node);
        }

        // [node]'s [sibling] and both the nephews are black..
        if (sibling?.color == Color.black &&
            nearNephew!.color == Color.black &&
            farNephew!.color == Color.black) {
          // ..with red parent.
          if (parent!.color == Color.red) {
            sibling!.color = Color.red;
            parent.color = Color.black;
          }

          // ..with black parent.
          else {
            sibling!.color = Color.red;
            _deleteReorder(parent);
          }
          return nil;
        }

        // [node]'s [sibling] is black and at least one nephew is red.
        if (sibling?.color == Color.black &&
            (nearNephew!.color == Color.red || farNephew!.color == Color.red)) {
          switch (farNephew!.color) {

            // Far nephew is black, perform rotation on [sibling]
            //  and convert it to other case.
            case Color.black:
              if (node == parent!.left) {
                _rotateRight(sibling!);
              } else {
                _rotateLeft(sibling!);
              }
              nearNephew.color = Color.black;
              sibling.color = Color.red;

              // Update relations.
              sibling = _sibling(node);
              nearNephew = _nearNephew(node);
              farNephew = _farNephew(node);
              continue toRedCase;

            toRedCase:
            // Far newphew is red.
            case Color.red:
              if (node == parent!.left) {
                _rotateLeft(parent);
              } else {
                _rotateRight(parent);
              }
              sibling!.color = parent.color;
              parent.color = farNephew!.color = Color.black;
              break;
          }

          return nil;
        }

        // [node] is root.
        return null;
      }

      // Black node with one child.
      else {
        var parent = _parent(node), child;

        if (node.left != nil) {
          child = node.left;
        } else {
          child = node.right;
        }
        child.parent = parent;
        child.color = Color.black;
        return child;
      }
    }
  }

  RedBlackNode<V>? _farNephew(RedBlackNode<V> node) {
    var parent = _parent(node);
    var sibling = _sibling(node);

    return node == parent?.left ? sibling?.right : sibling?.left;
  }

  /// Parent of [node]'s parent.
  RedBlackNode<V>? _grandParent(RedBlackNode<V> node) => _parent(_parent(node));

  void _inOrder(RedBlackNode<V> node, List<V> list) {
    if (node == nil) return;
    _inOrder(node.left!, list);
    list.add(node.value!);
    _inOrder(node.right!, list);
  }

  RedBlackNode<V>? _nearNephew(RedBlackNode<V> node) {
    var parent = _parent(node);
    var sibling = _sibling(node);

    return node == parent?.left ? sibling?.left : sibling?.right;
  }

  /// Parent of [node].
  RedBlackNode<V>? _parent(RedBlackNode<V>? node) => node?.parent;

  void _postOrder(RedBlackNode<V> node, List<V> list) {
    if (node == nil) return;
    _postOrder(node.left!, list);
    _postOrder(node.right!, list);
    list.add(node.value!);
  }

  void _preOrder(RedBlackNode<V> node, List<V> list) {
    if (node == nil) return;
    list.add(node.value!);
    _preOrder(node.left!, list);
    _preOrder(node.right!, list);
  }

  /// Rotates [node] N to left and makes C it's parent.
  ///
  ///          N                   C
  ///         /↶\                 / \
  ///            C       ⟶       N
  ///           / \             / \
  ///          ⬤                  ⬤
  /// Left subtree of C becomes right subtree of N.
  _rotateLeft(RedBlackNode<V> node) {
    var child = node.right;
    var parent = _parent(node);

    node.right = child!.left;
    child.left = node;
    node.parent = child;

    // Update other parent/child connections.
    if (node.right != nil) {
      node.right!.parent = node;
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
  ///            N                 C
  ///           /↷\       ⟶       / \
  ///          C                     N
  ///         / \                   / \
  ///            ⬤                ⬤
  /// Right subtree of C becomes left subtree of N.
  _rotateRight(RedBlackNode<V> node) {
    var child = node.left;
    var parent = _parent(node);

    node.left = child!.right;
    child.right = node;
    node.parent = child;

    // Update other parent/child connections.
    if (node.left != nil) {
      node.left!.parent = node;
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
  RedBlackNode<V>? _sibling(RedBlackNode<V>? node) {
    var parent = _parent(node);
    return node == parent?.left ? parent?.right : parent?.left;
  }

  /// Sibling of [node]'s parent.
  RedBlackNode<V>? _uncle(RedBlackNode<V> node) {
    var parent = _parent(node);
    return (_sibling(parent));
  }
}
