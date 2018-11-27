import "package:algorithms_in_dart/lists/circular_singly_linked_list.dart";
import "package:test/test.dart";

void main() {
  CircularSinglyLinkedList<Object> emptyList;
  CircularSinglyLinkedList<int> singleItemList;
  CircularSinglyLinkedList<String> dceuMovieListLol;

  setUp(() {
    emptyList = CircularSinglyLinkedList();
    singleItemList = CircularSinglyLinkedList()..append(42);
    dceuMovieListLol = CircularSinglyLinkedList.fromList(
        ["Superman", "Batman v Superman", "Wonder Woman"]);
  });
}
