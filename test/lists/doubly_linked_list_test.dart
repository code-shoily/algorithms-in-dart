import 'package:algorithms_in_dart/lists/doubly_linked_list.dart';
import 'package:test/test.dart';

void main() {
  DoublyLinkedList emptyList;
  DoublyLinkedList<String> programmingLanguages;
  DoublyLinkedList<num> fibonacciNumbers;

  setUp(() {
    emptyList = DoublyLinkedList();
    programmingLanguages = DoublyLinkedList()
      ..append('C')
      ..append('C++')
      ..append('Java')
      ..append('Dart');
    fibonacciNumbers = DoublyLinkedList.fromList([1, 2, 3, 5, 8]);
  });

  test('Head/Tail', () {
    expect([emptyList.head, emptyList.tail], equals([null, null]));
    expect(fibonacciNumbers.head?.data, equals(1));
    expect(fibonacciNumbers.tail?.data, equals(8));
    expect(programmingLanguages.head?.data, equals('C'));
    expect(programmingLanguages.tail?.data, equals('Dart'));
  });

  test('Test for Size', () {
    expect(emptyList.size, equals(0));
    expect(programmingLanguages.size, equals(4));
    expect(fibonacciNumbers.size, equals(5));
  });

  test('Test for Index Peeks', () {
    expect(emptyList.at(10), equals(null));
    expect(programmingLanguages.at(0).data, equals('C'));
    expect(programmingLanguages.at(1).data, equals('C++'));
    expect(programmingLanguages.at(2).data, equals('Java'));
    expect(programmingLanguages.at(3).data, equals('Dart'));
    expect(programmingLanguages.at(4), equals(null));
  });

  test('Test for Appends', () {
    expect(emptyList.toList, equals([]));
    emptyList.append('Neo');
    expect(emptyList.toList, equals(['Neo']));
    expect(emptyList.size, equals(1));
    emptyList.append('Agent Smith');
    expect(emptyList.toList, equals(['Neo', 'Agent Smith']));
    expect(emptyList.size, equals(2));
    emptyList.append('Agent Smith');
    expect(emptyList.toList, equals(['Neo', 'Agent Smith', 'Agent Smith']));
    expect(emptyList.size, equals(3));
    emptyList.append('Agent Smith');
    expect(emptyList.toList,
        equals(['Neo', 'Agent Smith', 'Agent Smith', 'Agent Smith']));
    expect(emptyList.size, equals(4));

    expect(programmingLanguages.toList, equals(['C', 'C++', 'Java', 'Dart']));
    expect(fibonacciNumbers.toList, equals([1, 2, 3, 5, 8]));
  });

  test('Test for Prepends', () {
    programmingLanguages.prepend('Lisp');
    expect(programmingLanguages.toList,
        equals(['Lisp', 'C', 'C++', 'Java', 'Dart']));
    expect(programmingLanguages.size, equals(5));

    emptyList.prepend('Dumb Agent 1');
    expect(emptyList.toList, equals(['Dumb Agent 1']));
    expect(emptyList.size, equals(1));

    emptyList.prepend('Dumb Agent 2');
    expect(emptyList.toList, equals(['Dumb Agent 2', 'Dumb Agent 1']));
    expect(emptyList.size, equals(2));

    emptyList.prepend('Agent Smith');
    expect(emptyList.toList,
        equals(['Agent Smith', 'Dumb Agent 2', 'Dumb Agent 1']));
    expect(emptyList.size, equals(3));

    emptyList.prepend('Neo');
    expect(emptyList.toList,
        equals(['Neo', 'Agent Smith', 'Dumb Agent 2', 'Dumb Agent 1']));
    expect(emptyList.size, equals(4));
  });

  test('Test for Pops', () {
    var dart = programmingLanguages.pop();
    expect(dart.data, equals('Dart'));
    expect(programmingLanguages.toList, equals(['C', 'C++', 'Java']));
    expect(programmingLanguages.size, equals(3));

    var list = DoublyLinkedList.fromList([0]);
    var zero = list.pop().data;
    expect(zero, equals(0));

    try {
      emptyList.pop();
    } catch (e) {
      expect(e, isNotNull);
    }
  });

  test('Test for Shifts', () {
    var c = programmingLanguages.shift();
    expect(c.data, equals('C'));
    expect(programmingLanguages.toList, equals(['C++', 'Java', 'Dart']));
    expect(programmingLanguages.size, equals(3));

    var list = DoublyLinkedList.fromList([0]);
    var zero = list.shift().data;
    expect(zero, equals(0));

    try {
      emptyList.shift();
    } catch (e) {
      expect(e, isNotNull);
    }
  });

  test('Test for Remove', () {
    var cpp = programmingLanguages.remove(1);
    expect(cpp.data, equals('C++'));
    expect(programmingLanguages.toList, equals(['C', 'Java', 'Dart']));
    expect(programmingLanguages.size, equals(3));

    var java = programmingLanguages.remove(1);
    expect(java.data, equals('Java'));
    expect(programmingLanguages.toList, equals(['C', 'Dart']));
    expect(programmingLanguages.size, equals(2));

    var dart = programmingLanguages.remove(1);
    expect(dart.data, equals('Dart'));
    expect(programmingLanguages.toList, equals(['C']));
    expect(programmingLanguages.size, equals(1));

    var c = programmingLanguages.remove(0);
    expect(c.data, equals('C'));
    expect(programmingLanguages.toList, equals([]));
    expect(programmingLanguages.size, equals(0));

    try {
      programmingLanguages.remove(-2);
    } catch (e) {
      expect(e, isNotNull);
    }

    try {
      programmingLanguages.remove(10);
    } catch (e) {
      expect(e, isNotNull);
    }

    try {
      emptyList.remove(2);
    } catch (e) {
      expect(e, isNotNull);
    }
  });

  test('Test for Insert', () {
    programmingLanguages.insert('Pascal', 0);
    expect(programmingLanguages.toList,
        equals(['Pascal', 'C', 'C++', 'Java', 'Dart']));
    expect(programmingLanguages.size, equals(5));

    programmingLanguages.insert('COBOL', 2);
    expect(programmingLanguages.toList,
        equals(['Pascal', 'C', 'COBOL', 'C++', 'Java', 'Dart']));
    expect(programmingLanguages.size, equals(6));

    programmingLanguages.insert('Clojure', 5);
    expect(programmingLanguages.toList,
        equals(['Pascal', 'C', 'COBOL', 'C++', 'Java', 'Clojure', 'Dart']));
    expect(programmingLanguages.size, equals(7));

    try {
      programmingLanguages.insert('JavaScript', 7);
    } catch (e) {
      expect(e, isNotNull);
    }

    try {
      programmingLanguages.insert('PHP', -1);
    } catch (e) {
      expect(e, isNotNull);
    }
  });
}
