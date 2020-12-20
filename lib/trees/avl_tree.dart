import 'adt/binary_tree_adt.dart';
import 'binary_search_tree.dart';
import 'binary_tree.dart';

/// Data structure similar to [BinaryNode], differs in having a [balanceFactor].
class AvlNode<V extends Comparable> extends BinaryNodeADT<AvlNode<V>, V> {
  /// Difference between height of left and right subtree.
  ///
  /// [balanceFactor] ∈ `{-1, 0, 1}`.
  /// Any [AvlNode] having [balanceFactor] that does not belong to this set is
  /// considered imbalanced.
  ///
  /// In [AvlTree] it is the primary focus to actively balance out all
  /// imbalanced [node]s following addition or deletion.
  int balanceFactor = 0;

  /// [value] of the [node].
  V? value;

  /// Creates an empty [AvlNode].
  AvlNode();

  /// Creates an [AvlNode] with [value].
  AvlNode.withValue(this.value);
}

/// A self-balancing [BinarySearchTree].
///
/// In [AvlTree], the absolute difference in height of left and right subtrees
/// of any [node] can be at most `1`.
class AvlTree<V extends Comparable> extends BinaryTreeADT<AvlNode<V>, V> {
  /// Root of the tree.
  AvlNode<V>? root;

  /// If after addition, height of parent node increases and results in an
  /// imbalanced node.
  bool _isTaller = false;

  /// If after deletion, height of parent node decreases and results in an
  /// imbalanced node.
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
  void add(V value) {
    if (isEmpty) {
      root = AvlNode();
      root = _add(root!, value, true);
    } else {
      root = _add(root!, value, false);
    }
  }

  @override
  void delete(V value) {
    if (!isEmpty) {
      root = _delete(root, value);
    }
  }

  /// Balances the left heavy, imbalanced [node].
  AvlNode<V> _aBalanceLeft(AvlNode<V> node) {
    var lChild = node.left;

    // Addition done in left subtree of [lChild].
    if (lChild!.balanceFactor == 1) {
      node.balanceFactor = lChild.balanceFactor = 0;
      // Single right rotation about [node] is performed to balance it.
      node = _rotateRight(node);
    }

    // Addition done in right subtree of [lChild].
    else {
      var rGrandChild = lChild.right;
      switch (rGrandChild!.balanceFactor) {

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
  AvlNode<V> _aBalanceRight(AvlNode<V> node) {
    var rChild = node.right;

    // Addition done in right subtree of [rChild].
    if (rChild!.balanceFactor == -1) {
      node.balanceFactor = rChild.balanceFactor = 0;
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);
    }

    // Addition done in left subtree of [rChild].
    else {
      var lGrandChild = rChild.left;
      switch (lGrandChild!.balanceFactor) {

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

  AvlNode<V> _add(AvlNode<V> node, V value, bool isNull) {
    if (isNull) {
      // Base case, node's value is set.
      node.value = value;
      _isTaller = true;
    } else if (node.value!.compareTo(value) > 0) {
      if (node.left == null) {
        // If left subtree is null,
        //  create a new node and pass [isNull] as true.
        /*var newNode = _AvlNode(null);
        node.left = newNode;
        node.left = _add(newNode, value, true);*/
        node.left = AvlNode();
        node.left = _add(node.left!, value, true);
      } else {
        // Otherwise traverse to left subtree.
        node.left = _add(node.left!, value, false);
      }
      if (_isTaller) {
        // Update balance factor of parent after addition.
        node = _aUpdateLeftBalanceFactor(node);
      }
    } else if (node.value!.compareTo(value) < 0) {
      if (node.right == null) {
        // If right subtree is null,
        //  create a new node and pass [isNull] as true.
        node.right = AvlNode();
        node.right = _add(node.right!, value, true);
      } else {
        // Otherwise traverse to right subtree.
        node.right = _add(node.right!, value, false);
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
  AvlNode<V> _aUpdateLeftBalanceFactor(AvlNode<V> node) {
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
  AvlNode<V> _aUpdateRightBalanceFactor(AvlNode<V> node) {
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

  /// Balances left heavy imbalanced [node] after deletion in it's
  /// right subtree.
  AvlNode<V> _dBalanceLeftHeavy(AvlNode<V> node) {
    // Left subtree of [node]
    var lChild = node.left;

    // [lChild] was balanced.
    if (lChild!.balanceFactor == 0) {
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
      switch (rGrandChild!.balanceFactor) {

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

  /// Balances right heavy, imbalanced [node] after deletion in it's left
  /// subtree.
  AvlNode<V> _dBalanceRightHeavy(AvlNode<V> node) {
    // Right subtree of [node]
    var rChild = node.right;

    // [rChild] was balanced.
    //          N
    //           \
    //            R
    //           / \
    //          ** **
    if (rChild!.balanceFactor == 0) {
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);

      node.balanceFactor = -1;
      rChild.balanceFactor = 1;
      _isShorter = false;
    }

    // [rChild] was right heavy.
    //          N
    //           \
    //            R
    //           / \
    //          *  **
    else if (rChild.balanceFactor == -1) {
      node.balanceFactor = rChild.balanceFactor = 0;
      // Single left rotation about [node] is performed to balance it.
      node = _rotateLeft(node);
    }

    // [rChild] was left heavy.
    else {
      // Left subtree of [rChild].
      var lGrandChild = rChild.left;
      switch (lGrandChild!.balanceFactor) {

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

  /// Recursively traverses the [AvlTree] and deletes [node] which has [value].
  ///
  /// After every deletion, sets [_isShorter] to `true`. During unwinding, if
  /// [_isShorter] is `true`, [_delete] calls either [_dUpdateLeftBalanceFactor]
  /// or [_dUpdateRightBalanceFactor] to balance the node of the current call
  /// stack depending on whether the deletion was done in it's left subtree or
  /// the right subtree respectively.
  ///
  /// The process of checking [balanceFactor] stops when [_isShorter] becomes
  /// `false`.
  ///
  /// When the value to be deleted is not found, then [_isShorter] is made
  /// `false` since in this case there is no need check [balaceFactor]s in
  /// the unwinding phase.
  AvlNode<V>? _delete(AvlNode<V>? node, V value) {
    // Base case, [value] not found in the tree.
    if (node == null) {
      _isShorter = false;
      return node;
    }

    // Try to locate the [node] with [value].
    if (node.value!.compareTo(value) > 0) {
      node.left = _delete(node.left, value);

      if (_isShorter) {
        node = _dUpdateLeftBalanceFactor(node);
      }
    } else if (node.value!.compareTo(value) < 0) {
      node.right = _delete(node.right, value);

      if (_isShorter) {
        node = _dUpdateRightBalanceFactor(node);
      }
    }

    // [node] with [value] found.
    else {
      // [node] has two children.
      if (node.left != null && node.right != null) {
        // Successor to the node is the next inOrder node.
        var successor = node.right;
        while (successor!.left != null) {
          successor = successor.left;
        }
        // Copy [successor]'s [value] to [node] and now delete the [successor].
        //
        // This step shifts the deletion to the successor (having single or no
        // child; easier to delete) from the node (having two children; much
        // harder to delete).
        // Similarly, instead of successor, the predecessor's value can also be
        // copied and deletion then shifted to predecessor (having single or
        // no child).
        node.value = successor.value;
        node.right = _delete(node.right, successor.value!);

        if (_isShorter) {
          // [successor] is always in right subtree of the [node].
          node = _dUpdateRightBalanceFactor(node);
        }
      }

      // [node] only has [left] child.
      else if (node.left != null) {
        // Simply replace [node] with it's child.
        node = node.left;
      }

      // [node] only has [right] child.
      else if (node.right != null) {
        // Simply replace [node] with it's child.
        node = node.right;
      }

      // Childless node.
      else {
        node = null;
      }

      // Mark that this subtree is now shorter because of the deletion so, if
      // need be, it can be balanced out while unwinding the recursion.
      _isShorter = true;
    }
    return node;
  }

  /// Updates [balanceFactor] of the [node] when deletion is done from it's left
  /// subtree.\
  AvlNode<V> _dUpdateLeftBalanceFactor(AvlNode<V> node) {
    switch (node.balanceFactor) {

      // [node] was balanced before deletion. (Both left and right subtree had
      // the same height.)
      //          N
      //         / \
      //        ** **
      case 0:
        // [node] is right heavy now.
        //          N
        //         / \
        //        *  **
        node.balanceFactor = -1;
        _isShorter = false;
        break;

      // [node] was left heavy before deletion. (Left subtree's height was one
      // more than that of right subtree.)
      //          N
      //         / \
      //        **  *
      case 1:
        // [node] is balanced now.
        //          N
        //         / \
        //        *   *
        node.balanceFactor = 0;
        break;

      // [node] was right heavy before deletion. (Right subtree's height was one
      // more than that of left subtree.)
      //          N
      //         / \
      //        *  **
      case -1:
        // [node] is imbalanced now, has to be balanced.
        //          N
        //           \
        //           **
        node = _dBalanceRightHeavy(node);
    }
    return node;
  }

  /// Updates [balanceFactor] of the [node]  when deletion is done from it's
  /// right subtree.
  /// Subsequently, during unwinding, it can be made `false` inside
  /// [_dUpdateLeftBalanceFactor] or [_dUpdateRightBalanceFactor].
  AvlNode<V> _dUpdateRightBalanceFactor(AvlNode<V> node) {
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
        node = _dBalanceLeftHeavy(node);
    }
    return node;
  }

  /// Rotates [rightUnbalancedNode] N to left and makes R it's parent.
  ///
  ///          N                   R
  ///         /↶\                 / \
  ///            R       ⟶       N
  ///           / \             / \
  ///          ⬤                  ⬤
  /// Left subtree of R becomes right subtree of N.
  AvlNode<V> _rotateLeft(AvlNode<V> rightUnbalancedNode) {
    var rightChild = rightUnbalancedNode.right;
    rightUnbalancedNode.right = rightChild!.left;
    rightChild.left = rightUnbalancedNode;
    return rightChild;
  }

  /// Rotates [leftUnbalancedNode] N to right and makes L it's parent.
  ///
  ///            N                 L
  ///           /↷\       ⟶       / \
  ///          L                     N
  ///         / \                   / \
  ///            ⬤                ⬤
  /// Right subtree of C becomes left subtree of N.
  AvlNode<V> _rotateRight(AvlNode<V> leftUnbalancedNode) {
    var leftChild = leftUnbalancedNode.left;
    leftUnbalancedNode.left = leftChild!.right;
    leftChild.right = leftUnbalancedNode;
    return leftChild;
  }
}
