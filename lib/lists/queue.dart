/// QueueNode that contains ahead and behind references.
class QueueNode<T> {
  /// Data of the node
  T data;

  /// Reference to the node before [this]
  QueueNode ahead;

  /// Reference to the node after [this]
  QueueNode behind;

  QueueNode({this.data})
      : ahead = null,
        behind = null;
}

// A simple linked list based FIFO.
class Queue<T> {
  /// The first inserted member of the queue
  QueueNode<T> _head;

  /// The latest inserted member of the queue
  QueueNode<T> _tail;

  /// The size of the queue
  int size;

  /// Create an empty [Queue]
  Queue()
      : _head = null,
        _tail = null,
        size = 0;

  /// Show the first element and dequeue candidate
  T get head => _head?.data;

  /// Show the most recently enqueued element
  T get tail => _tail?.data;

  /// Check if the size of the queue is empty
  bool get isEmpty => _head == null;

  /// Enqueue a new item to the Queue
  void enqueue(T data) {
    var newNode = QueueNode(data: data);

    if (isEmpty) {
      _head = newNode;
    } else {
      newNode.ahead = _tail;
      _tail.behind = newNode;
    }

    size++;
    _tail = newNode;
  }

  /// Dequeue the oldest item from the queue. Throw exception on empty queue
  T dequeue() {
    if (isEmpty) throw Exception('Cannot dequeue from empty queue');

    var output = _head;

    if (_head.behind == null) {
      _head = null;
      _tail = null;
    } else {
      _head = _head.behind;
    }

    size--;
    return output.data;
  }
}
