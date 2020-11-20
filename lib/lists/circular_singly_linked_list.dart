import '../heaps/base.dart';

import './singly_linked_list.dart' show Node;

/// This circular linked list is based off of [SinglyLinkedList]
class CircularSinglyLinkedList<T> {
  /// Head of [this]
  Node<T>? head;

  /// Size of [this]
  int length;

  /// Construct a CircularLinkedList
  CircularSinglyLinkedList() : length = 0;

  /// Create and prepopulate [this] from a [List]
  CircularSinglyLinkedList.fromList(List<T> list) : length = 0 {
    for (var item in list) {
      append(item);
    }
  }

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
      head = newNode;
      newNode.next = head;
    } else {
      var currentNode = head;
      while (currentNode!.next != head) {
        currentNode = currentNode.next;
      }

      currentNode.next = newNode;
      newNode.next = head;
    }

    length++;
  }

  /// Adds data to the beginning of the list.
  void prepend(T data) {
    var newNode = Node(data);

    if (isEmpty) {
      head = newNode;
      newNode.next = head;
    } else {
      newNode.next = head;

      var currentNode = head;
      while (currentNode!.next != head) {
        currentNode = currentNode.next;
      }

      currentNode.next = newNode;
      head = newNode;
    }

    length++;
  }

  /// Remove from the end of the list
  Node<T> pop() {
    if (isEmpty) throw InvalidIndexError();

    var currentNode = head;
    var beforeLastNode = currentNode;

    do {
      beforeLastNode = currentNode;
      currentNode = currentNode!.next;
    } while (currentNode!.next != head);

    beforeLastNode!.next = head;

    length--;
    return currentNode;
  }

  /// Remove from the beginning of the list
  Node<T> shift() {
    if (isEmpty) throw InvalidIndexError();

    var removeMe = head;
    var currentNode = head;

    while (currentNode!.next != head) {
      currentNode = currentNode.next;
    }

    head = head!.next;
    currentNode.next = head;

    length--;
    return removeMe!;
  }
}
