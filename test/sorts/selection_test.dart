import 'package:test/test.dart';

import 'package:algorithms/sorts/selection.dart';

void main() {
  late List<int> randomList,
      sortedRandomListAscending,
      sortedRandomListDescending;

  late List<String> emptyList;

  bool ascendingFn(left, right) => left <= right;
  bool descendingFn(left, right) => left >= right;

  setUp(() {
    emptyList = [];
    randomList = [2, 4, 2, 1, -1, 0, 20];
    sortedRandomListAscending = [-1, 0, 1, 2, 2, 4, 20];
    sortedRandomListDescending = [20, 4, 2, 2, 1, 0, -1];
  });

  test('Heap Sort', () {
    expect(heapSort(randomList), equals(sortedRandomListAscending));
    expect(
        heapSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(
        heapSort(randomList, descendingFn), equals(sortedRandomListDescending));

    expect(heapSort(emptyList), equals(emptyList));
    expect(heapSort(emptyList, ascendingFn), equals(emptyList));
    expect(heapSort(emptyList, descendingFn), equals(emptyList));
  });

  test('Selection Sort', () {
    expect(selectionSort(randomList), equals(sortedRandomListAscending));
    expect(selectionSort(randomList, ascendingFn),
        equals(sortedRandomListAscending));
    expect(selectionSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(selectionSort(emptyList), equals(emptyList));
    expect(selectionSort(emptyList, ascendingFn), equals(emptyList));
    expect(selectionSort(emptyList, descendingFn), equals(emptyList));
  });
}
