import 'package:test/test.dart';

import 'package:algorithms/graph/vertex.dart';

void main() {
  Vertex root;
  Vertex rootWithValue;
  Vertex connectedVertex;
  Vertex toBeAdded;
  Vertex anotherVertex;

  setUp(() {
    root = Vertex('A');
    rootWithValue = Vertex('a', 'Wake up');

    connectedVertex = Vertex('0');
    toBeAdded = Vertex('1');
    anotherVertex = Vertex('2');

    // For test purposes, unlock all vertices
    root.unlock();
    rootWithValue.unlock();
    connectedVertex.unlock();
    toBeAdded.unlock();
    anotherVertex.unlock();

    connectedVertex.addConnection(toBeAdded);
    connectedVertex.addConnection(anotherVertex);
  });

  test('Initialization of a node', () {
    expect(root.key, equals('A'));
    expect(root.value, equals('A'));
    expect(rootWithValue.key, equals('a'));
    expect(rootWithValue.value, equals('Wake up'));
  });

  test('Successfully add a vertex', () {
    var b = Vertex('B');
    var c = Vertex('C');
    b.unlock();
    c.unlock();
    expect(root.addConnection(b), isTrue);
    expect(root.addConnection(c), isTrue);
    expect(root.outgoingConnections.containsKey(b), isTrue);
    expect(root.outgoingConnections.containsKey(c), isTrue);
    expect(b.incomingVertices.contains(root), isTrue);
    expect(c.incomingVertices.contains(root), isTrue);
  });

  test('Unsuccessfully add a vertex', () {
    var b = Vertex('B');
    b.unlock();
    root.addConnection(b);
    expect(root.addConnection(b), isFalse);
  });

  test('Successfully remove a vertex', () {
    expect(toBeAdded.incomingVertices.isEmpty, isFalse);
    expect(connectedVertex.removeConnection(toBeAdded), isTrue);
    expect(toBeAdded.incomingVertices.isEmpty, isTrue);
  });

  test('Unsuccessfully remove a vertex', () {
    var aVertex = Vertex('-1');
    aVertex.unlock();
    expect(connectedVertex.removeConnection(aVertex), isFalse);
  });

  test('Trying to add to a locked vertex throws error', () {
    var locked = Vertex('PROTECTED');
    expect(() => locked.addConnection(root), throwsA(isA<Error>()));
    root.lock();
    expect(() => root.addConnection(root), throwsA(isA<Error>()));
  });

  test('Trying to add a locked vertex throws error', () {
    var locked = Vertex('PROTECTED');
    expect(() => root.addConnection(locked), throwsA(isA<Error>()));
    locked.unlock();
    root.lock();
    expect(() => locked.addConnection(root), throwsA(isA<Error>()));
  });

  test('Trying to remove from a locked vertex throws error', () {
    toBeAdded.lock();
    expect(() => connectedVertex.removeConnection(toBeAdded),
        throwsA(isA<Error>()));
  });

  test('Trying to remove a locked vertex throws error', () {
    connectedVertex.lock();
    expect(() => connectedVertex.removeConnection(toBeAdded),
        throwsA(isA<Error>()));
  });

  test('Trying to remove a locked vertex throws error', () {
    var locked = Vertex('PROTECTED');
    expect(() => root.addConnection(locked), throwsA(isA<Error>()));
    locked.unlock();
    root.lock();
    expect(() => locked.addConnection(root), throwsA(isA<Error>()));
  });

  test('Check for vertex containment', () {
    var newVertex = Vertex('DISCONNECTED');
    newVertex.unlock();
    expect(connectedVertex.containsConnectionTo(toBeAdded), isTrue);
    expect(connectedVertex.containsConnectionTo(newVertex), isFalse);
  });

  test('Get a list of vertices', () {
    var a = Vertex('A');
    var b = Vertex('B');
    var c = Vertex('C');
    a.unlock();
    b.unlock();
    c.unlock();
    root.addConnection(a);
    root.addConnection(b);
    root.addConnection(c);
    expect(root.outgoingVertices, equals(<Vertex>{a, b, c}));
    expect(a.incomingVertices, equals(<Vertex>{root}));
    expect(b.incomingVertices, equals(<Vertex>{root}));
    expect(c.incomingVertices, equals(<Vertex>{root}));
  });

  test('Check for isolated vertex', () {
    expect(root.isIsolated, isTrue);
    expect(connectedVertex.isIsolated, isFalse);
  });

  test('Get out degree for vertex', () {
    Vertex c = Vertex('c');
    c.unlock();
    expect(root.outDegree, equals(0));
    connectedVertex.addConnection(c);
    expect(connectedVertex.outDegree, equals(3));
  });

  test('Get in degree for vertex', () {
    expect(root.inDegree, equals(0));
    connectedVertex.addConnection(root);
    expect(root.inDegree, equals(1));
  });

  test('String representation of a vertex', () {
    expect(connectedVertex.toString(), equals('0'));
    expect(root.toString(), equals('A'));
  });
}
