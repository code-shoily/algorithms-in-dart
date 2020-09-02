import '../heaps/binary_heap.dart' show BinaryHeap;
import 'common.dart';

/// HeapSort
List<T> heapSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var sortedList = <T>[];
  var heap = BinaryHeap(compareFn)..insertMany(list);

  while (heap.length != 0) {
    sortedList.add(heap.pop());
  }

  return sortedList;
}

/// Selection Sort
List<T> selectionSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  for (var i = 0; i < list.length; i++) {
    var idxToSwap = i;
    for (var j = i + 1; j < list.length; j++) {
      if (!compareFn(list[idxToSwap], list[j])) {
        idxToSwap = j;
      }
    }
    swap(list, i, idxToSwap);
  }

  return list;
}
