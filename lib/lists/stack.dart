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
      : this._top = null,
        this.size = 0;

  /// Checks if the stack is empty
  bool get isEmpty => this._top == null;

  /// Pops the top-most element of the stack.
  T pop() {
    if (this.isEmpty) throw Exception("Cannot pop from an empty stack");
    var output = this._top;
    this._top = this._top.below;
    this.size--;

    return output.data;
  }

  /// Returns the top-most element of the stack but keeps the stack unmodified
  T peek() => this._top?.data;

  /// Adds a new element on top of the stack.
  void push(T data) {
    var newNode = new StackNode(data: data);
    if (this.isEmpty) {
      this._top = newNode;
    } else {
      newNode.below = this._top;
      this._top = newNode;
    }
    this.size++;
  }
}
