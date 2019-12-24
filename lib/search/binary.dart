class BinarySearch<T extends Comparable> {
  List<T> _hayStack;
  
  /// Set the data to be searched on
  void set hayStack(List<T> hayStack) => _hayStack = hayStack;

  /// Create the class with all the data to be searched on
  BinarySearch(this._hayStack);


  /// Search for an element, returns the index if found. `-1` otherwise.
  int searchWithIndex(T needle) {
    int min = 0;
    int max = _hayStack.length;

    while (min < max) {
      int mid = min + ((max - min) >> 1);
      int comparison = _hayStack[mid].compareTo(needle);
      if (comparison == 0) return mid;
      if (comparison < 0) {
        min = mid + 1;
      } else {
        max = mid;
      }
    }
    return -1;
  }

  /// Search for an element, returns `true` if exists, `false` otherwise
  bool search(T needle) => searchWithIndex(needle) == -1 ? false : true;
}
