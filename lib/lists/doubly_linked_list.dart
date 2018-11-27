/// The DoublyLinkedList Node.
///
/// It has both previous and next references.
class Node<T> {
  /// The data [this] contains
  T data;

  /// Reference to previous [Node]
  Node previous;

  /// Reference to next [Node]
  Node next;

  /// Initialize [Node] with data.
  Node({this.data});
}

class DoublyLinkedList<T> {
  /// First node of the list
  Node<T> head;

  /// Last node of the list
  Node<T> tail;

  /// Size of the list
  int size;

  DoublyLinkedList() : size = 0;

  DoublyLinkedList.fromList(List<T> list) : size = 0 {
    for (var item in list) {
      this.append(item);
    }
  }

  /// Checks if [this] is empty
  bool get isEmpty => size == 0;

  /// Converts [this] into a [List]
  List<T> get toList {
    var asList = <T>[];

    var current = head;
    while (current != null) {
      asList.add(current.data);
      current = current.next;
    }

    return asList;
  }

  /// Show the [n]th element of the list.
  ///
  /// The list remains unmodified. `null` when index is out of bounds
  Node<T> at(int n) {
    if (n >= size || size < 0) return null;

    var current = head;
    for (var index = 0; index != n; index++) {
      current = current.next;
    }

    return current;
  }

  /// Add something to the beginning of [this]
  void prepend(T data) {
    var newNode = Node(data: data);

    if (isEmpty) {
      _setOnlyNode(newNode);
    } else {
      newNode.next = head;
      head.previous = newNode;
      head = newNode;
    }

    size++;
  }

  /// Add something at the end of [this]
  void append(T data) {
    var newNode = Node(data: data);

    if (isEmpty) {
      _setOnlyNode(newNode);
    } else {
      newNode.previous = tail;
      tail.next = newNode;
      tail = newNode;
    }

    size++;
  }

  /// Insert [data] at [n] index
  void insert(T data, int n) {
    Node<T> newNode = Node(data: data);

    var nextNode = at(n);

    if (nextNode == null) {
      throw "Invalid index";
    } else {
      if (nextNode == head) {
        prepend(newNode.data);
      } else {
        newNode.next = nextNode;
        newNode.previous = nextNode.previous;

        newNode.previous.next = newNode;
        nextNode.previous = newNode;
        size++;
      }
    }
  }

  /// Remove the last element
  Node<T> pop() {
    if (isEmpty) throw "Cannot remove from empty list";

    var removeMe = tail;
    if (size == 1) {
      _makeEmpty();
    } else {
      tail = removeMe.previous;
      tail.next = null;
      removeMe.previous = null;
    }

    size--;
    return removeMe;
  }

  /// Remove the first element
  Node<T> shift() {
    if (isEmpty) throw "Cannot remove from empty list";

    var removeMe = head;
    if (size == 1) {
      _makeEmpty();
    } else {
      head = removeMe.next;
      head.previous = null;
      removeMe.next = null;
    }

    size--;
    return removeMe;
  }

  /// Remove from [n] index
  Node<T> remove(int n) {
    Node<T> removeMe = at(n);

    if (removeMe == null) {
      throw "Invalid index";
    } else {
      if (removeMe == head) {
        return shift();
      } else if (removeMe == tail) {
        return pop();
      } else {
        removeMe.previous?.next = removeMe.next;
        removeMe.next?.previous = removeMe.previous;
        size--;
      }
    }

    return removeMe;
  }

  /// Set this list to empty
  _makeEmpty() {
    head = null;
    tail = null;
  }

  /// Set [node] as the only node for [this]
  _setOnlyNode(Node node) {
    head = node;
    tail = node;
  }
}
