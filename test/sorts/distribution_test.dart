import "package:test/test.dart";

import "package:algorithms_in_dart/sorts/distribution.dart";

void main() {
  List<int> randomList;
  List<int> sortedRandomListAscending;
  List<int> sortedRandomListDescending;

  List<int> emptyList;

  setUp(() {
    emptyList = [];
    randomList = [2, 4, 2, 1, -1, 0, 20];
    sortedRandomListAscending = [-1, 0, 1, 2, 2, 4, 20];
    sortedRandomListDescending = [20, 4, 2, 2, 1, 0, -1];
  });

  test("Pigeonhole Sort", () {
    expect(pigeonholeSort(randomList), equals(sortedRandomListAscending));
    expect(pigeonholeSort(randomList, desc: false),
        equals(sortedRandomListAscending));
    expect(pigeonholeSort(randomList, desc: true),
        equals(sortedRandomListDescending));

    expect(pigeonholeSort(emptyList), equals(emptyList));
    expect(pigeonholeSort(emptyList, desc: false), equals(emptyList));
    expect(pigeonholeSort(emptyList, desc: true), equals(emptyList));
  });
}
