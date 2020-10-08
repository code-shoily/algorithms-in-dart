import './tree_adt.dart';

/// Declares members of a binary node.
abstract class BinaryNodeADT<N, V extends Comparable> extends NodeADT<N, V> {
  /// Left child node.
  N get left;
  set left(N node);

  /// Right child node.
  N get right;
  set right(N node);
}

/// A binary tree data structure can be defined recursively as a collection of
///  binary nodes (starting at a [root] node).
abstract class BinaryTreeADT<N extends BinaryNodeADT, V extends Comparable>
    extends TreeADT<N, V> {}
