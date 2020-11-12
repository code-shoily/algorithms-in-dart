import '../sorts/common.dart';
import 'singly_linked_list.dart';

class SortedLinkedList<T extends Comparable> {
  Node<T> _head;
  Comparator<T> compareFn;

  SortedLinkedList({this.compareFn = ascendingFn}) : _head = null;

  bool get isEmpty => _head == null;

  List<T> get toList {
    var asList = <T>[];

    for (var current = _head; current != null; current = current.next) {
      asList.add(current.data);
    }

    return asList;
  }

  /// Returns the length of this list
  int get length => toList.length;

  void insert(T data) {
    var newNode = Node(data: data);
    var current = _head;
    var previous = current;

    if (isEmpty) {
      _head = newNode;
      return;
    }

    while(current != null) {
      if (compareFn(data, current.data)) {
        if (current == _head) {
          _head = newNode;
          newNode.next = current;
        } else {
          previous.next = newNode;
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

  T minimum() => _head?.data;

  T maximum() {
    var current = _head;
    while (current?.next != null) {
      current = current.next;
    }
    return current?.data;
  }
}

main() {
  SortedLinkedList list = SortedLinkedList();
  print(list.maximum());
}