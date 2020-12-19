import 'package:test/test.dart';

import 'package:algorithms/sorts/merge.dart';

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

  test('Merge Sort', () {
    expect(mergeSort(randomList), equals(sortedRandomListAscending));
    expect(
        mergeSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(mergeSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(mergeSort(emptyList), equals(emptyList));
    expect(mergeSort(emptyList, ascendingFn), equals(emptyList));
    expect(mergeSort(emptyList, descendingFn), equals(emptyList));
  });
}
