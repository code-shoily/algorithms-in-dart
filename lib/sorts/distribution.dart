import 'common.dart';
import 'insertion.dart';

/// Types for functions that only sort integers
typedef IntSorterFn = List<int> Function(List<int>);

List<List<int>> _partitionBySign(List<int> list) =>
    list.fold([[], []], (acc, x) {
      acc[x < 0 ? 0 : 1].add(x);
      return acc;
    });

List<int> _sortNegativeByInversion(List<int> list, IntSorterFn sortFn) =>
    sortFn(list.map((n) => n * -1).toList())
        .reversed
        .map((n) => n * -1)
        .toList();

List<int> _sortByPartitioningIntegerSigns(List<int> list, IntSorterFn sortFn) {
  var partitions = _partitionBySign(list);
  var negatives = _sortNegativeByInversion(partitions[0], sortFn);
  var positives = sortFn(partitions[1]);

  return [...negatives, ...positives];
}

List<int> _countingSort(List<int> list) {
  if (list.isEmpty) return list;

  var boundaries = findMinMax(list);
  var max = boundaries['max'] as int;
  var bucket = List<int>.filled(max + 1, 0);
  var sorted = List<int>.filled(list.length, 0);

  for (var item in list) {
    bucket[item]++;
  }

  for (var i = 1; i < bucket.length; i++) {
    bucket[i] = bucket[i - 1] + bucket[i];
  }

  for (var item in list) {
    bucket[item]--;
    sorted[bucket[item]] = item;
  }

  return sorted;
}

/// Implement countingSort
List<int> countingSort(List<int> list, {bool desc = false}) {
  var sorted = _sortByPartitioningIntegerSigns(list, _countingSort);
  return desc ? sorted.reversed.toList() : sorted;
}

void _inPlaceCountSort(List<int> list, int exp) {
  var n = list.length;
  var sorted = List<int>.filled(n, 0);
  var count = List<int>.filled(10, 0);

  for (var i = 0; i < n; i++) {
    count[list[i] ~/ exp % 10]++;
  }

  for (var i = 1; i < 10; i++) {
    count[i] += count[i - 1];
  }

  for (var i = n - 1; i >= 0; i--) {
    sorted[count[list[i] ~/ exp % 10] - 1] = list[i];
    count[list[i] ~/ exp % 10]--;
  }

  for (var i = 0; i < n; i++) {
    list[i] = sorted[i];
  }
}

List<int> _radixSort(List<int> list) {
  if (list.isEmpty) return list;

  var boundaries = findMinMax(list);
  var max = boundaries['max'] as int;

  for (var exp = 1; max ~/ exp > 0; exp *= 10) {
    _inPlaceCountSort(list, exp);
  }

  return list;
}

/// Implement radix sort
List<int> radixSort(List<int> list, {bool desc = false}) {
  var sorted = _sortByPartitioningIntegerSigns(list, _radixSort);
  return desc ? sorted.reversed.toList() : sorted;
}

/// Implements pigeonhole sort algorithm.
List<int> pigeonholeSort(List<int> list, {bool desc = false}) {
  if (list.isEmpty) return list;

  var boundaries = findMinMax(list);
  var max = boundaries['max'] as int;
  var min = boundaries['min'] as int;
  var size = (max - min) + 1;

  var pigeonHole = List<int>.filled(size, 0);
  var sorted = List<int>.filled(list.length, 0);

  for (var item in list) {
    pigeonHole[item - min]++;
  }

  var idx = 0;
  for (var count = 0; count < size; count++) {
    while (pigeonHole[count] > 0) {
      pigeonHole[count]--;
      sorted[idx] = min + count;
      idx++;
    }
  }

  return desc ? sorted.reversed.toList() : sorted;
}

/// Implement bucketSort
List<T> bucketSort<T extends num>(List<T> list, {bool desc = false}) {
  if (list.isEmpty) return list;

  var boundaries = findMinMax(list);
  var max = boundaries['max'] as num;
  var min = boundaries['min'] as num;

  if (min < 0) {
    throw FormatException('This version only takes positive numbers');
  }

  var inputLength = list.length;
  var bucketSize = (max * inputLength).ceil() + 1;
  var buckets = List<List<T>>.filled(bucketSize, []);
  for (var i = 0; i < buckets.length; i++) {
    buckets[i] = <T>[];
  }

  for (var i = 0; i < inputLength; i++) {
    var idx = (inputLength * list[i]).round();
    buckets[idx].add(list[i]);
  }

  var sorted =
      buckets.fold(<T>[], (List<T> acc, el) => acc + insertionSort(el));
  return desc ? sorted.reversed.toList() : sorted;
}
