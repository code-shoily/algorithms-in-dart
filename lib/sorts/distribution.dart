import "common.dart";

/// Implements pigeonhole sort algorithm.
List<int> pigeonholeSort(List<int> list, {desc = false}) {
  if (list.isEmpty) return list;

  var boundaries = findMinMax(list);
  var min = boundaries["min"];
  var size = (boundaries["max"] - boundaries["min"]) + 1;

  var pigeonHole = List<int>.filled(size, 0);
  var sorted = List<int>(list.length);

  for (var item in list) pigeonHole[item - min]++;

  var idx = 0;
  for (var count = 0; count < size; count++)
    while (pigeonHole[count] > 0) {
      pigeonHole[count]--;
      sorted[idx] = min + count;
      idx++;
    }

  return desc ? sorted.reversed.toList() : sorted;
}

/// Implement counting sort
List<int> countingSort(List<int> list, {desc = false}) {
  if (list.isEmpty) return <int>[];
  var boundaries = findMinMax(list);
  if (boundaries["min"] < 0)
    throw FormatException("Cannot sort negative numbers");

  var bucket = List<int>.filled(boundaries["max"] + 1, 0);
  var sorted = List<int>(list.length);

  for (var item in list) bucket[item]++;

  for (var i = 1; i < bucket.length; i++) {
    bucket[i] = bucket[i - 1] + bucket[i];
  }

  for (var item in list) {
    bucket[item]--;
    sorted[bucket[item]] = item;
  }

  return desc ? sorted.reversed.toList() : sorted;
}
