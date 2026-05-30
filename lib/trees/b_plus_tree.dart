import 'adt/tree_adt.dart';

/// A node in a [BPlusTree].
///
/// All data lives in leaf nodes. Internal nodes store routing keys.
/// Leaf nodes are linked via [next] for efficient range scans.
class BPlusTreeNode<V extends Comparable> extends NodeADT<BPlusTreeNode<V>, V> {
  /// Ordered keys stored in this node.
  List<V> keys = [];

  /// Whether this node is a leaf.
  bool isLeaf;

  /// Link to the next leaf node (only used when [isLeaf] is `true`).
  BPlusTreeNode<V>? next;

  /// Creates an empty [BPlusTreeNode].
  BPlusTreeNode({this.isLeaf = true}) {
    children = [];
  }

  /// Checks if this node is full.
  bool isFull(int degree) => keys.length >= 2 * degree - 1;

  /// Checks if this node has the minimum number of keys.
  bool isMin(int degree) => keys.length <= degree - 1;
}

/// A B+ Tree where all values reside in leaf nodes linked in sorted order.
///
/// Internal nodes contain routing keys only. This structure excels at
/// range queries and sequential access.
class BPlusTree<V extends Comparable> implements TreeADT<BPlusTreeNode<V>, V> {
  /// Root of the tree.
  @override
  BPlusTreeNode<V>? root;

  /// Minimum degree of this B+ Tree.
  final int degree;

  /// Creates an empty [BPlusTree] with the given [degree].
  BPlusTree({this.degree = 2});

  /// Creates a [BPlusTree] from a [list] of values.
  BPlusTree.fromList(List<V> list, {this.degree = 2}) {
    for (var value in list) {
      add(value);
    }
  }

  @override
  bool get isEmpty => root == null;

  @override
  void add(V value) {
    if (isEmpty) {
      root = BPlusTreeNode<V>()..keys.add(value);
      return;
    }

    if (root!.isFull(degree)) {
      var newRoot = BPlusTreeNode<V>(isLeaf: false);
      newRoot.children!.add(root);
      _splitChild(newRoot, 0);
      root = newRoot;
    }

    _insertNonFull(root!, value);
  }

  @override
  bool contains(V value) {
    var node = root;
    while (node != null && !node.isLeaf) {
      var i = 0;
      while (i < node.keys.length && value.compareTo(node.keys[i]) >= 0) {
        i++;
      }
      node = node.children![i];
    }
    if (node == null) return false;

    var i = 0;
    while (i < node.keys.length && value.compareTo(node.keys[i]) > 0) {
      i++;
    }
    return i < node.keys.length && value == node.keys[i];
  }

  @override
  void delete(V value) {
    if (isEmpty) return;

    _delete(root!, value);

    if (root != null && root!.keys.isEmpty && !root!.isLeaf) {
      root = root!.children![0];
    }
    if (root != null && root!.keys.isEmpty) {
      root = null;
    }
  }

  @override
  void nullify() => root = null;

  /// Returns all keys in sorted order by traversing leaf links.
  List<V> inOrder() {
    if (isEmpty) return [];
    BPlusTreeNode<V>? node = _leftmostLeaf(root!);
    var result = <V>[];
    while (node != null) {
      result.addAll(node.keys);
      node = node.next;
    }
    return result;
  }

  /// Returns all keys in the inclusive range [[start], [end]].
  List<V> rangeSearch(V start, V end) {
    var result = <V>[];
    var node = _findLeaf(start);
    while (node != null) {
      for (var key in node.keys) {
        if (key.compareTo(start) >= 0 && key.compareTo(end) <= 0) {
          result.add(key);
        } else if (key.compareTo(end) > 0) {
          return result;
        }
      }
      node = node.next;
    }
    return result;
  }

  void _insertNonFull(BPlusTreeNode<V> node, V value) {
    if (node.isLeaf) {
      var i = node.keys.length - 1;
      while (i >= 0 && value.compareTo(node.keys[i]) < 0) {
        i--;
      }
      if (i >= 0 && value == node.keys[i]) return;
      node.keys.insert(i + 1, value);
      return;
    }

    var i = node.keys.length - 1;
    while (i >= 0 && value.compareTo(node.keys[i]) < 0) {
      i--;
    }
    if (i >= 0 && value == node.keys[i]) return;

    var childIndex = i + 1;
    var child = node.children![childIndex] as BPlusTreeNode<V>;

    if (child.isFull(degree)) {
      _splitChild(node, childIndex);
      if (value.compareTo(node.keys[childIndex]) > 0) {
        childIndex++;
      }
    }

    _insertNonFull(node.children![childIndex] as BPlusTreeNode<V>, value);
  }

  void _splitChild(BPlusTreeNode<V> parent, int index) {
    var fullChild = parent.children![index] as BPlusTreeNode<V>;
    var newChild = BPlusTreeNode<V>(isLeaf: fullChild.isLeaf);

    if (fullChild.isLeaf) {
      newChild.keys.addAll(fullChild.keys.sublist(degree));
      fullChild.keys.removeRange(degree, fullChild.keys.length);

      newChild.next = fullChild.next;
      fullChild.next = newChild;

      parent.keys.insert(index, newChild.keys.first);
    } else {
      var mid = degree - 1;
      var midKey = fullChild.keys[mid];

      newChild.keys.addAll(fullChild.keys.sublist(mid + 1));
      fullChild.keys.removeRange(mid, fullChild.keys.length);

      newChild.children!.addAll(fullChild.children!.sublist(mid + 1));
      fullChild.children!.removeRange(mid + 1, fullChild.children!.length);

      parent.keys.insert(index, midKey);
    }

    parent.children!.insert(index + 1, newChild);
  }

  void _delete(BPlusTreeNode<V> node, V value) {
    if (node.isLeaf) {
      var idx = _findKey(node, value);
      if (idx < node.keys.length && node.keys[idx] == value) {
        node.keys.removeAt(idx);
      }
      return;
    }

    var i = 0;
    while (i < node.keys.length && value.compareTo(node.keys[i]) >= 0) {
      i++;
    }

    var child = node.children![i] as BPlusTreeNode<V>;
    if (child.isMin(degree)) {
      _fillChild(node, i);
    }

    if (i >= node.children!.length) {
      i = node.children!.length - 1;
    }

    _delete(node.children![i] as BPlusTreeNode<V>, value);
  }

  void _fillChild(BPlusTreeNode<V> parent, int idx) {
    if (idx > 0) {
      var leftSibling = parent.children![idx - 1] as BPlusTreeNode<V>;
      if (!leftSibling.isMin(degree)) {
        _borrowFromLeft(parent, idx);
        return;
      }
    }

    if (idx < parent.keys.length) {
      var rightSibling = parent.children![idx + 1] as BPlusTreeNode<V>;
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

  void _borrowFromLeft(BPlusTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BPlusTreeNode<V>;
    var leftSibling = parent.children![idx - 1] as BPlusTreeNode<V>;

    var borrowed = leftSibling.keys.removeLast();
    child.keys.insert(0, borrowed);
    parent.keys[idx - 1] = child.keys.first;
  }

  void _borrowFromRight(BPlusTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BPlusTreeNode<V>;
    var rightSibling = parent.children![idx + 1] as BPlusTreeNode<V>;

    var borrowed = rightSibling.keys.removeAt(0);
    child.keys.add(borrowed);
    parent.keys[idx] = rightSibling.keys.first;
  }

  void _merge(BPlusTreeNode<V> parent, int idx) {
    var child = parent.children![idx] as BPlusTreeNode<V>;
    var rightSibling = parent.children![idx + 1] as BPlusTreeNode<V>;

    child.keys.addAll(rightSibling.keys);
    child.next = rightSibling.next;

    parent.keys.removeAt(idx);
    parent.children!.removeAt(idx + 1);
  }

  int _findKey(BPlusTreeNode<V> node, V value) {
    var idx = 0;
    while (idx < node.keys.length && value.compareTo(node.keys[idx]) > 0) {
      idx++;
    }
    return idx;
  }

  BPlusTreeNode<V> _leftmostLeaf(BPlusTreeNode<V> node) {
    while (!node.isLeaf) {
      node = node.children!.first as BPlusTreeNode<V>;
    }
    return node;
  }

  BPlusTreeNode<V>? _findLeaf(V value) {
    var node = root;
    while (node != null && !node.isLeaf) {
      var i = 0;
      while (i < node.keys.length && value.compareTo(node.keys[i]) >= 0) {
        i++;
      }
      node = node.children![i];
    }
    return node;
  }
}
