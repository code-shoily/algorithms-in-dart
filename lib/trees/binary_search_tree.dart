import 'adt/binary_tree_adt.dart';
import 'binary_tree.dart';

/// Hierarchical data structure of individual [BinaryNode]s.
///
/// Every [BinaryNode] of Binary Seach Tree(BST) has following properties:
/// * It's left subtree has nodes which have lesser value.
/// * It's right subtree has nodes which have greater value.
/// * Left and right subtrees are also BST.
class BinarySearchTree<V extends Comparable>
    extends BinaryTreeADT<BinaryNode<V>, V> {
  /// Root of the tree
  BinaryNode<V>? root;

  /// Creates an empty BST.
  BinarySearchTree();

  /// Creates a BST with all the values of [list].
  BinarySearchTree.fromList(List<V> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new BST with a single [value].
  BinarySearchTree.withSingleValue(V value) : root = BinaryNode(value);

  @override
  void add(V value) {
    var node = BinaryNode(value);
    if (isEmpty) {
      root = node;
    } else {
      _compareAndAdd(root!, node);
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
  void delete(V value) {
    if (!isEmpty) {
      root = _delete(root!, value);
    }
  }

  void _balance(List<V> list) {
    if (list.isEmpty) return;
    var middle = list.length ~/ 2;
    add(list[middle]);
    _balance(list.sublist(0, middle));
    _balance(list.sublist(middle + 1));
  }

  void _compareAndAdd(BinaryNode node, BinaryNode newNode) {
    // Don't allow duplicate values in Binary Search Tree.
    if (node.value == newNode.value) {
      return;
    }

    if (node.value!.compareTo(newNode.value) > 0) {
      if (node.left == null) {
        // newNode has lower value and becomes left child of the node.
        node.left = newNode;
      } else {
        _compareAndAdd(node.left!, newNode);
      }
    } else {
      if (node.right == null) {
        // newNode has greater value and becomes right child of node.
        node.right = newNode;
      } else {
        _compareAndAdd(node.right!, newNode);
      }
    }
  }

  BinaryNode<V>? _delete(BinaryNode<V>? node, V value) {
    // Base Case, Key not found
    if (node == null) return node;

    if (node.value!.compareTo(value) > 0) {
      node.left = _delete(node.left, value);
    } else if (node.value!.compareTo(value) < 0) {
      node.right = _delete(node.right, value);
    } else {
      // Node with value found.

      // Node has two children.
      if (node.left != null && node.right != null) {
        // Successor to the node is the next inOrder node.
        var successor = node.right;
        while (successor!.left != null) {
          successor = successor.left;
        }
        node.value = successor.value;
        node.right = _delete(node.right, successor.value!);
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
}
