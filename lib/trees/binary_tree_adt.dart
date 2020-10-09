import './tree_adt.dart';

/// Declares members of a binary node.
abstract class BinaryNodeADT<N, V extends Comparable> implements NodeADT<N, V> {
  /// Binary node only has two children, [left] and [right].
  List<N> children = List(2);

  /// Left child node.
  N get left => children[0];
  set left(N node) => children[0] = node;

  /// Right child node.
  N get right => children[1];
  set right(N node) => children[1] = node;

  @override
  String toString() {
    return '$value';
  }
}

/// A binary tree data structure can be defined recursively as a collection of
///  binary nodes (starting at a [root] node).
abstract class BinaryTreeADT<N extends BinaryNodeADT, V extends Comparable>
    implements TreeADT<N, V> {
  @override
  bool get isEmpty => root == null;

  @override
  bool contains(V value) => isEmpty ? false : _compareAndCheck(root, value);
  bool _compareAndCheck(N node, V value) {
    if (node.value == value) return true;
    return (node.value.compareTo(value) >= 0
        ? (node.left != null ? _compareAndCheck(node.left, value) : false)
        : (node.right != null ? _compareAndCheck(node.right, value) : false));
  }

  @override
  void nullify() => root = null;

  @override
  List<V> inOrder() {
    var result = <V>[];
    _inOrder(root, result);
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
    _preOrder(root, result);
    return result;
  }

  void _inOrder(N node, List<V> list) {
    if (node == null) return;
    _inOrder(node.left, list);
    list.add(node.value);
    _inOrder(node.right, list);
  }

  void _postOrder(N node, List<V> list) {
    if (node == null) return;
    _postOrder(node.left, list);
    _postOrder(node.right, list);
    list.add(node.value);
  }

  void _preOrder(N node, List<V> list) {
    if (node == null) return;
    list.add(node.value);
    _preOrder(node.left, list);
    _preOrder(node.right, list);
  }
}
