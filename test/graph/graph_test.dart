import 'package:test/test.dart';

import 'package:algorithms/graph/graph.dart';
import 'package:algorithms/graph/vertex.dart';
import 'package:algorithms/graph/settings.dart';

void main() {
  Graph simpleGraph;
  Graph emptyGraph;

  setUp(() {
    emptyGraph = Graph();

    /*    b -4- c            
         /      | 
        a --2-- d
         \      
          f -7- e 
    */
    simpleGraph = Graph();

    var a = Vertex('a');
    var b = Vertex('b');
    var c = Vertex('c');
    var d = Vertex('d');
    var e = Vertex('e');
    var f = Vertex('f');

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
    var graph = Graph(settings: Settings(allowLoops: false));
    var vertex = Vertex('LOOP');
    expect(() => graph.addEdge(vertex, vertex), throwsA(isA<Error>()));
  });

  test('Loops are allowed if settings permits', () {
    var graph = Graph(settings: Settings(allowLoops: true));
    var vertex = Vertex('LOOP');
    graph.addEdge(vertex, vertex);
    expect(graph.numberOfVertices, equals(1));
  });

  test('Digraphs add connections in one way', () {
    var graph = Graph(settings: Settings(isDigraph: true));
    var a = Vertex('A');
    var b = Vertex('B');
    graph.addEdge(a, b);
    expect(graph.numberOfEdges, equals(1));
  });

  test('Non-digraphs add connections in both ways', () {
    var graph = Graph(settings: Settings(isDigraph: false));
    var a = Vertex('A');
    var b = Vertex('B');
    graph.addEdge(a, b);
    expect(graph.numberOfEdges, equals(2));
  });

  test('Checks for vertex', () {
    var graph = Graph();
    var a = Vertex('A');
    var b = Vertex('B');
    var c = Vertex('C');
    graph.addEdge(a, b);
    expect(graph.containsVertex(a), isTrue);
    expect(graph.containsVertex(b), isTrue);
    expect(graph.containsVertex(c), isFalse);
  });

  test('Checks for vertex by key', () {
    expect(simpleGraph.containsVertexKey('a'), isTrue);
    expect(simpleGraph.containsVertexKey('z'), isFalse);
  });

  test('Adds a new vertex', () {
    var x = Vertex('x');
    expect(simpleGraph.addVertex(x), isTrue);
  });

  test('Does not add vertex with existing key', () {
    var a = Vertex('a');
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
    graph.addVertex(Vertex('0'));
    expect(graph.isSingleton, isTrue);
  });

  test('Check for empty graph', () {
    expect(emptyGraph.isEmpty, isTrue);
    expect(simpleGraph.isEmpty, isFalse);

    var graph = Graph();
    var a = Vertex('a');
    var b = Vertex('b');
    graph.addVertex(a);
    graph.addVertex(b);
    expect(graph.isEmpty, isTrue);
    graph.addEdge(a, b);
    expect(graph.isEmpty, isFalse);
  });
}
