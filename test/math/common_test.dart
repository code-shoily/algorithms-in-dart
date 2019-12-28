import 'package:test/test.dart';

import 'package:algorithms_in_dart/math/common.dart';

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
    try {
      lcm(4, 0);
    } catch (e) {
      expect(e is ArgumentError, isTrue);
    }
  });

  test('Test for LCM (List)', () {
    try {
      gcd_list([5]);
    } catch (e) {
      expect(e is ArgumentError, isTrue);
    }
    expect(gcd_list([5, 7]), equals(1));
    expect(gcd_list([4, 6]), equals(2));
    expect(gcd_list([4, 6, 0]), equals(2));
    expect(gcd_list([15, 20, 25, 30, 35]), equals(5));
    expect(gcd_list([0, 6, 9, 0, 12]), equals(3));
    expect(gcd_list([0, 0, 0, 0, 0]), equals(0));
  });
  test('Test for LCM (List)', () {
    try {
      lcm_list([4]);
    } catch (e) {
      expect(e is ArgumentError, isTrue);
    }
    expect(lcm_list([15, 20, 25, 30, 35]), equals(2100));
    expect(lcm_list([5, 7, 2]), equals(70));
  });

  test('Factorial', () {
    expect(factorial(0), equals(1));
    expect(factorial(1), equals(1));
    expect(factorial(2), equals(2));
    expect(factorial(3), equals(6));
    expect(factorial(4), equals(24));
    expect(factorial(5), equals(120));

    try {
      factorial(-2);
    } catch (e) {
      expect(e is ArgumentError, isTrue);
    }
  });
}
