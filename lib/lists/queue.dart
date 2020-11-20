/// QueueNode that contains ahead and behind references.
class QueueNode<T> {
  /// Data of the node
  T data;

  /// Reference to the node before [this]
  QueueNode<T>? ahead;

  /// Reference to the node after [this]
  QueueNode<T>? behind;

  /// Construct a Queue node
  QueueNode(this.data);
}

/// A simple linked list based FIFO.
class Queue<T> {
  /// The first inserted member of the queue
  QueueNode<T>? _head;

  /// The latest inserted member of the queue
  QueueNode<T>? _tail;

  /// The size of the queue
  int length;

  /// Create an empty [Queue]
  Queue() : length = 0;

  /// Show the first element and dequeue candidate
  T? get head => _head?.data;

  /// Show the most recently enqueued element
  T? get tail => _tail?.data;

  /// Check if the size of the queue is empty
  bool get isEmpty => _head == null;

  /// Enqueue a new item to the Queue
  void enqueue(T data) {
    var newNode = QueueNode(data);

    if (isEmpty) {
      _head = newNode;
    } else {
      newNode.ahead = _tail;
      _tail!.behind = newNode;
    }

    length++;
    _tail = newNode;
  }

  /// Dequeue the oldest item from the queue. Throw exception on empty queue
  T dequeue() {
    if (isEmpty) throw Exception('Cannot dequeue from empty queue');

    var output = _head;

    if (_head!.behind == null) {
      _head = null;
      _tail = null;
    } else {
      _head = _head!.behind;
    }

    length--;
    return output!.data;
  }
}
