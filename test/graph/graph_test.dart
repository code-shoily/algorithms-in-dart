import 'package:test/test.dart';

import 'package:algorithms/graph/graph.dart';
import 'package:algorithms/graph/vertex.dart';

void main() {
  Graph emptyGraph, simpleGraph;
  Vertex a, b, c, d, e, f, u, v;

  void _initializeVertices() {
    a = Vertex('a');
    b = Vertex('b');
    c = Vertex('c');
    d = Vertex('d');
    e = Vertex('e');
    f = Vertex('f');
    u = Vertex('u');
    v = Vertex('v');
  }

  setUp(() {
    _initializeVertices();
    emptyGraph = Graph();

    /*    b -4- c            
         /      | 
        a --2-- d
         \      
          f -7- e 
    */
    simpleGraph = Graph();

    simpleGraph.addEdge(a, b);
    simpleGraph.addEdge(a, f);
    simpleGraph.addEdge(b, c, 4);
    simpleGraph.addEdge(d, a, 2);
    simpleGraph.addEdge(f, e, 7);
    simpleGraph.addEdge(c, d);
  });

  test('Total number of vertices', () {
    expect(emptyGraph.numberOfVertices, equals(0));
    expect(simpleGraph.numberOfVertices, equals(6));
  });

  test('Total number of edges', () {
    expect(emptyGraph.numberOfEdges, equals(0));
    expect(simpleGraph.numberOfEdges, equals(6));
  });

  test('Loops are not allowed', () {
    var graph = Graph(allowLoops: false);
    expect(() => graph.addEdge(a, a), throwsA(isA<Error>()));
  });

  test('Loops are allowed if settings permits', () {
    var graph = Graph(allowLoops: true);
    graph.addEdge(u, u);
    expect(graph.numberOfVertices, equals(1));
  });

  test('Digraphs add connections in one way', () {
    var graph = Graph(isDigraph: true);
    graph.addEdge(u, v);
    expect(graph.numberOfEdges, equals(1));
  });

  test('Non-digraphs add connections in both ways', () {
    var graph = Graph(isDigraph: false);
    graph.addEdge(u, v);
    expect(graph.numberOfEdges, equals(2));
  });

  test('Checks for vertex', () {
    var graph = Graph();
    graph.addEdge(u, v);
    expect(graph.containsVertex(u), isTrue);
    expect(graph.containsVertex(v), isTrue);
    expect(graph.containsVertex(a), isFalse);
  });

  test('Checks for vertex by key', () {
    expect(simpleGraph.containsVertex(a), isTrue);
    expect(simpleGraph.containsVertex(u), isFalse);
  });

  test('Adds a new vertex', () {
    expect(simpleGraph.containsVertex(u), isFalse);
    expect(simpleGraph.addVertex(u), isTrue);
    expect(simpleGraph.containsVertex(u), isTrue);
  });

  test('Does not add vertex with existing key', () {
    expect(simpleGraph.numberOfVertices, equals(6));
    expect(simpleGraph.addVertex(a), isFalse);
    expect(simpleGraph.numberOfVertices, equals(6));
  });

  test('Check for NULL graph', () {
    expect(emptyGraph.isNull, isTrue);
    expect(simpleGraph.isNull, isFalse);
  });

  test('Check for singleton graph', () {
    expect(emptyGraph.isSingleton, isFalse);
    expect(simpleGraph.isSingleton, isFalse);

    var graph = Graph();
    graph.addVertex(u);
    expect(graph.isSingleton, isTrue);
  });

  test('Check for empty graph', () {
    expect(emptyGraph.isEmpty, isTrue);
    expect(simpleGraph.isEmpty, isFalse);

    var graph = Graph();
    graph.addVertex(u);
    graph.addVertex(v);
    expect(graph.isEmpty, isTrue);
    graph.addEdge(u, v);
    expect(graph.isEmpty, isFalse);
  });

  test('Get edges of graph', () {
    expect(emptyGraph.edges, isEmpty);
    var expectedEdges = {
      {a, b, 1},
      {a, f, 1},
      {b, c, 4},
      {d, a, 2},
      {f, e, 7},
      {c, d, 1}
    };
    expect(simpleGraph.edges.toSet(), equals(expectedEdges));
  });
}
