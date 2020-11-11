import 'package:test/test.dart';

import 'package:algorithms/sorts/distribution.dart';

void main() {
  List<int> randomList;
  List<int> positiveRandomList;
  List<int> sortedRandomListAscending;
  List<int> sortedRandomListDescending;
  List<int> sortedPositiveRandomListAscending;
  List<int> sortedPositiveRandomListDescending;
  List<int> allNegatives;
  List<int> someNegatives;
  List<int> sortedAllNegatives;
  List<int> sortedSomeNegatives;

  List<int> emptyList;

  setUp(() {
    emptyList = [];
    randomList = [2, 4, 2, 1, -1, 0, 20];
    positiveRandomList = [1, 4, 1, 2, 7, 5, 2];

    sortedRandomListAscending = [-1, 0, 1, 2, 2, 4, 20];
    sortedRandomListDescending = [20, 4, 2, 2, 1, 0, -1];
    sortedPositiveRandomListAscending = [1, 1, 2, 2, 4, 5, 7];
    sortedPositiveRandomListDescending = [7, 5, 4, 2, 2, 1, 1];

    allNegatives = [-21, -2, -93];
    someNegatives = [23, -100, 34, -3, 34, 7];
    sortedAllNegatives = [-93, -21, -2];
    sortedSomeNegatives = [-100, -3, 7, 23, 34, 34];
  });

  test('Pigeonhole Sort', () {
    expect(pigeonholeSort(randomList), equals(sortedRandomListAscending));
    expect(pigeonholeSort(randomList, desc: false),
        equals(sortedRandomListAscending));
    expect(pigeonholeSort(randomList, desc: true),
        equals(sortedRandomListDescending));

    expect(pigeonholeSort(emptyList), equals(emptyList));
    expect(pigeonholeSort(emptyList, desc: false), equals(emptyList));
    expect(pigeonholeSort(emptyList, desc: true), equals(emptyList));
  });

  test('Counting Sort', () {
    expect(countingSort(positiveRandomList),
        equals(sortedPositiveRandomListAscending));
    expect(countingSort(positiveRandomList, desc: false),
        equals(sortedPositiveRandomListAscending));
    expect(countingSort(positiveRandomList, desc: true),
        equals(sortedPositiveRandomListDescending));

    expect(countingSort(emptyList), equals(emptyList));
    expect(countingSort(emptyList, desc: false), equals(emptyList));
    expect(countingSort(emptyList, desc: true), equals(emptyList));

    expect(countingSort(allNegatives), equals(sortedAllNegatives));
    expect(countingSort(someNegatives), equals(sortedSomeNegatives));
  });

  test('Radix Sort for positive numbers', () {
    expect(radixSort(positiveRandomList),
        equals(sortedPositiveRandomListAscending));
    expect(radixSort(positiveRandomList, desc: false),
        equals(sortedPositiveRandomListAscending));
    expect(radixSort(positiveRandomList, desc: true),
        equals(sortedPositiveRandomListDescending));

    expect(radixSort(emptyList), equals(emptyList));
    expect(radixSort(emptyList, desc: false), equals(emptyList));
    expect(radixSort(emptyList, desc: true), equals(emptyList));

    expect(radixSort(allNegatives), equals(sortedAllNegatives));
    expect(radixSort(someNegatives), equals(sortedSomeNegatives));
  });
}
