import "common.dart";

/// The mighty Bubble Sort!
List<T> bubbleSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var size = list.length;

  for (var i = 0; i < size; i++) {
    for (var j = 1; j < (size - i); j++) {
      if (!compareFn(list[j - 1], list[j])) {
        var temp = list[j - 1];
        list[j - 1] = list[j];
        list[j] = temp;
      }
    }
  }

  return list;
}
