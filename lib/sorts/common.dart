import '../heaps/base.dart';

/// Comparator function compared [left] with [right]
typedef Comparator<T extends Comparable> = bool Function(T left, T right);

/// Makes sure left is less than right.
///
/// In a sorting algorithm, this function needs to be true if the
/// sorting needs to return ascending order of lists.
///
/// For example, if we see an ascending ordered list- `[1, 2, 3, 5]`
/// we can see from left to right, all two consecutive elements in
/// this function would return true, in other words, settings this as
/// `reduce` function would yield true for a list sorted in ascending
/// order.
bool ascendingFn<T extends Comparable>(Comparable a, Comparable b) =>
    a.compareTo(b) <= 0;

/// Swaps two elements in a [List]
void swap<T extends Comparable>(List<T> list, int i, int j) {
  if (i == j) return;
  var temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}

/// Checks if the list is sorted according to [compareFn]
bool isSorted<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var i = 0;

  while (i < list.length - 1 && list.length > 1) {
    if (!compareFn(list[i], list[i + 1])) return false;
    ++i;
  }

  return true;
}

/// Checks if the list is sorted reversely.
bool isReverseSorted<T extends Comparable>(List<T> list,
    [Comparator<T> compareFn = ascendingFn]) {
  var i = 0;

  while (i < list.length - 1 && list.length > 1) {
    if (compareFn(list[i], list[i + 1])) return false;
    i++;
  }

  return true;
}

/// Returns the minimum and maximum of a [List] as a [Map]
///
/// The minimum and maximum values are stored as "min"
/// and "max" kets in the [Map] returned.
Map<String, num> findMinMax(List<num> list) {
  if (list.isEmpty) throw InvalidIndexError();

  var min = list[0];
  var max = list[0];

  for (var item in list) {
    if (item < min) min = item;
    if (item > max) max = item;
  }

  return {'min': min, 'max': max};
}
