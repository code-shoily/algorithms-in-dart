import 'package:algorithms/heaps/base.dart';
import 'package:algorithms/lists/singly_linked_list.dart';
import 'package:test/test.dart';

void main() {
  late SinglyLinkedList emptyList;
  late SinglyLinkedList listWithOneElement;
  late SinglyLinkedList theStooges;
  late SinglyLinkedList lostNumbers;

  setUp(() {
    emptyList = SinglyLinkedList();
    listWithOneElement = SinglyLinkedList()..append('The One');
    theStooges = SinglyLinkedList()
      ..append('Moe')
      ..append('Larry')
      ..append('Curly');
    lostNumbers = SinglyLinkedList.fromList([4, 8, 15, 16, 23, 42]);
  });

  test('Create Nodes', () {
    var node_1 = Node(10);
    expect([node_1.data, node_1.next], equals([10, null]));

    var node_2 = Node(0, next: node_1);
    expect([node_2.data, node_2.next], equals([0, node_1]));
  });

  test('List Appends', () {
    expect(emptyList.toList, equals([]));
    expect(listWithOneElement.toList, equals(['The One']));
    expect(theStooges.toList, equals(['Moe', 'Larry', 'Curly']));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23, 42]));
  });

  test('List Length', () {
    expect(emptyList.length, equals(0));
    expect(listWithOneElement.length, equals(1));
    expect(theStooges.length, equals(3));
    expect(lostNumbers.length, equals(6));
  });

  test('List emptiness', () {
    expect(emptyList.isEmpty, equals(true));
    expect(listWithOneElement.isEmpty, equals(false));
    expect(theStooges.isEmpty, equals(false));
    expect(lostNumbers.isEmpty, equals(false));
  });

  test('List Inserts', () {
    listWithOneElement.insert('Mr Anderson', 0);
    expect(listWithOneElement.toList, ['Mr Anderson', 'The One']);

    theStooges.insert('Shemp', 2);
    expect(theStooges.toList, ['Moe', 'Larry', 'Shemp', 'Curly']);
    theStooges.insert('Joe', 0);
    expect(theStooges.toList, ['Joe', 'Moe', 'Larry', 'Shemp', 'Curly']);

    var guessTheFormula = [4, 12, 8, 23, 15, 31, 16, 23, 55, 42];
    lostNumbers.insert(12, 1);
    lostNumbers.insert(23, 3);
    lostNumbers.insert(31, 5);
    lostNumbers.insert(55, 8);
    expect(lostNumbers.toList, equals(guessTheFormula));
  });

  test('List Removal', () {
    var fullStoogesCast = ['Joe', 'Moe', 'Larry', 'Shemp', 'Curly'];
    var mostAppearedCast = ['Moe', 'Larry', 'Curly'];
    var fullStoogesCastList = SinglyLinkedList.fromList(fullStoogesCast);
    fullStoogesCastList.remove(0);
    fullStoogesCastList.remove(2);
    expect(fullStoogesCastList.toList, mostAppearedCast);

    var thatListOfNumberFromBefore = [4, 12, 8, 23, 15, 31, 16, 23, 55, 42];
    var actualLostNumbers = [4, 8, 15, 16, 23, 42];
    var messedUpLostNumbers =
        SinglyLinkedList.fromList(thatListOfNumberFromBefore);
    messedUpLostNumbers.remove(8);
    messedUpLostNumbers.remove(5);
    messedUpLostNumbers.remove(3);
    messedUpLostNumbers.remove(1);
    expect(messedUpLostNumbers.toList, equals(actualLostNumbers));
  });

  test('List Peeks', () {
    expect(() => emptyList.peek(), throwsA(isA<InvalidIndexError>()));
    expect(listWithOneElement.peek(), equals('The One'));
    expect(theStooges.peek(), equals('Curly'));
    expect(lostNumbers.peek(), equals(42));

    // Original lists remained unchanged
    expect(emptyList.toList, equals([]));
    expect(listWithOneElement.toList, equals(['The One']));
    expect(theStooges.toList, equals(['Moe', 'Larry', 'Curly']));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23, 42]));
  });

  test('List At', () {
    expect(() => emptyList.at(0), throwsA(isA<InvalidIndexError>()));
    expect(listWithOneElement.at(0), equals('The One'));
    expect(theStooges.at(1), equals('Larry'));
    expect(() => theStooges.at(-1), throwsA(isA<InvalidIndexError>()));
    expect(() => lostNumbers.at(13), throwsA(isA<InvalidIndexError>()));

    var lostNumberList = [4, 8, 15, 16, 23, 42];
    for (var i = 0; i < lostNumberList.length; i++) {
      expect(lostNumbers.at(i), equals(lostNumberList[i]));
    }

    // Original lists remained unchanged
    expect(emptyList.toList, equals([]));
    expect(listWithOneElement.toList, equals(['The One']));
    expect(theStooges.toList, equals(['Moe', 'Larry', 'Curly']));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23, 42]));
  });

  test('List pops', () {
    expect(() => emptyList.pop(), throwsA(isA<InvalidIndexError>()));

    expect(listWithOneElement.pop(), equals('The One'));
    expect(listWithOneElement.toList, equals([]));

    expect(theStooges.pop(), equals('Curly'));
    expect(theStooges.toList, equals(['Moe', 'Larry']));

    expect(lostNumbers.pop(), equals(42));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23]));
  });
}
