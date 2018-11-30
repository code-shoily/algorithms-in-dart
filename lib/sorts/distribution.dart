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
