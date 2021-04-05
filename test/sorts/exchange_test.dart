import 'package:test/test.dart';

import 'package:algorithms/sorts/exchange.dart';

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

  test('Bubble Sort', () {
    expect(bubbleSort(randomList), equals(sortedRandomListAscending));
    expect(
        bubbleSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(bubbleSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(bubbleSort(emptyList), equals(emptyList));
    expect(bubbleSort(emptyList, ascendingFn), equals(emptyList));
    expect(bubbleSort(emptyList, descendingFn), equals(emptyList));
  });

  test('Odd-Event Sort', () {
    expect(oddEvenSort(randomList), equals(sortedRandomListAscending));
    expect(oddEvenSort(randomList, ascendingFn),
        equals(sortedRandomListAscending));
    expect(oddEvenSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(oddEvenSort(emptyList), equals(emptyList));
    expect(oddEvenSort(emptyList, ascendingFn), equals(emptyList));
    expect(oddEvenSort(emptyList, descendingFn), equals(emptyList));
  });

  test('Gnome Sort', () {
    expect(gnomeSort(randomList), equals(sortedRandomListAscending));
    expect(
        gnomeSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(gnomeSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(gnomeSort(emptyList), equals(emptyList));
    expect(gnomeSort(emptyList, ascendingFn), equals(emptyList));
    expect(gnomeSort(emptyList, descendingFn), equals(emptyList));
  });

  test('Quick Sort', () {
    expect(quickSort(randomList), equals(sortedRandomListAscending));
    expect(
        quickSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(quickSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(quickSort(emptyList), equals(emptyList));
    expect(quickSort(emptyList, ascendingFn), equals(emptyList));
    expect(quickSort(emptyList, descendingFn), equals(emptyList));
  });
}
