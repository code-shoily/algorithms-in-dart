import 'package:test/test.dart';

import 'package:algorithms/helpers/range.dart';

void main() {
  test('Test ranges', () {
    expect(1.to(1), equals(<int>[]));
    expect(10.to(15), equals(<int>[10, 11, 12, 13, 14]));
    expect((-1).to(-5), equals(<int>[-1, -2, -3, -4]));
    expect(5.to(1), equals(<int>[5, 4, 3, 2]));
  });
}
