import 'common.dart';

/// Insertion Sort
List<T> insertionSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  for (var i = 1; i < list.length; i++) {
    var key = list[i];
    var j = i - 1;
    while (j >= 0 && !compareFn(list[j], key)) {
      list[j + 1] = list[j];
      j--;
    }

    list[j + 1] = key;
  }
  return list;
}
