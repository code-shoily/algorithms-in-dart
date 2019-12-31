import 'package:test/test.dart';

import 'package:algorithms_in_dart/sorts/common.dart';

void main() {
  List<num> anyList, singleValuedList, emptyList;
  setUp(() {
    emptyList = [];
    singleValuedList = [42];
    anyList = [32, 23, -161, 43, 65, -2, 45, 233, -12];
  });

  test('Is unsorted', () {
    expect(isSorted(anyList), equals(false));
  });

  test('Is sorted', () {
    anyList.sort();
    expect(isSorted(anyList), equals(true));
    expect(isSorted(emptyList), equals(true));
    expect(isSorted(singleValuedList), equals(true));
  });

  test('Is reverse sorted', () {
    anyList.sort();
    expect(isReverseSorted(anyList.reversed.toList()), equals(true));
    expect(isReverseSorted(emptyList), equals(true));
    expect(isReverseSorted(singleValuedList), equals(true));
  });

  test('Find min and max', () {
    expect(findMinMax(anyList), equals({'min': -161, 'max': 233}));
    expect(findMinMax(emptyList), equals(null));
    expect(findMinMax(singleValuedList), equals({'min': 42, 'max': 42}));
  });
}
