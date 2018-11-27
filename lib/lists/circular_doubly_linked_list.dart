import "package:algorithms_in_dart/lists/doubly_linked_list.dart" show Node;

/// This circular linked list is based off of [DoublyLinkedList]
class CircularDoublyLinkedList<T> {
  /// First node of the list
  Node<T> head;

  /// Last node of the list
  Node<T> tail;

  /// Size of the list
  int size;

  CircularDoublyLinkedList() : size = 0;

  /// Converts [this] into a [List]
  List<T> get toList {
    var list = [];
    var currentNode = head;

    while (currentNode.next != head) {
      list.add(currentNode);
      currentNode = currentNode.next;
    }
    return list;
  }

  CircularDoublyLinkedList.fromList(List<T> list) : size = 0 {
    for (var item in list) {
      this.append(item);
    }
  }

  /// Checks if [this] is empty
  bool get isEmpty => this.size == 0;

  /// Adds data to the end of the list
  void append(T data) {
    var newNode = Node(data: data);

    if (isEmpty) {
      _makeSingleNode(newNode);
    } else {
      tail.next = newNode;
      newNode.previous = tail;
      newNode.next = head;

      tail = newNode;
    }
    size++;
  }

  /// Adds data to the beginning of the list.
  void prepend(T data) {
    var newNode = Node(data: data);

    if (isEmpty) {
      _makeSingleNode(newNode);
    } else {
      newNode.next = head;
      head.previous = newNode;
      tail.next = newNode;

      head = newNode;
    }
    size++;
  }

  /// Remove from the end of the list
  Node<T> pop() {
    if (isEmpty) throw "Cannot remove from an empty list";
    var removeMe = tail;

    tail = tail.previous;
    tail.next = head;
    head.previous = tail;

    size--;
    return removeMe;
  }

  /// Remove from the beginning of the list
  Node<T> shift() {
    if (isEmpty) throw "Cannot remove from an empty list";

    var removeMe = head;

    head = head.next;
    head.previous = tail;
    tail.next = head;

    size--;
    return removeMe;
  }

  /// Create a single node on an empty list
  _makeSingleNode(Node<T> newNode) {
    head = newNode;
    tail = newNode;

    head.next = tail;
    head.previous = tail;
    tail.next = head;
    tail.previous = head;
  }
}
