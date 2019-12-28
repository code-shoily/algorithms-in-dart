int gcd(int x, int y) {
  return x == 0 ? y : gcd(y % x, x);
}

int gcd_list(List<int> numbers) {
  if (numbers.length < 2) throw ArgumentError("Please add two or more numbers");
  return numbers.reduce((a, b) => gcd(a, b));
}

int lcm(int x, int y) {
  if (x * y == 0) throw ArgumentError("No number should be zero");
  return (x * y) ~/ gcd(x, y);
}

int lcm_list(List<int> numbers) {
  if (numbers.length < 2) throw ArgumentError("Please add two or more numbers");
  return numbers.reduce((a, b) => lcm(a, b)); 
}
