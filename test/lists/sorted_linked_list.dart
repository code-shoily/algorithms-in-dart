import 'package:algorithms/heaps/base.dart';
import 'package:algorithms/lists/sorted_linked_list.dart';
import 'package:test/test.dart';

void main() {
  late SortedLinkedList emptyList;
  late SortedLinkedList listWithOneElement;
  late SortedLinkedList theStooges;
  late SortedLinkedList lostNumbers;

  setUp(() {
    emptyList = SortedLinkedList();
    listWithOneElement = SortedLinkedList()..insert('The One');
    theStooges = SortedLinkedList()
      ..insert('Moe')
      ..insert('Larry')
      ..insert('Curly');
    lostNumbers = SortedLinkedList.fromList([42, 23, 16, 15, 8, 4]);
  });

  test('Create list with custom sorting criteria', () {
    var customList = SortedLinkedList(
        compareFn: (Comparable a, Comparable b) => a.compareTo(b) >= 0);
    customList.insert(1);
    customList.insert(2);
    customList.insert(3);
    expect(customList.toList, equals([3, 2, 1]));
  });

  test('List Inserts in sorted order', () {
    expect(emptyList.toList, equals([]));
    expect(listWithOneElement.toList, equals(['The One']));
    expect(theStooges.toList, equals(['Curly', 'Larry', 'Moe']));
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
    listWithOneElement.insert('Mr Anderson');
    expect(listWithOneElement.toList, ['Mr Anderson', 'The One']);

    theStooges.insert('Shemp');
    expect(theStooges.toList, ['Curly', 'Larry', 'Moe', 'Shemp']);
    theStooges.insert('Joe');
    expect(theStooges.toList, ['Curly', 'Joe', 'Larry', 'Moe', 'Shemp']);

    var guessTheFormula = [4, 8, 12, 15, 16, 23, 23, 31, 42, 55];
    lostNumbers.insert(12);
    lostNumbers.insert(23);
    lostNumbers.insert(31);
    lostNumbers.insert(55);
    expect(lostNumbers.toList, equals(guessTheFormula));
  });

  test('List Removal', () {
    var fullStoogesCast = ['Curly', 'Joe', 'Larry', 'Moe', 'Shemp'];
    var mostAppearedCast = ['Curly', 'Larry', 'Moe'];
    var fullStoogesCastList = SortedLinkedList.fromList(fullStoogesCast);
    fullStoogesCastList.remove(1);
    fullStoogesCastList.remove(3);
    expect(fullStoogesCastList.toList, mostAppearedCast);

    var lostNumbersWithPadding = [4, 8, 12, 15, 16, 23, 23, 31, 42];
    var actualLostNumbers = [4, 8, 15, 16, 23, 42];
    var shuffledLostNumbers = SortedLinkedList.fromList(lostNumbersWithPadding);
    shuffledLostNumbers.remove(2);
    shuffledLostNumbers.remove(4);
    shuffledLostNumbers.remove(5);
    expect(shuffledLostNumbers.toList, equals(actualLostNumbers));
  });

  test('Remove returns null if index is invalid', () {
    expect(() => lostNumbers.remove(1000), throwsA(isA<InvalidIndexError>()));
    expect(() => lostNumbers.remove(-1), throwsA(isA<InvalidIndexError>()));
    expect(() => emptyList.remove(0), throwsA(isA<InvalidIndexError>()));
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
    expect(theStooges.toList, equals(['Curly', 'Larry', 'Moe']));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23, 42]));
  });

  test('Trying to index with an invalid number returns null', () {
    expect(() => lostNumbers.at(1000), throwsA(isA<InvalidIndexError>()));
    expect(() => lostNumbers.at(-1), throwsA(isA<InvalidIndexError>()));
    expect(() => emptyList.at(0), throwsA(isA<InvalidIndexError>()));
  });

  test('List pops on a non-empty list', () {
    expect(listWithOneElement.pop(), equals('The One'));
    expect(listWithOneElement.toList, equals([]));

    expect(theStooges.pop(), equals('Moe'));
    expect(theStooges.toList, equals(['Curly', 'Larry']));

    expect(lostNumbers.pop(), equals(42));
    expect(lostNumbers.toList, equals([4, 8, 15, 16, 23]));
  });

  test('Empty list pops null', () {
    expect(() => emptyList.pop(), throwsA(isA<InvalidIndexError>()));
  });

  test('Maximum of a list', () {
    expect(emptyList.maximum, null);
    expect(listWithOneElement.maximum, equals('The One'));
    expect(lostNumbers.maximum, equals(42));
    expect(theStooges.maximum, equals('Moe'));
  });

  test('Minimum of a list', () {
    expect(emptyList.minimum, null);
    expect(listWithOneElement.minimum, equals('The One'));
    expect(lostNumbers.minimum, equals(4));
    expect(theStooges.minimum, equals('Curly'));
  });

  test('Reverse a list', () {
    expect(emptyList.reverse, isEmpty);
    expect(listWithOneElement.reverse.toList, equals(['The One']));
    expect(lostNumbers.reverse.toList, [42, 23, 16, 15, 8, 4]);
    expect(theStooges.reverse.toList, equals(['Moe', 'Larry', 'Curly']));
  });
}
