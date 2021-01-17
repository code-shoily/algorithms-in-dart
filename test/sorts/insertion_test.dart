import 'package:test/test.dart';

import 'package:algorithms/sorts/insertion.dart';

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

  test('Insertion Sort', () {
    expect(insertionSort(randomList), equals(sortedRandomListAscending));
    expect(insertionSort(randomList, ascendingFn),
        equals(sortedRandomListAscending));
    expect(insertionSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(insertionSort(emptyList), equals(emptyList));
    expect(insertionSort(emptyList, ascendingFn), equals(emptyList));
    expect(insertionSort(emptyList, descendingFn), equals(emptyList));
  });
}
