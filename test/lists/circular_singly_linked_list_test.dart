import 'package:algorithms/heaps/base.dart';
import 'package:algorithms/lists/circular_singly_linked_list.dart';
import 'package:test/test.dart';

void main() {
  late CircularSinglyLinkedList<Object> emptyList;
  late CircularSinglyLinkedList<int> singleItemList;
  late CircularSinglyLinkedList<String> dceuMovieListLol;

  setUp(() {
    emptyList = CircularSinglyLinkedList();
    singleItemList = CircularSinglyLinkedList()..append(42);
    dceuMovieListLol = CircularSinglyLinkedList.fromList(
        ['Superman', 'Batman v Superman', 'Wonder Woman']);
  });

  test('List size', () {
    expect(emptyList.length, equals(0));
    expect(singleItemList.length, equals(1));
    expect(dceuMovieListLol.length, equals(3));
  });

  test('Append', () {
    expect(emptyList.toList, equals([]));
    expect(singleItemList.toList, equals([42]));
    expect(dceuMovieListLol.toList,
        equals(['Superman', 'Batman v Superman', 'Wonder Woman']));
  });

  test('Prepend', () {
    emptyList.prepend('¯\_(ツ)_/¯');
    expect(emptyList.toList, equals(['¯\_(ツ)_/¯']));
    expect(emptyList.length, equals(1));

    singleItemList
      ..prepend(41)
      ..prepend(40)
      ..prepend(39)
      ..prepend(38)
      ..prepend(37);
    expect(singleItemList.toList, equals([37, 38, 39, 40, 41, 42]));
    expect(singleItemList.length, equals(6));
  });

  test('Pop', () {
    var dceuMovieListLater = dceuMovieListLol
      ..append('Suicide Squad')
      ..append('Justice League');

    expect(dceuMovieListLater.length, equals(5));

    var justiceLeague = dceuMovieListLater.pop();
    var suicideSquad = dceuMovieListLater.pop();

    expect(justiceLeague.data, equals('Justice League'));
    expect(suicideSquad.data, equals('Suicide Squad'));
    expect(dceuMovieListLater.length, equals(3));
    expect(dceuMovieListLater.length, equals(dceuMovieListLol.length));

    var theAnswer = singleItemList.pop();
    expect(theAnswer.data, equals(42));
    expect(singleItemList.isEmpty, equals(true));
    expect(() => emptyList.pop(), throwsA(isA<InvalidIndexError>()));
  });

  test('Shift', () {
    var theAnswerAgain = singleItemList.shift();
    expect(theAnswerAgain.data, equals(42));
    expect(singleItemList.isEmpty, equals(true));

    var superman = dceuMovieListLol.shift();
    expect(superman.data, equals('Superman'));
    expect(dceuMovieListLol.length, equals(2));
    var bVS = dceuMovieListLol.shift();
    expect(bVS.data, equals('Batman v Superman'));
    expect(dceuMovieListLol.toList, equals(['Wonder Woman']));
    expect(dceuMovieListLol.length, equals(1));
    expect(() => emptyList.shift(), throwsA(isA<InvalidIndexError>()));
  });

  test('AT', () {
    var flames = ['F', 'L', 'A', 'M', 'E', 'S'];
    var flamesList = CircularSinglyLinkedList.fromList(flames);

    expect(flamesList.at(0).data, equals('F'));
    expect(flamesList.at(1).data, equals('L'));
    expect(flamesList.at(2).data, equals('A'));
    expect(flamesList.at(21).data, equals('M'));
    expect(flamesList.at(10).data, equals('E'));
    expect(flamesList.at(35).data, equals('S'));
    expect(() => flamesList.at(-10), throwsA(isA<InvalidIndexError>()));
  });
}
