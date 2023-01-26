import 'package:algorithms/graph/vertex.dart';
import 'package:test/test.dart';

void main() {
  late Vertex root,
      rootWithValue,
      connectedVertex,
      toBeAdded,
      anotherVertex,
      a,
      b,
      c;

  void _initializeVertices() {
    root = Vertex('A');
    rootWithValue = Vertex('i', 'Wake up');
    connectedVertex = Vertex('0');
    toBeAdded = Vertex('1');
    anotherVertex = Vertex('2');
    a = Vertex('a');
    b = Vertex('b');
    c = Vertex('c');
  }

  setUp(() {
    _initializeVertices();
    connectedVertex.addConnection(toBeAdded);
    connectedVertex.addConnection(anotherVertex);
  });

  test('Initialization of a node', () {
    expect(root.key, equals('A'));
    expect(root.value, isNull);
    expect(rootWithValue.key, equals('i'));
    expect(rootWithValue.value, equals('Wake up'));
  });

  test('Successfully add a vertex', () {
    expect(root.addConnection(b), isTrue);
    expect(root.addConnection(c), isTrue);
    expect(root.outgoingConnections.containsKey(b), isTrue);
    expect(root.outgoingConnections.containsKey(c), isTrue);
    expect(b.incomingVertices.contains(root), isTrue);
    expect(c.incomingVertices.contains(root), isTrue);
  });

  test('Cannot add vertex that already exists', () {
    expect(root.addConnection(b), isTrue);
    expect(root.addConnection(b), isFalse);
  });

  test('Cannot add vertex with the same key', () {
    expect(root.addConnection(b), isTrue);
    var bDuplicate = Vertex(b.key);
    expect(root.addConnection(bDuplicate), isFalse);
  });

  test('Successfully remove a vertex', () {
    expect(toBeAdded.incomingVertices.isEmpty, isFalse);
    expect(connectedVertex.removeConnection(toBeAdded), isTrue);
    expect(toBeAdded.incomingVertices.isEmpty, isTrue);
  });

  test('Unsuccessfully remove a vertex', () {
    expect(connectedVertex.removeConnection(a), isFalse);
  });

  test('Check for vertex containment', () {
    var newVertex = Vertex('DISCONNECTED');
    expect(connectedVertex.containsConnectionTo(toBeAdded), isTrue);
    expect(connectedVertex.containsConnectionTo(newVertex), isFalse);
  });

  test('Get a list of vertices', () {
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
