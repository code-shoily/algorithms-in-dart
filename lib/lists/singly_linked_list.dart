import '../heaps/base.dart';

/// A Node containing reference to the next node.
class Node<T> {
  /// Information for [this]
  T data;

  /// Reference to the [next] Node
  Node<T>? next;

  /// We initiate a [Node] either with just the data or with the [next]
  ///
  /// ```dart
  /// var node = Node(data: 10) // Next is null
  ///
  /// var list = Node(data: 10, next: Node(data: 20, next: Node(data: 30)))
  /// ```
  Node(this.data, {this.next});
}

/// A singly linked list. Contains a Node marked as head.
///
/// Whenever we are inserting or removing based on indices, a 0-indexed value is
/// assumed. Therefore, to be valid, an index (position) must be a valid
/// non-negative integer that is less than the length of the list. This version
/// does not support negative indices.
///
/// Read more about this at [Wiki](https://en.wikipedia.org/wiki/Linked_list)
class SinglyLinkedList<T> {
  /// The head of the list
  Node<T>? _head;

  /// Initiates an empty [SinglyLinkedList]
  SinglyLinkedList() : _head = null;

  /// Prefills a [SinglyLinkedList] with [list] values
  SinglyLinkedList.fromList(List list) {
    for (var element in list) {
      append(element);
    }
  }

  /// Checks if this list is empty
  bool get isEmpty {
    return _head == null;
  }

  /// Returns the length of this list
  int get length {
    var length = 0;
    var currentNode = _head;

    while (currentNode != null) {
      currentNode = currentNode.next;
      length++;
    }
    return length;
  }

  /// Converts a linked list into a list
  List<T> get toList {
    var asList = <T>[];
    var currentNode = _head;

    while (currentNode != null) {
      asList.add(currentNode.data);
      currentNode = currentNode.next;
    }

    return asList;
  }

  /// Shows the last node of the list. `null` for empty lists.
  T peek() {
    if (isEmpty) throw InvalidIndexError();

    var currentNode = _head;
    while (currentNode?.next != null) {
      currentNode = currentNode!.next;
    }
    return currentNode!.data;
  }

  /// Shows the element at position [position]. `null` for invalid positions.
  T at(int position) {
    if (isEmpty || length < position || position < 0) throw InvalidIndexError();

    var node = _head;
    var current = 0;

    while (current != position) {
      node = node!.next;
      current++;
    }
    return node!.data;
  }

  /// Inserts [data] at the end of the list.
  void append(T data) {
    var newNode = Node(data);

    if (isEmpty) {
      _head = newNode;
    } else {
      var currentNode = _head;
      while (currentNode?.next != null) {
        currentNode = currentNode!.next;
      }

      currentNode!.next = newNode;
    }
  }

  /// Inserts [data] at [position]. Raises exception for invalid positions.
  void insert(T data, int position) {
    if (length < position || position < 0) {
      throw Exception('Invalid position');
    }
    var newNode = Node(data);
    var index = 0;
    var currentNode = _head;
    Node<T>? previousNode;

    while (index != position) {
      previousNode = currentNode;
      currentNode = currentNode!.next;
      index++;
    }

    if (previousNode == null) {
      _head = newNode;
    } else {
      previousNode.next = newNode;
    }

    newNode.next = currentNode;
  }

  /// Removes the last element. Raises exception for empty lists.
  T pop() {
    if (isEmpty) throw InvalidIndexError();

    Node<T>? previousNode;
    var currentNode = _head;

    while (currentNode != null) {
      if (currentNode.next == null) {
        if (previousNode == null) {
          _head = null;
        } else {
          previousNode.next = null;
        }
        break;
      } else {
        previousNode = currentNode;
        currentNode = currentNode.next;
      }
    }

    return currentNode!.data;
  }

  /// Removes element at [position]. Raises exception for invalid positions.
  T remove(int position) {
    var index = 0;
    var currentNode = _head;
    Node<T>? previousNode;

    if (isEmpty || length < position || position < 0) {
      throw Exception('Invalid position');
    } else if (position == 0) {
      _head = _head!.next;
    } else {
      while (index != position) {
        previousNode = currentNode;
        currentNode = currentNode!.next;
        index++;
      }

      if (previousNode == null) {
        _head = null;
      } else {
        previousNode.next = currentNode!.next;
      }

      currentNode!.next = null;
    }

    return currentNode!.data;
  }
}
