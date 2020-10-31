import 'package:algorithms/graph/bellman_ford.dart';
import 'package:test/test.dart';

import 'package:algorithms/graph/graph.dart';
import 'package:algorithms/graph/vertex.dart';

void main() {
  Graph graph;
  Vertex a, b, c, d, e;

  void _initializeVertices() {
    a = Vertex('A');
    b = Vertex('B');
    c = Vertex('C');
    d = Vertex('D');
    e = Vertex('E');
  }

  setUp(() {
    _initializeVertices();
    graph = Graph();
    graph.addEdge(a, b, -1);
    graph.addEdge(a, c, 4);
    graph.addEdge(b, c, 3);
    graph.addEdge(b, d, 2);
    graph.addEdge(b, e, 2);
    graph.addEdge(e, d, -3);
    graph.addEdge(d, b, 1);
    graph.addEdge(d, c, 5);
  });

  test('Apply bellman ford algorithms', () {
    var expectedShortestDistances = <Vertex, num>{
      a: 0,
      b: -1,
      c: 2,
      d: -2,
      e: 1,
    };
    expect(bellmanFord(graph, a), equals(expectedShortestDistances));
  });
}
