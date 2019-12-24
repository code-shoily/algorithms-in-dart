import 'package:test/test.dart';

import 'package:algorithms_in_dart/search/binary.dart';

void main() {
  BinarySearch emptyList, randomList;
  const sampleList1 = <int>[-7, 2, 3, 45, 65, 78, 90, 200, 4540];
  const sampleList2 = <int>[-1, 4, 6, 7, 10];

  setUp(() {
    emptyList = BinarySearch(<int>[]);
    randomList = BinarySearch(sampleList1);
  });

  test("Search for an item", () {
    for (var needle in sampleList1) {
      expect(randomList.search(needle), equals(true));
    }

    for (var needle = 0; needle < 100; needle++) {
      if (!sampleList1.contains(needle)) {
        expect(randomList.search(needle), equals(false));
      }
    }
  });

  test("Search index for an item", () {
    for (var i = 0; i < sampleList1.length; i++) {
      expect(randomList.searchWithIndex(sampleList1[i]), equals(i));
    }

    for (var needle = 0; needle < 100; needle++) {
      if (!sampleList1.contains(needle)) {
        expect(randomList.searchWithIndex(needle), equals(-1));
      }
    }
  });

  test("Set-up haystack", () {
    for (var needle in sampleList2) {
      expect(emptyList.search(needle), equals(false));
    }
    emptyList.hayStack = sampleList2;
    for (var needle in sampleList2) {
      expect(emptyList.search(needle), equals(true));
    }
  });
}
