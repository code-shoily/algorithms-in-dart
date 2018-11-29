import "package:algorithms_in_dart/heaps/binary_heap.dart" show BinaryHeap;
import "common.dart";

/// HeapSort
List<T> heapSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var sortedList = <T>[];
  var heap = BinaryHeap(compareFn)..insertMany(list);

  while (heap.length != 0) sortedList.add(heap.pop());

  return sortedList;
}
