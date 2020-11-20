import '../heaps/base.dart';

import './doubly_linked_list.dart' show Node;

/// This circular linked list is based off of [DoublyLinkedList]
class CircularDoublyLinkedList<T> {
  /// First node of the list
  Node<T>? head;

  /// Last node of the list
  Node<T>? tail;

  /// Size of the list
  int length;

  /// Construct a doubly circular linked list
  CircularDoublyLinkedList() : length = 0;

  /// Converts [this] into a [List]
  List<T> get toList {
    if (isEmpty) return [];

    var list = <T>[head!.data];
    var currentNode = head!.next;

    while (currentNode != head) {
      list.add(currentNode!.data);
      currentNode = currentNode.next;
    }

    return list;
  }

  /// Creates CircularDoublyLinkedList from [list]
  CircularDoublyLinkedList.fromList(List<T> list) : length = 0 {
    for (var item in list) {
      append(item);
    }
  }

  /// Checks if [this] is empty
  bool get isEmpty => length == 0;

  /// Returns the element [n].
  ///
  /// Since this is a circular linked list, if [n] is greater than the size,
  /// it will still iterate, circling back to the beginning every time.
  Node<T> at(int n) {
    if (n < 0) throw InvalidIndexError();

    var currentNode = head;
    for (var i = 0; i < n; i++, currentNode = currentNode!.next) {
      ;
    }

    return currentNode!;
  }

  /// Adds data to the end of the list
  void append(T data) {
    var newNode = Node(data);

    if (isEmpty) {
      _makeSingleNode(newNode);
    } else {
      tail!.next = newNode;
      newNode.previous = tail;
      newNode.next = head;

      tail = newNode;
    }
    length++;
  }

  /// Adds data to the beginning of the list.
  void prepend(T data) {
    var newNode = Node(data);

    if (isEmpty) {
      _makeSingleNode(newNode);
    } else {
      newNode.next = head;
      head!.previous = newNode;
      tail!.next = newNode;

      head = newNode;
    }
    length++;
  }

  /// Remove from the end of the list
  Node<T> pop() {
    if (isEmpty) throw InvalidIndexError();
    var removeMe = tail!;

    tail = tail!.previous;
    tail!.next = head;
    head!.previous = tail;

    length--;
    return removeMe;
  }

  /// Remove from the beginning of the list
  Node<T> shift() {
    if (isEmpty) throw InvalidIndexError();

    var removeMe = head!;

    head = head!.next;
    head!.previous = tail;
    tail!.next = head;

    length--;
    return removeMe;
  }

  /// Create a single node on an empty list
  void _makeSingleNode(Node<T> newNode) {
    head = newNode;
    tail = newNode;

    head!.next = tail;
    head!.previous = tail;
    tail!.next = head;
    tail!.previous = head;
  }
}
