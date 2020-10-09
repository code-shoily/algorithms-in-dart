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
    extends TreeADT<N, V> {}
