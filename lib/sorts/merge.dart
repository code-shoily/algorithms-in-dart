import 'common.dart';

/// Implement Merge Sort.
List<T> mergeSort<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  void merge(
      List<T> list, int left, int middle, int right, Comparator<T> compareFn) {
    var leftList = list.sublist(left, middle + 1);
    var rightList = list.sublist(middle + 1, right + 1);

    var lIdx = 0, rIdx = 0;
    var idx = left;

    while (lIdx < leftList.length && rIdx < rightList.length) {
      if (compareFn(leftList[lIdx], rightList[rIdx])) {
        list[idx] = leftList[lIdx];
        lIdx++;
      } else {
        list[idx] = rightList[rIdx];
        rIdx++;
      }
      idx++;
    }

    for (var i = rIdx; i < rightList.length; i++) {
      list[idx++] = rightList[i];
    }
    for (var i = lIdx; i < leftList.length; i++) {
      list[idx++] = leftList[i];
    }
  }

  void mergeSort(List<T> list, int left, int right, Comparator<T> compareFn) {
    if (right > left) {
      var middle = (left + right) ~/ 2;

      mergeSort(list, left, middle, compareFn);
      mergeSort(list, middle + 1, right, compareFn);

      merge(list, left, middle, right, compareFn);
    }
  }

  mergeSort(list, 0, list.length - 1, compareFn);

  return list;
}
