import "common.dart";

/// The mighty Bubble Sort!
List<T> bubbleSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var size = list.length;

  for (var i = 0; i < size; i++) {
    for (var j = 1; j < (size - i); j++) {
      if (!compareFn(list[j - 1], list[j])) swap(list, j, j - 1);
    }
  }

  return list;
}

/// Odd/Even Sort
List<T> oddEvenSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var sorted = false;

  while (!sorted) {
    sorted = true;

    for (var i = 1; i < list.length - 1; i += 2) {
      if (!compareFn(list[i], list[i + 1])) {
        swap(list, i, i + 1);
        sorted = false;
      }
    }

    for (var i = 0; i < list.length - 1; i += 2) {
      if (!compareFn(list[i], list[i + 1])) {
        swap(list, i, i + 1);
        sorted = false;
      }
    }
  }

  return list;
}

/// Gnome Sort
List<T> gnomeSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var idx = 1;

  while (idx < list.length) {
    if (compareFn(list[idx - 1], list[idx])) {
      idx++;
    } else {
      swap(list, idx - 1, idx);

      if (--idx == 0) idx = 1;
    }
  }
  return list;
}
