import 'package:algorithms/heaps/base.dart';
import 'package:algorithms/sorts/common.dart' as sorts;
import 'package:test/test.dart';

void main() {
  late List<num> anyList, singleValuedList, emptyList;
  setUp(() {
    emptyList = [];
    singleValuedList = [42];
    anyList = [32, 23, -161, 43, 65, -2, 45, 233, -12];
  });

  test('Is unsorted', () {
    expect(sorts.isSorted(anyList), equals(false));
  });

  test('Is sorted', () {
    anyList.sort();
    expect(sorts.isSorted(anyList), equals(true));
    expect(sorts.isSorted(emptyList), equals(true));
    expect(sorts.isSorted(singleValuedList), equals(true));
  });

  test('Is reverse sorted', () {
    anyList.sort();
    expect(sorts.isReverseSorted(anyList.reversed.toList()), equals(true));
    expect(sorts.isReverseSorted(emptyList), equals(true));
    expect(sorts.isReverseSorted(singleValuedList), equals(true));
  });

  test('Find min and max', () {
    expect(sorts.findMinMax(anyList), equals({'min': -161, 'max': 233}));
    expect(
        () => sorts.findMinMax(emptyList), throwsA(isA<InvalidIndexError>()));
    expect(sorts.findMinMax(singleValuedList), equals({'min': 42, 'max': 42}));
  });
}
