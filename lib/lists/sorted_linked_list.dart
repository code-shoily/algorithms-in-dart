import '../heaps/base.dart';
import '../sorts/common.dart';
import 'singly_linked_list.dart';

/// Creates a sorted linked list. The elements are always inserted in the right
/// sorted order.
class SortedLinkedList<T extends Comparable> {
  Node<T>? _head;

  /// The sort function, determines whether it is ascending or descending.
  /// Default value is ascending.
  Comparator<T> compareFn;

  /// Constructor
  SortedLinkedList({this.compareFn = ascendingFn}) : _head = null;

  /// Prefills a [SortedLinkedList] with [list] values
  SortedLinkedList.fromList(List list, {this.compareFn = ascendingFn}) {
    for (var element in list) {
      insert(element);
    }
  }

  @override
  String toString() => toList.toString();

  /// Checks if this list is empty
  bool get isEmpty => _head == null;

  /// Convert this to a list
  List<T> get toList {
    var asList = <T>[];

    for (var current = _head; current != null; current = current.next) {
      asList.add(current.data);
    }

    return asList;
  }

  bool _inverseFn(T a, T b) => !compareFn(a, b);

  /// Returns reverse of this list
  SortedLinkedList<T> get reverse {
    var reversedList = SortedLinkedList<T>(compareFn: _inverseFn);
    for (var current = _head; current != null; current = current.next) {
      reversedList.insert(current.data);
    }

    return reversedList;
  }

  /// Returns the length of this list
  int get length => toList.length;

  /// Insert [data] in sorted order
  void insert(T data) {
    var newNode = Node(data);
    var current = _head;
    var previous = current;

    if (isEmpty) {
      _head = newNode;
      return;
    }

    while (current != null) {
      if (compareFn(data, current.data)) {
        if (current == _head) {
          _head = newNode;
          newNode.next = current;
        } else {
          previous!.next = newNode;
          newNode.next = current;
        }
        break;
      }
      if (current.next == null) {
        current.next = newNode;
        break;
      }
      previous = current;
      current = current.next;
    }
  }

  /// Minimum value of this list according to sorting criteria
  T? get minimum => _head?.data;

  /// Maximum value of this list according to sorting criteria
  T? get maximum {
    var current = _head;
    while (current?.next != null) {
      current = current!.next;
    }
    return current?.data;
  }

  Node<T> _at(int position) {
    if (isEmpty || length < position || position < 0) throw InvalidIndexError();
    var node = _head;

    for (var current = 0; current != position; current++) {
      node = node!.next;
    }

    return node!;
  }

  /// Shows the element at position [position]. `null` for invalid positions.
  T at(int position) => _at(position).data;

  /// Removes the last node
  T pop() => remove(length - 1);

  /// Removes element at [position]. Raises exception for invalid positions.
  T remove(int position) {
    T result;
    if (isEmpty || length < position || position < 0) throw InvalidIndexError();

    if (position == 0) {
      result = _head!.data;
      _head = null;
    } else {
      var previousNode = _at(position - 1);
      result = previousNode.next!.data;
      previousNode.next = previousNode.next!.next;
    }

    return result;
  }
}
