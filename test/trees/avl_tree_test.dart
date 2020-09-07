import 'package:test/test.dart';

import 'package:algorithms_in_dart/trees/avl_tree.dart';

void main() {
  AvlTree emptyTree, singleNodeTree, tree;
  setUp(() {
    emptyTree = AvlTree();
    singleNodeTree = AvlTree.withSingleValue(0);

    /*----------------------
        tree:
                n
               / \
              /   \
             /     \ 
            i       p
           / \     / \ 
          h   l   o   q
         /   / \
        a   k   m
    ----------------------*/
    tree = AvlTree.fromList(['m', 'n', 'o', 'l', 'k', 'q', 'p', 'h', 'i', 'a']);
  });

  test('Test empty tree', () {
    expect(emptyTree.isEmpty, isTrue);
    expect(singleNodeTree.isEmpty, isFalse);
    expect(tree.isEmpty, isFalse);
  });

  test('Test single node', () {
    expect(singleNodeTree.root.value, equals(0));
    expect(tree.root.value, equals('n'));
  });

  test('Multiple node', () {
    /*----------------------
               1
                n
               / \
              /   \
             /     \ 
            i       p
         1 / \     / \ 
          h   l   o   q
         /   / \
        a   k   m
    ----------------------*/
    expect(tree.root.value, equals('n'));
    expect(tree.root.balanceFactor, equals(1));

    expect(tree.root.left.value, equals('i'));
    expect(tree.root.left.balanceFactor, equals(0));
    expect(tree.root.left.left.value, equals('h'));
    expect(tree.root.left.left.balanceFactor, equals(1));
    expect(tree.root.left.left.left.value, equals('a'));
    expect(tree.root.left.left.left.balanceFactor, equals(0));
    expect(tree.root.left.left.left.left, isNull);
    expect(tree.root.left.left.left.right, isNull);
    expect(tree.root.left.right.value, equals('l'));
    expect(tree.root.left.right.balanceFactor, equals(0));
    expect(tree.root.left.right.left.value, equals('k'));
    expect(tree.root.left.right.left.balanceFactor, equals(0));
    expect(tree.root.left.right.left.left, isNull);
    expect(tree.root.left.right.left.right, isNull);
    expect(tree.root.left.right.right.value, equals('m'));
    expect(tree.root.left.right.right.balanceFactor, equals(0));
    expect(tree.root.left.right.right.left, isNull);
    expect(tree.root.left.right.right.right, isNull);

    expect(tree.root.right.value, equals('p'));
    expect(tree.root.right.balanceFactor, equals(0));
    expect(tree.root.right.left.value, equals('o'));
    expect(tree.root.right.left.balanceFactor, equals(0));
    expect(tree.root.right.left.left, isNull);
    expect(tree.root.right.left.right, isNull);
    expect(tree.root.right.right.value, equals('q'));
    expect(tree.root.right.right.balanceFactor, equals(0));
    expect(tree.root.right.right.left, isNull);
    expect(tree.root.right.right.right, isNull);
  });

  test('Add', () {
    var avlTree = AvlTree();
    avlTree.add(50);
    expect(avlTree.preOrder(), <int>[50]);
    avlTree.add(40);
    expect(avlTree.preOrder(), <int>[50, 40]);

    avlTree.add(35);
    // RR: Right rotation about 50
    expect(avlTree.preOrder(), <int>[40, 35, 50]);
    avlTree.add(58);
    expect(avlTree.preOrder(), <int>[40, 35, 50, 58]);
    avlTree.add(48);
    expect(avlTree.preOrder(), <int>[40, 35, 50, 48, 58]);

    avlTree.add(42);
    // RL: Right rotation about 50, Left rotation about 40
    expect(avlTree.preOrder(), <int>[48, 40, 35, 42, 50, 58]);

    avlTree.add(60);
    // LL: Left rotation about 50
    expect(avlTree.preOrder(), <int>[48, 40, 35, 42, 58, 50, 60]);
    avlTree.add(30);
    expect(avlTree.preOrder(), <int>[48, 40, 35, 30, 42, 58, 50, 60]);

    avlTree.add(33);
    // LR: Left rotation about 30, Right rotation about 35
    expect(avlTree.preOrder(), <int>[48, 40, 33, 30, 35, 42, 58, 50, 60]);

    avlTree.add(25);
    // RR: Right rotation about 40
    expect(avlTree.preOrder(), <int>[48, 33, 30, 25, 40, 35, 42, 58, 50, 60]);
  });

  test('Nullify', () {
    var tree = AvlTree.fromList([1, 2, 3]);
    tree.nullify();
    expect(tree.isEmpty, isTrue);
  });

  test('Check contains', () {
    expect(emptyTree.contains(10), isFalse);
    expect(singleNodeTree.contains(10), isFalse);
    expect(singleNodeTree.contains(0), isTrue);
    expect(tree.contains('z'), isFalse);

    for (var i in ['m', 'n', 'o', 'l', 'k', 'q', 'p', 'h', 'i', 'a']) {
      expect(tree.contains(i), isTrue);
    }
  });

  test('Pre-order traversal', () {
    expect(emptyTree.preOrder(), <int>[]);
    expect(singleNodeTree.preOrder(), <int>[0]);
    expect(tree.preOrder(),
        equals(<String>['n', 'i', 'h', 'a', 'l', 'k', 'm', 'p', 'o', 'q']));
  });

  test('Post-order traversal', () {
    expect(emptyTree.postOrder(), <int>[]);
    expect(singleNodeTree.postOrder(), <int>[0]);
    expect(tree.postOrder(),
        equals(<String>['a', 'h', 'k', 'm', 'l', 'i', 'o', 'q', 'p', 'n']));
  });

  test('In-order traversal', () {
    expect(emptyTree.inOrder(), <int>[]);
    expect(singleNodeTree.inOrder(), <int>[0]);
    expect(tree.inOrder(),
        equals(<String>['a', 'h', 'i', 'k', 'l', 'm', 'n', 'o', 'p', 'q']));
  });

  test('Delete node', () {
    emptyTree.delete(1);
    expect(emptyTree.inOrder(), <int>[]);
    singleNodeTree.delete(0);
    expect(emptyTree.inOrder(), <int>[]);
    tree.delete('q');
    expect(tree.preOrder(), ['n', 'i', 'h', 'a', 'l', 'k', 'm', 'p', 'o']);

    tree.delete('n');
    // RR: Right rotation about 'o'
    expect(tree.preOrder(), ['i', 'h', 'a', 'o', 'l', 'k', 'm', 'p']);

    tree.delete('a');
    // RL: Right rotation about 'o', Left rotation about 'i'
    expect(tree.preOrder(), ['l', 'i', 'h', 'k', 'o', 'm', 'p']);
    tree.delete('h');
    expect(tree.preOrder(), ['l', 'i', 'k', 'o', 'm', 'p']);
    tree.delete('k');
    expect(tree.preOrder(), ['l', 'i', 'o', 'm', 'p']);

    tree.delete('i');
    // LL: Left rotation about 'l'
    expect(tree.preOrder(), ['o', 'l', 'm', 'p']);

    tree.delete('p');
    // LR: Left rotation about 'l', Right rotation about 'o'
    expect(tree.preOrder(), ['m', 'l', 'o']);
  });
}
