import "package:test/test.dart";

import "package:algorithms_in_dart/sorts/basic.dart";

void main() {
  List<int> randomList;
  List<int> sortedRandomListAscending;
  List<int> sortedRandomListDescending;

  List<String> emptyList;

  bool ascendingFn(left, right) => left <= right;
  bool descendingFn(left, right) => left >= right;

  setUp(() {
    emptyList = [];
    randomList = [2, 4, 2, 1, -1, 0, 20];
    sortedRandomListAscending = [-1, 0, 1, 2, 2, 4, 20];
    sortedRandomListDescending = [20, 4, 2, 2, 1, 0, -1];
  });

  test("Bubble Sort", () {
    expect(bubbleSort(randomList), equals(sortedRandomListAscending));
    expect(
        bubbleSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(bubbleSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(bubbleSort(emptyList), equals(emptyList));
    expect(bubbleSort(emptyList, ascendingFn), equals(emptyList));
    expect(bubbleSort(emptyList, descendingFn), equals(emptyList));
  });

  test("Insertion Sort", () {
    expect(insertionSort(randomList), equals(sortedRandomListAscending));
    expect(insertionSort(randomList, ascendingFn),
        equals(sortedRandomListAscending));
    expect(insertionSort(randomList, descendingFn),
        equals(sortedRandomListDescending));

    expect(insertionSort(emptyList), equals(emptyList));
    expect(insertionSort(emptyList, ascendingFn), equals(emptyList));
    expect(insertionSort(emptyList, descendingFn), equals(emptyList));
  });

  test("Heap Sort", () {
    expect(heapSort(randomList), equals(sortedRandomListAscending));
    expect(
        heapSort(randomList, ascendingFn), equals(sortedRandomListAscending));
    expect(
        heapSort(randomList, descendingFn), equals(sortedRandomListDescending));

    expect(heapSort(emptyList), equals(emptyList));
    expect(heapSort(emptyList, ascendingFn), equals(emptyList));
    expect(heapSort(emptyList, descendingFn), equals(emptyList));
  });
}
