/// QueueNode that contains ahead and behind references.
class QueueNode<T> {
  /// Data of the node
  T data;

  /// Reference to the node before [this]
  QueueNode ahead;

  /// Reference to the node after [this]
  QueueNode behind;

  QueueNode({this.data})
      : this.ahead = null,
        this.behind = null;
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
      : this._head = null,
        this._tail = null,
        this.size = 0;

  /// Show the first element and dequeue candidate
  T get head => this._head?.data;

  /// Show the most recently enqueued element
  T get tail => this._tail?.data;

  /// Check if the size of the queue is empty
  bool get isEmpty => this._head == null;

  /// Enqueue a new item to the Queue
  void enqueue(T data) {
    var newNode = QueueNode(data: data);

    if (this.isEmpty) {
      this._head = newNode;
    } else {
      newNode.ahead = this._tail;
      this._tail.behind = newNode;
    }

    this.size++;
    this._tail = newNode;
  }

  /// Dequeue the oldest item from the queue. Throw exception on empty queue
  T dequeue() {
    if (this.isEmpty) throw Exception("Cannot dequeue from empty queue");

    var output = this._head;

    if (this._head.behind == null) {
      this._head = null;
      this._tail = null;
    } else {
      this._head = this._head.behind;
    }

    this.size--;
    return output.data;
  }
}
