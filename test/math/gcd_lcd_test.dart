import 'package:test/test.dart';

import 'package:algorithms_in_dart/math/gcd_lcm.dart';

void main() {
  test('Test for LCM', () {
    expect(gcd(15, 20), equals(5));
    expect(gcd(5, 7), equals(1));
    expect(gcd(4, 6), equals(2));
    expect(gcd(0, 6), equals(6));
    expect(gcd(4, 0), equals(4));
    expect(gcd(0, 0), equals(0));
  });
  test('Test for LCM', () {
    expect(lcm(15, 20), equals(60));
    expect(lcm(5, 7), equals(35));
    expect(lcm(4, 6), equals(12));
  });
}