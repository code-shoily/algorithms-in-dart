import 'package:test/test.dart';

import 'package:algorithms/search/sequential.dart';

void main() {
  const sampleList = <int>[-7, 2, 3, 45, 65, 78, 90, 200, 4540];
  test('Search for an item', () {
    for (var i = 0; i < sampleList.length; i++) {
      expect(linearSearch(sampleList, sampleList[i]), equals(i));
    }

    for (var needle = 0; needle < 100; needle++) {
      if (!sampleList.contains(needle)) {
        expect(linearSearch(sampleList, needle), equals(-1));
      }
    }
  });
}
