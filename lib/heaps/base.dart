/// Custom [Error] that's thrown whenever the index is invalid.
class InvalidIndexError extends Error {
  @override
  String toString() => 'Invalid Index for this operation';
}

/// Mixin to help with indexing functions of heaps
mixin BinaryHeapIndex {
  /// Parent index of [idx]
  int parentOf(int idx) =>
      idx >= 0 ? ((idx - 1) / 2).truncate() : throw InvalidIndexError();

  /// Left child index of [idx]
  int leftOf(int idx) => 2 * idx + 1;

  /// Right child index of [idx]
  int rightOf(int idx) => 2 * idx + 2;
}

/// Comparison logic of two objects, based on which nature of heaps will
/// be determined.
typedef Comparer<T> = bool Function(T parent, T child);

/// Base class for Heap
abstract class HeapBase<T> {
  bool get isEmpty;
  int length;

  void insert(T item);
  void insertMany(List<T> items);
  void heapify(int rootIndex);

  T pop();
  T peek();
}
