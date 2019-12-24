class LinearSearch<T> {
  List<T> _hayStack;

  /// Create the class with all the data to be searched on
  LinearSearch(this._hayStack);

  /// Set the data to be searched on
  void set hayStack(List<T> hayStack) {
    this._hayStack = hayStack;
  }


  /// Search for an element, returns the index if found. `-1` otherwise.
  int searchWithIndex(T needle) {
    for (var i = 0; i < _hayStack.length; i++) {
      if (_hayStack[i] == needle) return i;
    }
    return -1;
  }

  /// Search for an element, returns `true` if exists, `false` otherwise
  bool search(T needle) => searchWithIndex(needle) != -1;
}
