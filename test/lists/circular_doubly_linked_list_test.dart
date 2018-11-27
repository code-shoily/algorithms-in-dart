import "package:algorithms_in_dart/lists/circular_doubly_linked_list.dart";
import "package:test/test.dart";

void main() {
  CircularDoublyLinkedList<Object> emptyList;
  CircularDoublyLinkedList<int> singleItemList;
  CircularDoublyLinkedList<String> dceuMovieListLol;

  setUp(() {
    emptyList = CircularDoublyLinkedList();
    singleItemList = CircularDoublyLinkedList()..append(42);
    dceuMovieListLol = CircularDoublyLinkedList.fromList(
        ["Superman", "Batman v Superman", "Wonder Woman"]);
  });
}
