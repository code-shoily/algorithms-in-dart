/// A Node containing reference to the next node.
class Node<T> {
  /// Information for [this]
  T data;

  /// Reference to the [next] Node
  Node next;

  /// We initiate a [Node] either with just the data or with the [next]
  ///
  /// ```dart
  /// var node = Node(data: 10) // Next is null
  ///
  /// var list = Node(data: 10, next: Node(data: 20, next: Node(data: 30)))
  /// ```
  Node({this.data, this.next = null});
}

/// A singly linked list. Contains a Node marked as head.
///
/// Whenever we are inserting or removing based on indices, a 0-indexed value is assumed.
/// Therefore, to be valid, an index (position) must be a valid non-negative integer that
/// is less than the length of the list. This version does not support negative indices.
///
/// Read more about this at [Wikipedia Entry](https://en.wikipedia.org/wiki/Linked_list)
class SinglyLinkedList<T> {
  /// The head of the list
  Node<T> _head;

  /// Initiates an empty [SinglyLinkedList]
  SinglyLinkedList() {
    this._head = null;
  }

  /// Prefills a [SinglyLinkedList] with [list] values
  SinglyLinkedList.fromList(List list) {
    for (var element in list) {
      this.append(element);
    }
  }

  /// Checks if this list is empty
  bool get isEmpty {
    return this._head == null;
  }

  /// Returns the length of this list
  int get length {
    var length = 0;
    var currentNode = this._head;

    while (currentNode != null) {
      currentNode = currentNode.next;
      length++;
    }
    return length;
  }

  /// Converts a linked list into a list
  List<T> get toList {
    var asList = <T>[];
    var currentNode = this._head;

    while (currentNode != null) {
      asList.add(currentNode.data);
      currentNode = currentNode.next;
    }

    return asList;
  }

  /// Shows the last node of the list. `null` for empty lists.
  T peek() {
    if (this.isEmpty) return null;

    Node<T> currentNode = this._head;
    while (currentNode.next != null) {
      currentNode = currentNode.next;
    }
    return currentNode.data;
  }

  /// Shows the element at position [position]. `null` for invalid positions.
  T at(int position) {
    if (this.isEmpty || this.length < position || position < 0) return null;

    var node = this._head;
    var current = 0;

    while (current != position) {
      node = node.next;
      current++;
    }
    return node.data;
  }

  /// Inserts [data] at the end of the list.
  void append(T data) {
    var newNode = Node(data: data);

    if (this.isEmpty) {
      this._head = newNode;
    } else {
      var currentNode = this._head;
      while (currentNode.next != null) {
        currentNode = currentNode.next;
      }

      currentNode.next = newNode;
    }
  }

  /// Inserts [data] at [position]. Raises exception for invalid positions.
  void insert(T data, int position) {
    if (this.length < position || position < 0) {
      throw Exception("Invalid position");
    }
    var newNode = Node(data: data);
    var index = 0;
    var currentNode = this._head;
    Node<T> previousNode = null;

    while (index != position) {
      previousNode = currentNode;
      currentNode = currentNode.next;
      index++;
    }

    if (previousNode == null) {
      this._head = newNode;
    } else {
      previousNode.next = newNode;
    }

    newNode.next = currentNode;
  }

  /// Removes the last element. Raises exception for empty lists.
  T pop() {
    if (this.isEmpty) {
      throw Exception("Cannot remove from an empty list");
    }

    Node<T> previousNode = null;
    var currentNode = this._head;

    while (currentNode != null) {
      if (currentNode.next == null) {
        if (previousNode == null) {
          this._head = null;
        } else {
          previousNode.next = null;
        }
        break;
      } else {
        previousNode = currentNode;
        currentNode = currentNode.next;
      }
    }

    return currentNode.data;
  }

  /// Removes element at [position]. Raises exception for invalid positions.
  T remove(int position) {
    var index = 0;
    var currentNode = this._head;
    Node<T> previousNode = null;

    if (this.isEmpty || this.length < position || position < 0) {
      throw Exception("Invalid position");
    } else if (position == 0) {
      this._head = this._head.next;
    } else {
      while (index != position) {
        previousNode = currentNode;
        currentNode = currentNode.next;
        index++;
      }

      if (previousNode == null) {
        this._head = null;
      } else {
        previousNode.next = currentNode.next;
      }

      currentNode.next = null;
    }

    return currentNode.data;
  }
}
