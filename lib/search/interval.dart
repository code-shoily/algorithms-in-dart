/// `binarySearch` searches for `needle` in `hayStack` by the Binary Search
/// algorithm
int binarySearch<T extends Comparable>(List<T> hayStack, T needle) {
  var min = 0;
  var max = hayStack.length;

  while (min < max) {
    var mid = min + ((max - min) >> 1);
    var comparison = hayStack[mid].compareTo(needle);
    if (comparison == 0) return mid;
    if (comparison < 0) {
      min = mid + 1;
    } else {
      max = mid;
    }
  }
  return -1;
}
