import 'adt/tree_adt.dart';

/// A node in a [BTree], containing multiple [keys] and [children].
///
/// In a B Tree of minimum degree [degree], each node contains at most
/// `2 * degree - 1` keys and `2 * degree` children.
class BTreeNode<V extends Comparable> extends NodeADT<BTreeNode<V>, V> {
  /// Ordered keys stored in this node.
  List<V> keys = [];

  /// Whether this node is a leaf (has no children).
  bool isLeaf;

  /// Creates an empty [BTreeNode].
  BTreeNode({this.isLeaf = true}) {
    children = [];
  }

  /// Checks if this node is full.
  bool isFull(int degree) => keys.length >= 2 * degree - 1;

  /// Checks if this node has the minimum number of keys.
  bool isMin(int degree) => keys.length <= degree - 1;
}

/// A self-balancing search tree where nodes can contain multiple keys.
///
/// In a B Tree of minimum degree [degree]:
/// * Every node has at most `2 * degree - 1` keys.
/// * Every node (except root) has at least `degree - 1` keys.
/// * All leaves are at the same depth.
class BTree<V extends Comparable> implements TreeADT<BTreeNode<V>, V> {
  /// Root of the tree.
  @override
  BTreeNode<V>? root;

  /// Minimum degree of this B Tree.
  final int degree;

  /// Creates an empty [BTree] with the given [degree].
  BTree({this.degree = 2});

  /// Creates a [BTree] from a [list] of values.
  BTree.fromList(List<V> list, {this.degree = 2}) {
    for (var value in list) {
      add(value);
    }
  }

  @override
  bool get isEmpty => root == null;

  @override
  void add(V value) {
    if (isEmpty) {
      root = BTreeNode<V>()..keys.add(value);
      return;
    }

    if (root!.isFull(degree)) {
      var newRoot = BTreeNode<V>(isLeaf: false);
      newRoot.children!.add(root);
      _splitChild(newRoot, 0);
      root = newRoot;
    }

    _insertNonFull(root!, value);
  }

  @override
  bool contains(V value) => _contains(root, value);

  @override
  void delete(V value) {
    if (isEmpty) return;

    _delete(root!, value);

    if (root!.keys.isEmpty) {
      root = root!.isLeaf ? null : root!.children![0];
    }
  }

  @override
  void nullify() => root = null;

  /// Returns all keys in sorted order.
  List<V> inOrder() => _inOrder(root);

  void _insertNonFull(BTreeNode<V> node, V value) {
    var i = node.keys.length - 1;

    if (node.isLeaf) {
      while (i >= 0 && value.compareTo(node.keys[i]) < 0) {
        i--;
      }
      if (i >= 0 && value == node.keys[i]) return;
      node.keys.insert(i + 1, value);
      return;
    }

    while (i >= 0 && value.compareTo(node.keys[i]) < 0) {
      i--;
    }
    if (i >= 0 && value == node.keys[i]) return;

    var childIndex = i + 1;
    var child = node.children![childIndex] as BTreeNode<V>;

    if (child.isFull(degree)) {
      _splitChild(node, childIndex);
      if (value.compareTo(node.keys[childIndex]) > 0) {
        childIndex++;
      }
    }

    _insertNonFull(node.children![childIndex] as BTreeNode<V>, value);
  }

  void _splitChild(BTreeNode<V> parent, int index) {
    var fullChild = parent.children![index] as BTreeNode<V>;
    var newChild = BTreeNode<V>(isLeaf: fullChild.isLeaf);

    var mid = degree - 1;
    var midKey = fullChild.keys[mid];

    newChild.keys.addAll(fullChild.keys.sublist(mid + 1));
    fullChild.keys.removeRange(mid, fullChild.keys.length);

    if (!fullChild.isLeaf) {
      newChild.children!.addAll(fullChild.children!.sublist(mid + 1));
      fullChild.children!.removeRange(mid + 1, fullChild.children!.length);
    }

    parent.keys.insert(index, midKey);
    parent.children!.insert(index + 1, newChild);
  }

  bool _contains(BTreeNode<V>? node, V value) {
    if (node == null) return false;

    var i = 0;
    while (i < node.keys.length && value.compareTo(node.keys[i]) > 0) {
      i++;
    }

    if (i < node.keys.length && value == node.keys[i]) return true;
    if (node.isLeaf) return false;

    return _contains(node.children![i], value);
  }

  void _delete(BTreeNode<V> node, V value) {
    var idx = _findKey(node, value);

    if (idx < node.keys.length && node.keys[idx] == value) {
      if (node.isLeaf) {
        node.keys.removeAt(idx);
      } else {
        _deleteFromInternalNode(node, idx);
      }
    } else {
      if (node.isLeaf) return;

      var childIdx = idx;
      var child = node.children![childIdx] as BTreeNode<V>;

      if (child.isMin(degree)) {
        _fillChild(node, childIdx);
      }

      if (childIdx > node.keys.length) {
        childIdx = node.keys.length;
      }

      _delete(node.children![childIdx] as BTreeNode<V>, value);
    }
  }

  void _deleteFromInternalNode(BTreeNode<V> node, int idx) {
    var key = node.keys[idx];
    var leftChild = node.children![idx] as BTreeNode<V>;
    var rightChild = node.children![idx + 1] as BTreeNode<V>;

    if (!leftChild.isMin(degree)) {
      var predecessor = _getMax(leftChild);
      node.keys[idx] = predecessor;
      _delete(leftChild, predecessor);
    } else if (!rightChild.isMin(degree)) {
      var successor = _getMin(rightChild);
      node.keys[idx] = successor;
      _delete(rightChild, successor);
    } else {
      _merge(node, idx);
      _delete(leftChild, key);
    }
  }

  void _fillChild(BTreeNode<V> parent, int idx) {
    if (idx > 0) {
      var leftSibling = parent.children![idx - 1] as BTreeNode<V>;
      if (!leftSibling.isMin(degree)) {
        _borrowFromLeft(parent, idx);
        return;
      }
    }

    if (idx < parent.keys.length) {
      var rightSibling = parent.children![idx + 1] as BTreeNode<V>;
      if (!rightSibling.isMin(degree)) {
        _borrowFromRight(parent, idx);
        return;
      }
    }

    if (idx < parent.keys.length) {
      _merge(parent, idx);
    } else {
      _merge(parent, idx - 1);
    }
  }

  void _borrowFromLeft(BTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BTreeNode<V>;
    var leftSibling = parent.children![idx - 1] as BTreeNode<V>;

    child.keys.insert(0, parent.keys[idx - 1]);
    if (!child.isLeaf) {
      child.children!.insert(0, leftSibling.children!.removeLast());
    }
    parent.keys[idx - 1] = leftSibling.keys.removeLast();
  }

  void _borrowFromRight(BTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BTreeNode<V>;
    var rightSibling = parent.children![idx + 1] as BTreeNode<V>;

    child.keys.add(parent.keys[idx]);
    if (!child.isLeaf) {
      child.children!.add(rightSibling.children!.removeAt(0));
    }
    parent.keys[idx] = rightSibling.keys.removeAt(0);
  }

  void _merge(BTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BTreeNode<V>;
    var rightSibling = parent.children![idx + 1] as BTreeNode<V>;

    child.keys.add(parent.keys.removeAt(idx));
    child.keys.addAll(rightSibling.keys);

    if (!child.isLeaf) {
      child.children!.addAll(rightSibling.children!);
    }

    parent.children!.removeAt(idx + 1);
  }

  int _findKey(BTreeNode<V> node, V value) {
    var idx = 0;
    while (idx < node.keys.length && value.compareTo(node.keys[idx]) > 0) {
      idx++;
    }
    return idx;
  }

  V _getMax(BTreeNode<V> node) {
    while (!node.isLeaf) {
      node = node.children!.last as BTreeNode<V>;
    }
    return node.keys.last;
  }

  V _getMin(BTreeNode<V> node) {
    while (!node.isLeaf) {
      node = node.children!.first as BTreeNode<V>;
    }
    return node.keys.first;
  }

  List<V> _inOrder(BTreeNode<V>? node) {
    if (node == null) return [];

    var result = <V>[];
    for (var i = 0; i < node.keys.length; i++) {
      if (!node.isLeaf) {
        result.addAll(_inOrder(node.children![i]));
      }
      result.add(node.keys[i]);
    }
    if (!node.isLeaf) {
      result.addAll(_inOrder(node.children![node.keys.length]));
    }
    return result;
  }
}
