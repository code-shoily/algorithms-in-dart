import './binary_tree_adt.dart';
import 'binary_search_tree.dart';
import 'binary_tree.dart';

/// Data structure similar to [BinaryNode], differs in having a [balanceFactor].
class AvlNode<V extends Comparable> implements BinaryNodeADT<AvlNode, V> {
  /// Difference between height of left and right subtree.
  ///
  /// [balanceFactor] ∈ `{-1, 0, 1}`.
  /// Any [AvlNode] having [balanceFactor] outside this set is imbalanced.
  int balanceFactor;

  /// Value of the node.
  V value;

  AvlNode left;

  AvlNode right;

  /// Creates an empty avlNode.
  AvlNode() : balanceFactor = 0;

  /// Creates an avlNode with [value].
  AvlNode.withValue(this.value) : balanceFactor = 0;
}

/// A self-balancing [BinarySearchTree].
///
/// In AVL tree, difference in the height of left and right subtrees
///  of any node can be at most 1.
class AvlTree<V extends Comparable> implements BinaryTreeADT<AvlNode, V> {
  /// Root of the tree
  AvlNode root;

  /// If after addition, height of parent node increases.
  bool _isTaller = false;

  /// If after deletion, height of parent node decreases.
  bool _isShorter = false;

  /// Creates an empty AVL tree.
  AvlTree();

  /// Creates an AVL tree with all the values of [list].
  AvlTree.fromList(List<V> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new AVL tree with a single [value].
  AvlTree.withSingleValue(V value) : root = AvlNode.withValue(value);

  @override
  bool get isEmpty => root == null;

  @override
  void add(V value) {
    if (isEmpty) {
      root = AvlNode();
      root = _add(root, value, true);
    } else {
      root = _add(root, value, false);
    }
  }

  @override
  bool contains(V value) => isEmpty ? false : _compareAndCheck(root, value);

  @override
  void delete(V value) {
    if (!isEmpty) {
      root = _delete(root, value);
    }
  }

  @override
  List<V> inOrder() {
    var result = <V>[];
    _inOrder(root, result);
    return result;
  }

  @override
  void nullify() => root = null;

  @override
  List<V> postOrder() {
    var result = <V>[];
    _postOrder(root, result);
    return result;
  }

  @override
  List<V> preOrder() {
    var result = <V>[];
    _preOrder(root, result);
    return result;
  }

  /// Balances the left heavy, imbalanced [node].
  AvlNode _aBalanceLeft(AvlNode node) {
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
  AvlNode _aBalanceRight(AvlNode node) {
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

  AvlNode _add(AvlNode node, V value, bool isNull) {
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
        node.left = AvlNode();
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
        node.right = AvlNode();
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
  AvlNode _aUpdateLeftBalanceFactor(AvlNode node) {
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
  AvlNode _aUpdateRightBalanceFactor(AvlNode node) {
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

  bool _compareAndCheck(AvlNode node, V value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != null ? _compareAndCheck(node.left, value) : false)
        : (node.right != null ? _compareAndCheck(node.right, value) : false));
  }

  /// Balances left heavy imbalanced [node] after deletion in it's
  ///  right subtree.
  AvlNode _dBalanceLeft(AvlNode node) {
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
  AvlNode _dBalanceRight(AvlNode node) {
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

  AvlNode _delete(AvlNode node, V value) {
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
  AvlNode _dUpdateLeftBalanceFactor(AvlNode node) {
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
  AvlNode _dUpdateRightBalanceFactor(AvlNode node) {
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

  void _inOrder(AvlNode node, List<V> list) {
    if (node == null) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  void _postOrder(AvlNode node, List<V> list) {
    if (node == null) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(AvlNode node, List<V> list) {
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
  AvlNode _rotateLeft(AvlNode rightUnbalancedNode) {
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
  AvlNode _rotateRight(AvlNode leftUnbalancedNode) {
    var leftChild = leftUnbalancedNode.left;
    leftUnbalancedNode.left = leftChild.right;
    leftChild.right = leftUnbalancedNode;
    return leftChild;
  }
}
