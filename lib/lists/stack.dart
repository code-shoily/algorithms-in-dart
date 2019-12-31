class StackNode<T> {
  T data;
  StackNode below;

  StackNode({this.data});
}

/// A simple LIFO container.
class Stack<T> {
  /// Reference to the top of the stack
  StackNode<T> _top;

  /// Size of the stack
  int size;

  Stack()
      : _top = null,
        size = 0;

  /// Checks if the stack is empty
  bool get isEmpty => _top == null;

  /// Pops the top-most element of the stack.
  T pop() {
    if (isEmpty) throw Exception('Cannot pop from an empty stack');
    var output = _top;
    _top = _top.below;
    size--;

    return output.data;
  }

  /// Returns the top-most element of the stack but keeps the stack unmodified
  T peek() => _top?.data;

  /// Adds a new element on top of the stack.
  void push(T data) {
    var newNode = StackNode(data: data);
    if (isEmpty) {
      _top = newNode;
    } else {
      newNode.below = _top;
      _top = newNode;
    }
    size++;
  }
}
