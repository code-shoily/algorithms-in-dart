/// Extension for getting a range `[from, to)`
extension NumRange on int {
  /// Returns a range of `[this, end)`. Counts up and down both.
  ///
  /// Usage:
  ///   `1.to(10)` for a list of numbers from 1 to 10 (10 excluded)
  ///   `10.to(1)` for a list of numbers from 10 to 1 (1 excluded)
  List<int> to(int end) => [
        for (var n = this;
            (this > end) ? n > end : n < end;
            (this > end) ? n-- : n++)
          n
      ];
}
