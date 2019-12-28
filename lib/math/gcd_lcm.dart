int gcd(int x, int y) {
  return x == 0 ? y : gcd(y % x, x);
}

int lcm(int x, int y) {
  return (x * y) ~/ gcd(x, y);
}
