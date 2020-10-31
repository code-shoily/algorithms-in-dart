import 'package:test/test.dart';

import 'package:algorithms/graph/vertex.dart';

void main() {
  Vertex root;
  Vertex rootWithValue;
  Vertex connectedVertex;
  Vertex toBeAdded;

  setUp(() {
    root = Vertex('A');
    rootWithValue = Vertex('a', 'Wake up');

    connectedVertex = Vertex('0');
    toBeAdded = Vertex('1');
    connectedVertex.addConnection(toBeAdded);
    connectedVertex.addConnection(Vertex('2'));
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
    expect(root.addConnection(b), isTrue);
    expect(root.addConnection(c), isTrue);
    expect(root.outgoingConnections.containsKey(b), isTrue);
    expect(root.outgoingConnections.containsKey(c), isTrue);
    expect(b.incomingConnections.containsKey(root), isTrue);
    expect(c.incomingConnections.containsKey(root), isTrue);
  });

  test('Unsuccessfully add a vertex', () {
    var b = Vertex('B');
    root.addConnection(b);
    expect(root.addConnection(b), isFalse);
  });

  test('Successfully remove a vertex', () {
    expect(toBeAdded.incomingConnections.isEmpty, isFalse);
    expect(connectedVertex.removeConnection(toBeAdded), isTrue);
    expect(toBeAdded.incomingConnections.isEmpty, isTrue);
  });

  test('Unsuccessfully remove a vertex', () {
    var aVertex = Vertex('-1');
    expect(connectedVertex.removeConnection(aVertex), isFalse);
  });

  test('Check for vertex containment', () {
    expect(connectedVertex.containsConnectionTo(toBeAdded), isTrue);
    expect(connectedVertex.containsConnectionTo(Vertex('I am not connected')),
        isFalse);
  });

  test('Get a list of vertices', () {
    var a = Vertex('A');
    var b = Vertex('B');
    var c = Vertex('C');
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
    expect(root.outDegree, equals(0));
    connectedVertex.addConnection(Vertex('C'));
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
