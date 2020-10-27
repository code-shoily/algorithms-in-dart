import './base.dart';

/// A binary heap is a complete binary tree which holds heap property.
///
/// There is a relationship between parents and children in that parents should
/// always be either larger or smaller (based on a function provided) than
/// children.
/// [BinaryHeap] is a generic binary heap and takes in a function which
/// determines the parent/child relationship/positioning.
///
/// Based on particular functions, we can derive [MinHeap] or [MaxHeap] from it.
class BinaryHeap<T> extends HeapBase<T> with BinaryHeapIndex {
  /// The comparison function
  Comparer<T> compare;

  /// The implicit array of objects
  List<T> items;

  /// Constructor
  BinaryHeap(this.compare) : items = <T>[];

  /// Checks if this heap is empty
  @override
  bool get isEmpty => items.isEmpty;

  /// Returns the size of the container
  @override
  int get length => items.length;

  /// Swaps the items in [a] with [b] of [this]
  void swap(int a, int b) {
    var temp = items[a];
    items[a] = items[b];
    items[b] = temp;
  }

  /// Insert an item into [this].
  ///
  /// The logic which determines the parent/child relationship
  /// in the list is the result of [compare] function. `compare(parent, child)`
  /// must always be true for their hierarchical relationship to hold.
  ///
  /// For example, on a `min-heap`, compare function is `(a, b) => a < b`
  @override
  void insert(T item) {
    items.add(item);
    var i = items.length - 1;
    var parent = parentOf(i);

    while (parent != i && !compare(items[parent], items[i])) {
      swap(parent, i);
      i = parent;
      parent = parentOf(i);
    }
  }

  /// Inserts all elements of a list into [this]
  @override
  void insertMany(List<T> items) {
    for (var item in items) {
      insert(item);
    }
  }

  /// Turns the sublist starting at index [idx] into a heap.
  @override
  void heapify(int idx) {
    if (idx > length) throw InvalidIndexError();

    var leader = idx;
    var left = leftOf(idx);
    var right = rightOf(idx);

    if (left < length && !compare(items[leader], items[left])) {
      leader = left;
    }

    if (right < length && !compare(items[leader], items[right])) {
      leader = right;
    }

    if (leader != idx) {
      swap(leader, idx);
      heapify(leader);
    }
  }

  /// Shows the root of the heap.
  ///
  /// For `min-heap` it's the smallest element and for `max-heap` it's the
  /// largest
  @override
  T peek() {
    return items.first;
  }

  /// Removes and returns the root of the heap.
  ///
  /// For `min-heap` it's the smallest element and for `max-heap` it's the
  /// largest.
  /// The heap properties remain intact after removal.
  @override
  T pop() {
    var result = items.first;
    items[0] = items.last;
    items = items.sublist(0, items.length - 1);
    heapify(0);

    return result;
  }
}

/// An implementation of a min-heap.
///
/// [MinHeap] is a specific implementation of [BinaryHeap] where
/// parents should always be smaller than children.
class MinHeap extends BinaryHeap {
  /// Constructor
  MinHeap() : super((parent, child) => parent <= child);
}

/// An implementation of a max-heap.
///
/// [MaxHeap] is a specific implementation of [BinaryHeap] where
/// parents should always be larger than children.
class MaxHeap extends BinaryHeap {
  /// Constructor
  MaxHeap() : super((parent, child) => parent >= child);
}
