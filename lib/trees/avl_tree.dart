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
      root = _add(root!, value);
    } else {
      root = _add(root!, value);
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

  AvlNode<V> _add(AvlNode<V> node, V value) {
    if (node.value == null) {
      // Base case, node's value is set.
      node.value = value;
      _isTaller = true;
    } else if (node.value!.compareTo(value) > 0) {
      if (node.left == null) {
        // If left subtree is null, create a new node so that the value can be
        // assigned to it.
        node.left = AvlNode();
        node.left = _add(node.left!, value);
      } else {
        // Otherwise traverse to left subtree.
        node.left = _add(node.left!, value);
      }
      if (_isTaller) {
        // Update balance factor of parent after addition.
        node = _aUpdateLeftBalanceFactor(node);
      }
    } else if (node.value!.compareTo(value) < 0) {
      if (node.right == null) {
        // If right subtree is null, create a new node.
        node.right = AvlNode();
        node.right = _add(node.right!, value);
      } else {
        // Otherwise traverse to right subtree.
        node.right = _add(node.right!, value);
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

  /// Balances left heavy imbalanced [node] after deletion in it's right
  /// subtree.
  AvlNode<V> _dBalanceLeftHeavy(AvlNode<V> node) {
    // Left subtree of [node]
    var lChild = node.left;

    switch (lChild!.balanceFactor) {

      // [lChild] was balanced, single right rotation about [node] is performed
      // to balance the [node].
      case 0:
        //
        //           N                         N                       L
        //          / \                       /↷\                     / \
        //     ....L...█..        ⟶      ....L...█.. h    ⟶        ..█...N....
        //     .../.\..▒.. h+1           .../.\.....           h+1 ..█../.\...
        //     ..█...█....               ..█...█....               ....█...█.. h
        // h+1 ..█...█.. h+1         h+1 ..█...█.. h+1           h+1 ..█..
        //
        node = _rotateRight(node);

        node.balanceFactor = 1;
        lChild.balanceFactor = -1;

        // Height of the subtree rooted at L (previously N) does not change,
        // hence [_isShorter] is made `false`.
        _isShorter = false;
        break;

      // [lChild] was left heavy, single right rotation about [node] is
      // performed to balance it.
      case 1:
        //
        //           N                       N                       L
        //          / \                     /↷\                     / \
        //       ..L...█..       ⟶       ..L...█.. h    ⟶        ..█...N..
        //      ../.\..▒.. h+1          ../.\....            h+1 ..█../.\..
        //     ..█...█..               ..█...█..                   ..█...█..
        // h+1 ..█.... h           h+1 ..█.... h                   h       h
        //
        node = _rotateRight(node);
        node.balanceFactor = lChild.balanceFactor = 0;

        // Height of the subtree rooted at L (previously N) has changed, hence
        // [_isShorter] remains `true`.
        break;

      // [lChild] was right heavy. In this case, a single rotation will not
      // suffice so double rotation is performed. R is the root
      // node of [lChild]'s right subtree.
      //
      //         N                     N
      //        / \                   / \
      //     ..L...█..             ..L...█..
      //    ../.\..▒.. h+1        ../.\..▒.. h+1
      // h ..█...█..           h ..█.. R .
      //   ......█ h+1                / \
      //
      case -1:

        // Right subtree of [rChild].
        var rGrandChild = lChild.right;

        switch (rGrandChild!.balanceFactor) {

          // [rGrandChild] was balanced.
          case 0:
            //         N                      N                      N
            //        / \                    / \                    /↷\                  R
            //     ..L...█..              ..L...█.. h        ......R...█.. h           /   \
            //    ../.\..▒.. h+1   ⟶     ../↶\.....     ⟶    ...../.\....     ⟶       L     N
            // h ..█.. R ..           h ..█.. R ..           ....L...█.. h           / \   / \
            //    ..../.\..               .../.\..           .../.\....          h..█...█.█...█..h
            //   h ..█...█.. h          h ..█...█.. h      h ..█...█.. h
            //
            node.balanceFactor = lChild.balanceFactor = 0;
            break;

          // [rGrandChild] was left heavy.
          case 1:
            //         N                      N                      N
            //        / \                    / \                    /↷\                  R
            //     ..L...█..              ..L...█.. h        ......R...█.. h           /   \
            //    ../.\..▒.. h+1   ⟶     ../↶\.....     ⟶    ...../.\....     ⟶       L     N
            // h ..█.. R ..           h ..█.. R ..           ....L...▀.. h-1         / \   / \
            //    ..../.\..               .../.\..           .../.\....          h..█...█ ▀   █..h
            //   h ..█...▀.. h-1        h ..█...▀.. h-1    h ..█...█.. h                  │
            //                                                                        h-1 ┘
            //
            node.balanceFactor = -1;
            lChild.balanceFactor = 0;
            break;

          // [rGrandChild] was right heavy.
          case -1:
            //         N                      N                      N
            //        / \                    / \                    /↷\                  R
            //     ..L...█..              ..L...█.. h        ......R...█.. h           /   \
            //    ../.\..▒.. h+1   ⟶     ../↶\.....     ⟶    ...../.\....     ⟶       L     N
            // h ..█.. R ..           h ..█.. R ..           ....L...█.. h           / \   / \
            //    ..../.\..               .../.\..           .../.\....          h..█   ▀ █...█..h
            // h-1 ..▀...█.. h        h-1 ..▀...█.. h      h ..█...▀.. h-1              │
            //                                                                      h-1 ┘
            //
            node.balanceFactor = 0;
            lChild.balanceFactor = 1;
            break;
        }
        rGrandChild.balanceFactor = 0;
        // Left Right rotation is perfomed to balance [node].
        node.left = _rotateLeft(lChild);
        node = _rotateRight(node);

        // Height of the subtree rooted at R (previously N) has changed, hence
        // [_isShorter] remains `true`.
        break;
    }
    return node;
  }

  /// Balances right heavy, imbalanced [node] after deletion in it's left
  /// subtree.
  AvlNode<V> _dBalanceRightHeavy(AvlNode<V> node) {
    // Right subtree of [node]
    var rChild = node.right;

    switch (rChild!.balanceFactor) {

      // [rChild] was balanced, single left rotation about [node] is performed
      // to balance the [node].
      case 0:
        //
        //          N                         N                        R
        //         / \                       /↶\                      / \
        //     ...█...R....     ⟶      h ...█...R....     ⟶      ....N...█...
        // h+1 ...▒../.\...              ....../.\...            .../.\..█.. h+1
        //     .....█...█..              .....█...█..          h ..█...█.....
        //    h+1 ..█...█.. h+1         h+1 ..█...█.. h+1        ......█.. h+1
        //
        node = _rotateLeft(node);

        node.balanceFactor = -1;
        rChild.balanceFactor = 1;

        // Height of the subtree rooted at R (previously N) does not change,
        // hence [_isShorter] is made `false`.
        _isShorter = false;
        break;

      // [rChild] was right heavy, single left rotation about [node] is
      // performed to balance the [node].
      case -1:
        //
        //          N                         N                        R
        //         / \                       /↶\                      / \
        //     ...█...R....       ⟶     h ..█...R....     ⟶      ....N...█...
        // h+1 ...▒../.\...               ...../.\...            .../.\..█.. h+1
        //     .....█...█..               . h █...█..          h ..█...█.....
        //     ... h ...█.. h+1           ........█.. h+1        ...... h ...
        //
        node = _rotateLeft(node);

        node.balanceFactor = rChild.balanceFactor = 0;

        // Height of the subtree rooted at R (previously N) has changed, hence
        // [_isShorter] remains `true`.
        break;

      // [rChild] was left heavy. In this case, a single rotation will not
      // suffice so double rotation is performed. L is the root
      // node of [rChild]'s left subtree.
      //
      //         N                       N
      //        / \                     / \
      //     ..█...R..               ..█...R..
      // h+1 ..▒../.\..          h+1 ..▒. /.\..
      //      ...█...█.. h            .. L ..█.. h
      //     h+1 █......                / \
      //
      case 1:

        // Left subtree of [rChild].
        var lGrandChild = rChild.left;

        switch (lGrandChild!.balanceFactor) {

          // [lGrandChild] was balanced.
          case 0:
            //          N                    N                    N
            //         / \                  / \                  /↶\                    L
            //     ...█...R....       h ...█...R....       h ...█...L......           /   \
            // h+1 ...▒. /.\...    ⟶    ..... /↷\...    ⟶    ....../.\.....   ⟶      N     R
            //     .... L ..█.. h       .... L ..█.. h         h..█...R....         / \   / \
            //         / \                  / \                 ...../.\...     h..█...█.█...█..h
            //    h ..█...█.. h        h ..█...█.. h             h..█...█.. h
            //
            node.balanceFactor = rChild.balanceFactor = 0;
            break;

          // [lGrandChild] was left heavy.
          case 1:
            //          N                    N                    N
            //         / \                  / \                  /↶\                    L
            //     ...█...R....       h ...█...R....       h ...█...L......           /   \
            // h+1 ...▒. /.\...    ⟶    ..... /↷\...    ⟶    ....../.\.....   ⟶      N     R
            //     .... L ..█.. h       .... L ..█.. h         h..█...R....         / \   / \
            //         / \                  / \                 ...../.\...     h..█...█ ▀   █..h
            //    h ..█...▀.. h-1      h ..█...▀.. h-1         h-1..▀...█.. h            │
            //                                                                       h-1 ┘
            node.balanceFactor = 0;
            rChild.balanceFactor = -1;
            break;

          // [lGrandChild] was right heavy.
          case -1:
            //          N                    N                    N
            //         / \                  / \                  /↶\                    L
            //     ...█...R....       h ...█...R....       h ...█...L......           /   \
            // h+1 ...▒. /.\...    ⟶    ..... /↷\...    ⟶    ....../.\.....   ⟶      N     R
            //     .... L ..█.. h       .... L ..█.. h       h-1..▀...R....         / \   / \
            //         / \                  / \                 ...../.\...     h..█   ▀ █...█..h
            //  h-1 ..▀...█.. h      h-1 ..▀...█.. h             h..█...█.. h          │
            //                                                                     h-1 ┘
            node.balanceFactor = 1;
            rChild.balanceFactor = 0;
            break;
        }
        lGrandChild.balanceFactor = 0;
        // Right Left rotation is perfomed to balance [node].
        node.right = _rotateRight(rChild);
        node = _rotateLeft(node);

        // Height of the subtree rooted at L (previously N) has changed, hence
        // [_isShorter] remains `true`.
        break;
    }
    return node;
  }

  /// Recursively traverses the [AvlTree] and deletes [node] which has [value].
  ///
  /// After every deletion, sets [_isShorter] to `true`. During unwinding, if
  /// [_isShorter] is `true`, [_delete] calls either [_dUpdateLeftBalanceFactor]
  /// or [_dUpdateRightBalanceFactor] to balance the node of the current call
  /// stack depending on whether the deletion was done in the [node]'s left
  /// subtree or the right subtree respectively.
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
  /// subtree.
  AvlNode<V> _dUpdateLeftBalanceFactor(AvlNode<V> node) {
    switch (node.balanceFactor) {

      // [node] was balanced before deletion, is right heavy now.
      case 0:
        //          N                         N
        //         / \           ⟶           / \
        //     ...█...█...             h ...█...█...
        // h+1 ...▒...█... h+1           .......█... h+1
        //
        node.balanceFactor = -1;

        // Balance factors of the ancestors of this [node] will remain
        // unchanged (since height of the subtree rooted at N didn't change).
        // Therefore [_isShorter] is set to `false`.
        _isShorter = false;
        break;

      // [node] was left heavy before deletion, is balanced now.
      case 1:
        //          N                         N
        //         / \           ⟶           / \
        //     ...█...█... h           h ...█...█... h
        // h+1 ...▒.......               ...........
        //
        node.balanceFactor = 0;

        // Height of the subtree rooted at N has decreased, [_isShorter] remains
        // `true`.
        break;

      // [node] was right heavy before deletion, is imbalanced now, has to be
      // balanced.
      case -1:
        //          N                           N
        //         / \                         / \
        //     ...█...█...       ⟶     h-1 ...█...█...
        //   h ...▒...█...                 .......█...
        //     .......█... h+1             .......█... h+1
        //
        node = _dBalanceRightHeavy(node);
    }
    return node;
  }

  /// Updates [balanceFactor] of the [node] when deletion is done from it's
  /// right subtree.
  AvlNode<V> _dUpdateRightBalanceFactor(AvlNode<V> node) {
    switch (node.balanceFactor) {

      // node was balanced before deletion, is left heavy now.
      case 0:
        //          N                         N
        //         / \           ⟶           / \
        //     ...█...█...               ...█...█... h
        // h+1 ...█...▒... h+1       h+1 ...█.......
        //
        node.balanceFactor = 1;

        // Balance factors of the ancestors of this [node] will remain
        // unchanged (since height of the subtree rooted at N didn't change).
        // Therefore [_isShorter] is set to `false`.
        _isShorter = false;
        break;

      // node was right heavy before deletion, is balanced now.
      case -1:
        //          N                         N
        //         / \           ⟶           / \
        //   h ...█...█...             h ...█...█... h
        //     .......▒... h+1           ...........
        //
        node.balanceFactor = 0;

        // Height of the subtree rooted at N has decreased, [_isShorter] remains
        // `true`.
        break;

      // node was left heavy before deletion, is imbalanced now, has to be
      // balanced.
      case 1:
        //          N                           N
        //         / \                         / \
        //     ...█...█...       ⟶         ...█...█... h-1
        //     ...█...▒... h               ...█.......
        // h+1 ...█.......             h+1 ...█.......
        //
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
