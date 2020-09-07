import './binary_search_tree.dart';
import './binary_tree.dart';

/// A self-balancing [BinarySearchTree].
///
/// In AVL tree, difference in the height of left and right subtrees
///  of any node can be at most 1.
class AvlTree<T extends Comparable> implements BinaryTree<T> {
  /// Root of the tree
  _AvlNode root;

  /// If after addition, height of parent node increases.
  bool _isTaller = false;

  /// If after deletion, height of parent node decreases.
  bool _isShorter = false;

  /// Creates an empty AVL tree.
  AvlTree();

  /// Creates an AVL tree with all the values of [list].
  AvlTree.fromList(List<T> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new AVL tree with a single [value].
  AvlTree.withSingleValue(T value) : root = _AvlNode.withValue(value);

  /// Tests if this tree is empty.
  bool get isEmpty => root == null;

  @override
  void add(T value) {
    if (isEmpty) {
      root = _AvlNode();
      root = _add(root, value, true);
    } else {
      root = _add(root, value, false);
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

  /// Balances the left heavy, imbalanced [node].
  _AvlNode _aBalanceLeft(_AvlNode node) {
    var lChild = node.left;

    // Addition done in left subtree of [lChild].
    if (lChild.balanceFactor == 1) {
      node.balanceFactor = lChild.balanceFactor = 0;
      // Single right rotation about [node] is performed to balance it.
      node = _rotateRight(node);
    }

    // Addition done in right subtree of [lChild].
    else {
      var rGrandChild = lChild.right;
      switch (rGrandChild.balanceFactor) {

        // Addition is done in right subtree of [rGrandChild].
        case -1:
          node.balanceFactor = 0;
          lChild.balanceFactor = 1;
          break;

        // Addition is done in left subtree of [rGrandChild].
        case 1:
          node.balanceFactor = -1;
          lChild.balanceFactor = 0;
          break;

        // [rGrandChild] is the newly added node.
        case 0:
          node.balanceFactor = lChild.balanceFactor = 0;
      }
      rGrandChild.balanceFactor = 0;
      // Left Right rotation is perfomed to balance [node].
      node.left = _rotateLeft(lChild);
      node = _rotateRight(node);
    }

    return node;
  }

  /// Balances the right heavy, imbalanced [node].
  _AvlNode _aBalanceRight(_AvlNode node) {
    var rChild = node.right;

    // Addition done in right subtree of [rChild].
    if (rChild.balanceFactor == -1) {
      node.balanceFactor = rChild.balanceFactor = 0;
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);
    }

    // Addition done in left subtree of [rChild].
    else {
      var lGrandChild = rChild.left;
      switch (lGrandChild.balanceFactor) {

        // Addition is done in right subtree of [lGrandChild].
        case -1:
          node.balanceFactor = 1;
          rChild.balanceFactor = 0;
          break;

        // Addition is done in left subtree of [lGrandChild].
        case 1:
          node.balanceFactor = 0;
          rChild.balanceFactor = -1;
          break;

        // [lGrandChild] is the newly added node.
        case 0:
          node.balanceFactor = rChild.balanceFactor = 0;
      }
      lGrandChild.balanceFactor = 0;
      // Right Left rotation is perfomed to balance [node].
      node.right = _rotateRight(rChild);
      node = _rotateLeft(node);
    }

    return node;
  }

  _AvlNode _add(_AvlNode node, T value, bool isNull) {
    if (isNull) {
      // Base case, node's value is set.
      node.value = value;
      _isTaller = true;
    } else if (node.value.compareTo(value) > 0) {
      if (node.left == null) {
        // If left subtree is null,
        //  create a new node and pass [isNull] as true.
        /*var newNode = _AvlNode(null);
        node.left = newNode;
        node.left = _add(newNode, value, true);*/
        node.left = _AvlNode();
        node.left = _add(node.left, value, true);
      } else {
        // Otherwise traverse to left subtree.
        node.left = _add(node.left, value, false);
      }
      if (_isTaller) {
        // Update balance factor of parent after addition.
        node = _aUpdateLeftBalanceFactor(node);
      }
    } else if (node.value.compareTo(value) < 0) {
      if (node.right == null) {
        // If right subtree is null,
        //  create a new node and pass [isNull] as true.
        node.right = _AvlNode();
        node.right = _add(node.right, value, true);
      } else {
        // Otherwise traverse to right subtree.
        node.right = _add(node.right, value, false);
      }
      if (_isTaller) {
        // Update balance factor of parent after addition.
        node = _aUpdateRightBalanceFactor(node);
      }
    } else {
      // Duplicate value found.
      _isTaller = false;
    }
    return node;
  }

  /// Updates [balanceFactor] when addition is done in left subtree of [node].
  _AvlNode _aUpdateLeftBalanceFactor(_AvlNode node) {
    switch (node.balanceFactor) {

      // node was balanced.
      case 0:
        // node is left heavy now.
        node.balanceFactor = 1;
        break;

      // node was right heavy.
      case -1:
        // node is balanced now.
        node.balanceFactor = 0;
        _isTaller = false;
        break;

      // node was left heavy.
      case 1:
        // node is imbalanced now, has to be balanced.
        node = _aBalanceLeft(node);
        _isTaller = false;
    }
    return node;
  }

  /// Updates [balanceFactor] when addition is done in right subtree of [node].
  _AvlNode _aUpdateRightBalanceFactor(_AvlNode node) {
    switch (node.balanceFactor) {

      // node was balanced.
      case 0:
        // node is right heavy now.
        node.balanceFactor = -1;
        break;

      // node was left heavy.
      case 1:
        // node is balanced now.
        node.balanceFactor = 0;
        _isTaller = false;
        break;

      // node was right heavy.
      case -1:
        // node is imbalanced now, has to be balanced.
        node = _aBalanceRight(node);
        _isTaller = false;
    }
    return node;
  }

  bool _compareAndCheck(_AvlNode node, T value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != null ? _compareAndCheck(node.left, value) : false)
        : (node.right != null ? _compareAndCheck(node.right, value) : false));
  }

  /// Balances left heavy imbalanced [node] after deletion in it's
  ///  right subtree.
  _AvlNode _dBalanceLeft(_AvlNode node) {
    // Left subtree of [node]
    var lChild = node.left;

    // [lChild] was balanced.
    if (lChild.balanceFactor == 0) {
      node.balanceFactor = 1;
      lChild.balanceFactor = -1;
      _isShorter = false;
      // Single right rotation about [node] is performed to balance it.
      node = _rotateRight(node);
    }

    // [lChild] was left heavy.
    else if (lChild.balanceFactor == 1) {
      node.balanceFactor = lChild.balanceFactor = 0;
      // Single right rotation about [node] is performed to balance it.
      node = _rotateRight(node);
    }

    // [lChild] was right heavy.
    else {
      // Right subtree of [rChild].
      var rGrandChild = lChild.right;
      switch (rGrandChild.balanceFactor) {

        // [rGrandChild] was balanced.
        case 0:
          node.balanceFactor = lChild.balanceFactor = 0;
          break;

        // [rGrandChild] was left heavy.
        case 1:
          node.balanceFactor = -1;
          lChild.balanceFactor = 0;
          break;

        // [rGrandChild] was right heavy.
        case -1:
          node.balanceFactor = 0;
          lChild.balanceFactor = 1;
          break;
      }
      rGrandChild.balanceFactor = 0;
      // Left Right rotation is perfomed to balance [node].
      node.left = _rotateLeft(lChild);
      node = _rotateRight(node);
    }
    return node;
  }

  /// Balances right heavy, imbalanced [node] after deletion in it's
  ///  left subtree.
  _AvlNode _dBalanceRight(_AvlNode node) {
    // Right subtree of [node]
    var rChild = node.right;

    // [rChild] was balanced.
    if (rChild.balanceFactor == 0) {
      node.balanceFactor = -1;
      rChild.balanceFactor = 1;
      _isShorter = false;
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);
    }

    // [rChild] was right heavy.
    else if (rChild.balanceFactor == -1) {
      node.balanceFactor = rChild.balanceFactor = 0;
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);
    }

    // [rChild] was left heavy.
    else {
      // Left subtree of [rChild].
      var lGrandChild = rChild.left;
      switch (lGrandChild.balanceFactor) {

        // [lGrandChild] was balanced.
        case 0:
          node.balanceFactor = rChild.balanceFactor = 0;
          break;

        // [lGrandChild] was left heavy.
        case 1:
          node.balanceFactor = 0;
          rChild.balanceFactor = -1;
          break;

        // [lGrandChild] was right heavy.
        case -1:
          node.balanceFactor = 1;
          rChild.balanceFactor = 0;
          break;
      }
      lGrandChild.balanceFactor = 0;
      // Right Left rotation is perfomed to balance [node].
      node.right = _rotateRight(rChild);
      node = _rotateLeft(node);
    }
    return node;
  }

  _AvlNode _delete(_AvlNode node, T value) {
    // Base Case, Key not found
    if (node == null) {
      _isShorter = false;
      return node;
    }

    if (node.value.compareTo(value) > 0) {
      node.left = _delete(node.left, value);
      if (_isShorter) {
        node = _dUpdateLeftBalanceFactor(node);
      }
    } else if (node.value.compareTo(value) < 0) {
      node.right = _delete(node.right, value);
      if (_isShorter) {
        node = _dUpdateRightBalanceFactor(node);
      }
    }

    // [node] with value found.
    else {
      // [node] has two children.
      if (node.left != null && node.right != null) {
        // Successor to the node is the next inOrder node.
        var successor = node.right;
        while (successor.left != null) {
          successor = successor.left;
        }
        node.value = successor.value;
        node.right = _delete(node.right, successor.value);
        if (_isShorter) {
          node = _dUpdateRightBalanceFactor(node);
        }
      }

      // [node] only has left child.
      else if (node.left != null) {
        node = node.left;
      }

      // [node] only has right child.
      else if (node.right != null) {
        node = node.right;
      }

      // Childless node.
      else {
        node = null;
      }
      _isShorter = true;
    }
    return node;
  }

  /// Updates [balanceFactor] when deletion is done from left subtree of [node].
  _AvlNode _dUpdateLeftBalanceFactor(_AvlNode node) {
    switch (node.balanceFactor) {

      // node was balanced.
      case 0:
        // node is right heavy now.
        node.balanceFactor = -1;
        _isShorter = false;
        break;

      // node was left heavy.
      case 1:
        // node is balanced now.
        node.balanceFactor = 0;
        break;

      // node was right heavy.
      case -1:
        // node is imbalanced now, has to be balanced.
        node = _dBalanceRight(node);
    }
    return node;
  }

  /// Updates [balanceFactor] when deletion is done from right subtree of
  ///  [node].
  _AvlNode _dUpdateRightBalanceFactor(_AvlNode node) {
    switch (node.balanceFactor) {

      // node was balanced.
      case 0:
        // node is left heavy now.
        node.balanceFactor = 1;
        _isShorter = false;
        break;

      // node was right heavy.
      case -1:
        // node is balanced now.
        node.balanceFactor = 0;
        break;

      // node was left heavy.
      case 1:
        // node is imbalanced now, has to be balanced.
        node = _dBalanceLeft(node);
    }
    return node;
  }

  void _inOrder(_AvlNode node, List<T> list) {
    if (node == null) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  void _postOrder(_AvlNode node, List<T> list) {
    if (node == null) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(_AvlNode node, List<T> list) {
    if (node == null) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }

  /// Rotates [rightUnbalancedNode] U to left and makes C it's parent.
  ///
  ///          U                 C
  ///         /↶\              /  \
  ///             C     ⟶     U
  ///            / \          / \
  ///           ⬤               ⬤
  /// Left subtree of C becomes right subtree of U.
  _AvlNode _rotateLeft(_AvlNode rightUnbalancedNode) {
    var rightChild = rightUnbalancedNode.right;
    rightUnbalancedNode.right = rightChild.left;
    rightChild.left = rightUnbalancedNode;
    return rightChild;
  }

  /// Rotates [leftUnbalancedNode] U to right and makes C it's parent.
  ///
  ///            U             C
  ///           /↷\    ⟶    /  \
  ///          C                  U
  ///         / \                / \
  ///            ⬤             ⬤
  /// Right subtree of C becomes left subtree of U.
  _AvlNode _rotateRight(_AvlNode leftUnbalancedNode) {
    var leftChild = leftUnbalancedNode.left;
    leftUnbalancedNode.left = leftChild.right;
    leftChild.right = leftUnbalancedNode;
    return leftChild;
  }
}

/// Data structure similar to [_Node], differs in having a [balanceFactor].
class _AvlNode<T extends Comparable> {
  /// Difference between height of left and right subtree.
  ///
  /// [balanceFactor] ∈ `{-1, 0, 1}`.
  /// Any [_AvlNode] having [balanceFactor] outside this set is imbalanced.
  int balanceFactor;

  /// Value of the node.
  T value;

  /// [left] child node.
  _AvlNode<T> left;

  /// [right] child node.
  _AvlNode<T> right;

  /// Creates an empty avlNode.
  _AvlNode() : balanceFactor = 0;

  /// Creates an avlNode with [value].
  _AvlNode.withValue(this.value) : balanceFactor = 0;
}
