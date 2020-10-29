import 'package:test/test.dart';

import 'package:algorithms_in_dart/graph/vertex.dart';

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
  });

  test('Unsuccessfully add a vertex', () {
    var b = Vertex('B');
    root.addConnection(b);
    expect(root.addConnection(b), isFalse);
  });

  test('Successfully add a vertex by key', () {
    expect(root.addConnectionByKey('B'), isTrue);
    expect(root.addConnectionByKey('C'), isTrue);
  });

  test('Unsuccessfully add a vertex', () {
    root.addConnectionByKey('B');
    expect(root.addConnectionByKey('B'), isFalse);
  });

  test('Successfully remove a vertex', () {
    expect(connectedVertex.removeConnection(toBeAdded), isTrue);
  });

  test('Unsuccessfully remove a vertex', () {
    var aVertex = Vertex('-1');
    expect(connectedVertex.removeConnection(aVertex), isFalse);
  });

  test('Successfully remove a vertex by key', () {
    expect(connectedVertex.removeConnectionByKey('1'), isTrue);
  });

  test('Unsuccessfully remove a vertex by key', () {
    expect(connectedVertex.removeConnectionByKey('-1'), isFalse);
  });

  test('Check for vertex containment', () {
    expect(connectedVertex.contains(toBeAdded), isTrue);
    expect(connectedVertex.contains(Vertex('I am not connected')), isFalse);
  });

  test('Check for vertex containment by key', () {
    expect(connectedVertex.containsKey('1'), isTrue);
    expect(connectedVertex.containsKey('10'), isFalse);
  });

  test('Get a list of vertices', () {
    var a = Vertex('A');
    var b = Vertex('B');
    var c = Vertex('C');
    root.addConnection(a);
    root.addConnection(b);
    root.addConnection(c);
    expect(root.connectedVertices, equals(<Vertex>{a, b, c}));
  });

  test('Get a list of vertex keys', () {
    root.addConnectionByKey('a');
    root.addConnectionByKey('b');
    root.addConnectionByKey('c');
    expect(root.connectedVertexKeys, equals(<String>{'a', 'b', 'c'}));
  });

  test('Check for isolated vertex', () {
    expect(root.isIsolated, isTrue);
    expect(connectedVertex.isIsolated, isFalse);
  });

  test('Get out degree for vertex', () {
    expect(root.outDegree, equals(0));
    connectedVertex.addConnectionByKey('C');
    expect(connectedVertex.outDegree, equals(3));
  });

  test('String representation of a vertex', () {
    expect(connectedVertex.toString(), equals('0'));
    expect(root.toString(), equals('A'));
  });

  test('String representation of a connection', () {
    expect(connectedVertex.connections['1'].toString(), equals('>- 1:1 ->'));
    connectedVertex.addConnection(Vertex('L'), 10);
    expect(connectedVertex.connections['L'].toString(), equals('>- L:10 ->'));
  });
}
