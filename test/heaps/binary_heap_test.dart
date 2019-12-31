import 'package:test/test.dart';

import 'package:algorithms_in_dart/heaps/base.dart';
import 'package:algorithms_in_dart/heaps/binary_heap.dart';

void main() {
  group('Index Mixin Tests', () {
    var indexer;
    setUp(() {
      indexer = BinaryHeap((_1, _2) => true);
    });
    test('Test Left', () {
      expect(indexer.leftOf(0), equals(1));
      expect(indexer.leftOf(1), equals(3));
      expect(indexer.leftOf(2), equals(5));
      expect(indexer.leftOf(3), equals(7));
    });

    test('Test Right', () {
      expect(indexer.rightOf(0), equals(2));
      expect(indexer.rightOf(1), equals(4));
      expect(indexer.rightOf(2), equals(6));
      expect(indexer.rightOf(3), equals(8));
    });

    test('Test Parent', () {
      expect(indexer.parentOf(0), equals(0));
      expect(indexer.parentOf(1), equals(0));
      expect(indexer.parentOf(2), equals(0));
      expect(indexer.parentOf(3), equals(1));
      expect(indexer.parentOf(4), equals(1));
      expect(indexer.parentOf(5), equals(2));
      expect(indexer.parentOf(6), equals(2));
      expect(indexer.parentOf(7), equals(3));
      expect(indexer.parentOf(8), equals(3));

      var errors = <Error>[];

      try {
        indexer.parentOf(-1);
      } on InvalidIndexError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
    });
  });

  group('BINARY_TREE', () {
    BinaryHeap minHeap;
    BinaryHeap maxHeap;

    setUp(() {
      minHeap = BinaryHeap((parent, child) => parent <= child);
      maxHeap = BinaryHeap((parent, child) => parent >= child);
    });
    test('Test length', () {
      expect(minHeap.length, equals(0));
      expect(maxHeap.length, equals(0));
    });

    test('Insertions', () {
      minHeap.insert(10);
      expect(minHeap.items, equals([10]));
      minHeap.insert(20);
      expect(minHeap.items, equals([10, 20]));
      minHeap.insert(5);
      expect(minHeap.items, equals([5, 20, 10]));
      minHeap.insert(9);
      expect(minHeap.items, equals([5, 9, 10, 20]));
      minHeap.insert(7);
      expect(minHeap.items, equals([5, 7, 10, 20, 9]));
    });

    test('Insert Many', () {
      maxHeap.insertMany([35, 10, 100, 80]);
      expect(maxHeap.items, equals([100, 80, 35, 10]));
    });

    test('Peek', () {
      maxHeap.insertMany([35, 10, 100, 80]);
      expect(maxHeap.peek(), equals(100));
      expect(maxHeap.items, equals([100, 80, 35, 10]));

      var errors = <Error>[];
      try {
        minHeap.peek();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
    });

    test('Pop', () {
      maxHeap.insertMany([35, 10, 100, 80, 65, 71, 40]);
      expect(maxHeap.items, equals([100, 80, 71, 10, 65, 35, 40]));
      expect(maxHeap.pop(), equals(100));
      expect(maxHeap.items, equals([80, 65, 71, 10, 40, 35]));

      minHeap.insertMany([32, 45, 65, 71, 0, -9, 10, -19]);
      expect(minHeap.items, equals([-19, -9, 0, 32, 45, 65, 10, 71]));
      expect(minHeap.pop(), equals(-19));
      expect(minHeap.items, equals([-9, 32, 0, 71, 45, 65, 10]));

      var emptyHeap = BinaryHeap((a, b) => a <= b);
      var errors = <Error>[];
      try {
        emptyHeap.pop();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
    });
  });

  group('MAX_HEAP', () {
    BinaryHeap maxHeap;

    setUp(() {
      maxHeap = MaxHeap();
    });
    test('Test length', () {
      expect(maxHeap.length, equals(0));
    });
    test('Insertions', () {
      maxHeap.insert(10);
      expect(maxHeap.items, equals([10]));
      maxHeap.insert(20);
      expect(maxHeap.items, equals([20, 10]));
      maxHeap.insert(5);
      expect(maxHeap.items, equals([20, 10, 5]));
      maxHeap.insert(9);
      expect(maxHeap.items, equals([20, 10, 5, 9]));
      maxHeap.insert(7);
      expect(maxHeap.items, equals([20, 10, 5, 9, 7]));
    });

    test('Insert Many', () {
      maxHeap.insertMany([35, 10, 100, 80]);
      expect(maxHeap.items, equals([100, 80, 35, 10]));
    });

    test('Peek', () {
      var errors = <Error>[];
      try {
        maxHeap.peek();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
      maxHeap.insertMany([35, 10, 100, 80]);
      expect(maxHeap.peek(), equals(100));
      expect(maxHeap.items, equals([100, 80, 35, 10]));
    });

    test('Pop', () {
      var errors = <Error>[];
      try {
        maxHeap.pop();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
      maxHeap.insertMany([35, 10, 100, 80, 65, 71, 40]);
      expect(maxHeap.items, equals([100, 80, 71, 10, 65, 35, 40]));
      expect(maxHeap.pop(), equals(100));
      expect(maxHeap.items, equals([80, 65, 71, 10, 40, 35]));
    });
  });

  group('MIN_HEAP', () {
    MinHeap minHeap;

    setUp(() {
      minHeap = MinHeap();
    });
    test('Test length', () {
      expect(minHeap.length, equals(0));
    });

    test('Insertions', () {
      minHeap.insert(10);
      expect(minHeap.items, equals([10]));
      minHeap.insert(20);
      expect(minHeap.items, equals([10, 20]));
      minHeap.insert(5);
      expect(minHeap.items, equals([5, 20, 10]));
      minHeap.insert(9);
      expect(minHeap.items, equals([5, 9, 10, 20]));
      minHeap.insert(7);
      expect(minHeap.items, equals([5, 7, 10, 20, 9]));
    });

    test('Insert Many', () {
      minHeap.insertMany([35, 10, 100, 80]);
      expect(minHeap.items, equals([10, 35, 100, 80]));
    });

    test('Peek', () {
      var errors = <Error>[];
      try {
        minHeap.peek();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));
      minHeap.insertMany([35, 10, 100, 80]);
      expect(minHeap.peek(), equals(10));
      expect(minHeap.items, equals([10, 35, 100, 80]));
    });

    test('Pop', () {
      var errors = <Error>[];
      try {
        minHeap.pop();
      } on StateError catch (e) {
        errors.add(e);
      }

      expect(errors.length, equals(1));

      minHeap.insertMany([32, 45, 65, 71, 0, -9, 10, -19]);
      expect(minHeap.items, equals([-19, -9, 0, 32, 45, 65, 10, 71]));
      expect(minHeap.pop(), equals(-19));
      expect(minHeap.items, equals([-9, 32, 0, 71, 45, 65, 10]));
    });
  });
}
