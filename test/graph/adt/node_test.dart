import 'package:test/test.dart';

import 'package:algorithms_in_dart/graph/adt/node.dart';

void main() {
  Vertex vertex, vertexKeyOnly;
  Connection connection, connectionUnweighed;

  setUp(() {
    vertex = Vertex('root', 0);
    vertexKeyOnly = Vertex('root');
    connection = Connection(vertex, 10);
    connectionUnweighed = Connection(Vertex('root'));
  });

  test('Vertex without value receives key as value', () {
    expect(vertexKeyOnly.key, equals('root'));
    expect(vertexKeyOnly.value, equals('root'));
  });

  test('Add new connection to vertex', () {
    var vertex_2 = Vertex('child');
    vertex.addConnection(vertex_2, 20);
    expect(vertex.connections.keys, equals(['child']));
    expect(vertex.connections['child'].weights, equals({20}));

    vertex.addConnection(vertex_2, 30);
    expect(vertex.connections.keys, equals(['child']));
    expect(vertex.connections['child'].weights, equals({20, 30}));
  });

  test('Remove a connection from the vertex', () {
    var child_1 = Vertex('child_1');
    var child_2 = Vertex('child_2');
    vertex.addConnection(child_1, 10);
    vertex.addConnection(child_2, 20);
    expect(vertex.removeConnection(child_1, 10), isTrue);
    expect(vertex.connections.keys, equals(['child_2']));
    expect(vertex.addConnection(child_2, 30), isTrue);
    expect(vertex.connections['child_2'].weights, equals({20, 30}));
    expect(vertex.removeConnection(child_2, 20), isTrue);
    expect(vertex.connections['child_2'].weights, equals({30}));
    expect(vertex.removeConnection(child_2, 30), isTrue);
    expect(vertex.connections.isEmpty, isTrue);
  });

  test('Remove inexistant connection from the vertex', () {
    var child_1 = Vertex('child_1');
    var child_2 = Vertex('child_2');
    expect(vertex.removeConnection(child_1, 10), isFalse);
    expect(vertex.connections, isEmpty);
    expect(vertex.connections, isEmpty);
    expect(vertex.removeConnection(child_2, 20), isFalse);
    expect(vertex.connections, isEmpty);
    expect(vertex.removeConnection(child_2, 30), isFalse);
    expect(vertex.connections.isEmpty, isTrue);
  });

  test('Remove all connections from a vertex', () {
    var child = Vertex('child');
    vertex.addConnection(child, 10);
    vertex.addConnection(child, 20);
    vertex.addConnection(child, 30);
    expect(vertex.connections['child'].weights, equals({10, 20, 30}));
    expect(vertex.removeAll(child), isTrue);
    expect(vertex.connections, isEmpty);
  });

  test('Remove inexistent connection from a vertex', () {
    var child = Vertex('child');
    vertex.addConnection(child, 10);
    vertex.addConnection(child, 20);
    vertex.addConnection(child, 30);

    var noConnectionVertex = Vertex('no_conn');
    expect(vertex.removeAll(noConnectionVertex), isFalse);
    expect(vertex.connections['child'].weights, equals({10, 20, 30}));
  });

  test('Allow multiple-paths to single node', () {
    expect(vertex.addConnection(vertexKeyOnly), isTrue);
    expect(vertex.addConnection(vertexKeyOnly, 20), isTrue);
    expect(vertex.connections['root'].weights, equals({1, 20}));
  });

  test('Default weight for connection is zero', () {
    expect(connectionUnweighed.weights, equals({1}));
  });

  test('Add weight to connection', () {
    expect(connection.addWeight(20), isTrue);
    expect(connection.weights, equals({10, 20}));
  });

  test('Adding existing weight returns false', () {
    expect(connection.addWeight(10), isFalse);
    expect(connection.weights, equals({10}));
  });

  test('Removing a weight returns true', () {
    expect(connection.removeWeight(10), isTrue);
    expect(connection.weights, isEmpty);
  });

  test('Removing non-existant weight returns false', () {
    expect(connection.removeWeight(20), isFalse);
    expect(connection.weights, equals({10}));
  });

  test('Check for connection emptiness', () {
    expect(connection.isEmpty, isFalse);
    expect(connectionUnweighed.isEmpty, isFalse);
    expect(connection.removeWeight(10), isTrue);
    expect(connection.isEmpty, isTrue);
  });

  test('Check for vertex in connection', () {
    var child_1 = Vertex('child_1');
    vertex.addConnection(child_1, 10);
    var child_2 = Vertex('child_2');
    vertex.addConnection(child_2, 20);
    var child_3 = Vertex('child_3');
    vertex.addConnection(child_3, 30);

    expect(vertex.contains(child_1), isTrue);
    expect(vertex.contains(child_2), isTrue);
    expect(vertex.contains(child_3), isTrue);
  });

  test('Check for inexistant vertex in connection', () {
    var child_1 = Vertex('child_1');
    var child_2 = Vertex('child_2');
    var child_3 = Vertex('child_3');

    expect(vertex.contains(child_1), isFalse);
    expect(vertex.contains(child_2), isFalse);
    expect(vertex.contains(child_3), isFalse);
  });

  test('Check for key in connection', () {
    vertex.addConnection(Vertex('child_1'), 10);
    vertex.addConnection(Vertex('child_2'), 20);
    vertex.addConnection(Vertex('child_3'), 30);

    expect(vertex.containsKey('child_1'), isTrue);
    expect(vertex.containsKey('child_2'), isTrue);
    expect(vertex.containsKey('child_3'), isTrue);
  });

  test('Check for inexistant key in connection', () {
    Vertex('child_1');
    Vertex('child_2');
    Vertex('child_3');

    expect(vertex.containsKey('child_1'), isFalse);
    expect(vertex.containsKey('child_2'), isFalse);
    expect(vertex.containsKey('child_3'), isFalse);
  });
}
