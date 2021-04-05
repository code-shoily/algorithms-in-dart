import 'adt/binary_tree_adt.dart';
import 'binary_tree.dart';

/// Data structure similar to [BinaryNode], differs in having two boolean values
///  [leftIsThread] and [rightIsThread] to determine whether [left] and [right]
///  are threads or point to a child instead.
class ThreadedBinaryNode<V extends Comparable>
    extends BinaryNodeADT<ThreadedBinaryNode<V>, V> {
  V? value;

  /// Stores if [left] is a thread.
  bool? leftIsThread;

  /// Stores if [right] is a thread.
  bool? rightIsThread;

  /// Creates a node with [value] and marks [left] and [right] to be threads.
  ThreadedBinaryNode(this.value,
      {this.leftIsThread = true, this.rightIsThread = true});

  /// Creates a root node with [value].
  ThreadedBinaryNode.root(this.value);
}

/// A [BinaryTree] is threaded by making all [right] pointers that would
///  normally be null point to the in-order successor of the node
///  (if it exists), and all [left] pointers that would normally be null point
///  to the in-order predecessor of the node.
class ThreadedBinaryTree<V extends Comparable>
    extends BinaryTreeADT<ThreadedBinaryNode<V>, V> {
  ThreadedBinaryNode<V>? root;

  /// Creates an empty Threaded Binary tree.
  ThreadedBinaryTree();

  /// Creates a Threaded Binary tree with all the values of [list].
  ThreadedBinaryTree.fromList(List<V> list) {
    for (var value in list) {
      add(value);
    }
  }

  /// Creates a new Threaded Binary tree with a single [value].
  ThreadedBinaryTree.withSingleValue(V value)
      : root = ThreadedBinaryNode.root(value);

  @override
  void add(V value) {
    if (isEmpty) {
      root = ThreadedBinaryNode.root(value);
      return;
    }

    late ThreadedBinaryNode<V> parent;
    var node = root, isPresent = false;

    while (node != null) {
      if (node.value!.compareTo(value) == 0) {
        isPresent = true;
        break;
      }

      parent = node;
      if (node.value!.compareTo(value) > 0) {
        if (!(node.leftIsThread ?? true)) {
          node = node.left;
        } else {
          break;
        }
      } else if (!(node.rightIsThread ?? true)) {
        node = node.right;
      } else {
        break;
      }
    }

    if (!isPresent) {
      var newNode = ThreadedBinaryNode(value);

      if (parent.value!.compareTo(value) > 0) {
        newNode.left = parent.left;
        newNode.right = parent;

        // Parent was the leftmost node of the tree.
        newNode.leftIsThread = parent.leftIsThread ?? null;

        parent.leftIsThread = false;
        parent.left = newNode;
      } else {
        newNode.left = parent;
        newNode.right = parent.right;

        // Parent was the rightmost node of the tree.
        newNode.rightIsThread = parent.rightIsThread ?? null;

        parent.rightIsThread = false;
        parent.right = newNode;
      }
    }
  }

  @override
  bool contains(V value) => inOrder().contains(value);

  @override
  void delete(V value) {
    ThreadedBinaryNode<V>? parent;
    var node = root, isPresent = false;

    while (node != null) {
      if (node.value!.compareTo(value) == 0) {
        isPresent = true;
        break;
      }

      parent = node;
      if (node.value!.compareTo(value) > 0) {
        if (!(node.leftIsThread ?? true)) {
          node = node.left;
        } else {
          break;
        }
      } else if (!(node.rightIsThread ?? true)) {
        node = node.right;
      } else {
        break;
      }
    }

    if (isPresent) {
      if (!(node!.leftIsThread ?? true) && !(node.rightIsThread ?? true)) {
        // Node has 2 children.
        _delete(parent, node, _DeleteCase.twoChildren);
      } else if (!(node.leftIsThread ?? true)) {
        // Node has only a left child.
        _delete(parent, node, _DeleteCase.oneChild);
      } else if (!(node.rightIsThread ?? true)) {
        // Node has only a right child.
        _delete(parent, node, _DeleteCase.oneChild);
      } else {
        // Node is childless.
        _delete(parent, node, _DeleteCase.childless);
      }
    }
  }

  @override
  List<V> inOrder() {
    var result = <V>[];
    if (isEmpty) return result;

    var node = root;
    while (node!.leftIsThread != null) {
      node = node.left;
    }

    while (node != null) {
      result.add(node.value!);
      node = _inOrderSuccessor(node);
    }
    return result;
  }

  @override
  List<V> postOrder() {
    var result = <V>[];
    _postOrder(root, result);
    return result;
  }

  @override
  List<V> preOrder() {
    var result = <V>[];
    if (isEmpty) return result;

    var node = root;
    while (node != null) {
      result.add(node.value!);
      if (!(node.leftIsThread ?? true)) {
        node = node.left;
      } else if (!(node.rightIsThread ?? true)) {
        node = node.right;
      } else {
        while (node != null && (node.rightIsThread ?? false)) {
          node = node.right;
        }

        if (node != null) {
          node = node.right;
        }
      }
    }
    return result;
  }

  void _delete(ThreadedBinaryNode<V>? parent, ThreadedBinaryNode<V> node,
      _DeleteCase deleteCase) {
    switch (deleteCase) {
      case _DeleteCase.childless:
        if (parent == null) {
          nullify();
        } else if (node == parent.left) {
          parent.leftIsThread = node.leftIsThread == null ? null : true;
          parent.left = node.left;
        } else {
          parent.rightIsThread = node.rightIsThread == null ? null : true;
          parent.right = node.right;
        }
        break;

      case _DeleteCase.oneChild:
        var child = (node.leftIsThread ?? true) ? node.right : node.left;

        if (parent == null) {
          root = child;
        } else if (node == parent.left) {
          parent.left = child;
        } else {
          parent.right = child;
        }

        var successor = _inOrderSuccessor(node);
        var predecessor = _inOrderPredecessor(node);
        if (!(node.leftIsThread ?? true)) {
          predecessor!.right = successor;
          predecessor.rightIsThread = successor == null ? null : true;
        } else {
          if (!(node.rightIsThread ?? true)) {
            successor!.left = predecessor;
            successor.leftIsThread = predecessor == null ? null : true;
          }
        }
        break;

      case _DeleteCase.twoChildren:
        var successor = node.right!, parentSuccessor = node;

        while (!successor.leftIsThread!) {
          parentSuccessor = successor;
          successor = successor.left!;
        }

        node.value = successor.value;

        if (successor.leftIsThread! && (successor.rightIsThread ?? true)) {
          _delete(parentSuccessor, successor, _DeleteCase.childless);
        } else {
          _delete(parentSuccessor, successor, _DeleteCase.oneChild);
        }
        break;
    }
  }

  ThreadedBinaryNode<V>? _inOrderPredecessor(ThreadedBinaryNode<V> node) {
    if (node.leftIsThread ?? true) {
      return node.left;
    } else {
      node = node.left!;

      while (!node.rightIsThread!) {
        node = node.right!;
      }
      return node;
    }
  }

  ThreadedBinaryNode<V>? _inOrderSuccessor(ThreadedBinaryNode<V> node) {
    if (node.rightIsThread ?? true) {
      return node.right;
    } else {
      node = node.right!;

      while (!node.leftIsThread!) {
        node = node.left!;
      }
      return node;
    }
  }

  void _postOrder(ThreadedBinaryNode<V>? node, List<V> list) {
    if (node == null) return;

    if (!(node.leftIsThread ?? false)) _postOrder(node.left, list);
    if (!(node.rightIsThread ?? false)) _postOrder(node.right, list);
    list.add(node.value!);
  }
}

enum _DeleteCase { twoChildren, oneChild, childless }
