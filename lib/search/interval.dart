int binarySearch<T extends Comparable>(List<T> hayStack, T needle) {
    int min = 0;
    int max = hayStack.length;

    while (min < max) {
      int mid = min + ((max - min) >> 1);
      int comparison = hayStack[mid].compareTo(needle);
      if (comparison == 0) return mid;
      if (comparison < 0) {
        min = mid + 1;
      } else {
        max = mid;
      }
    }
    return -1;
}
