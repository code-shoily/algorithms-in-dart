import 'package:test/test.dart';

import 'package:algorithms/graph/dijkstra.dart';
import 'package:algorithms/graph/simple_graph.dart';
import 'package:algorithms/graph/vertex.dart';

void main() {
  late SimpleGraph graph;
  late Vertex a, b, c, d, e;

  void _initializeVertices() {
    a = Vertex('A');
    b = Vertex('B');
    c = Vertex('C');
    d = Vertex('D');
    e = Vertex('E');
  }

  setUp(() {
    _initializeVertices();
    graph = SimpleGraph();
    graph.addEdge(a, b, 1);
    graph.addEdge(a, c, 4);
    graph.addEdge(b, c, 3);
    graph.addEdge(b, d, 2);
    graph.addEdge(b, e, 2);
    graph.addEdge(e, d, 3);
    graph.addEdge(d, b, 1);
    graph.addEdge(d, c, 5);
  });

  test('Apply bellman ford algorithms', () {
    var expectedShortestDistances = <Vertex, num>{
      a: 0,
      b: 1,
      c: 4,
      d: 3,
      e: 3,
    };
    expect(dijkstra(graph, a), equals(expectedShortestDistances));
  });
}
