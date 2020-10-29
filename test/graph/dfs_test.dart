import 'package:test/test.dart';

import 'package:algorithms_in_dart/graph/dfs.dart';
import 'package:algorithms_in_dart/graph/graph.dart';
import 'package:algorithms_in_dart/graph/settings.dart';
import 'package:algorithms_in_dart/graph/vertex.dart';

void main() {
  Graph graph;
  Vertex u, v, w, x, y, z;

  void _initializeVertices() {
    u = Vertex('U');
    v = Vertex('V');
    w = Vertex('W');
    x = Vertex('X');
    y = Vertex('Y');
    z = Vertex('Z');
  }

  setUp(() {
    _initializeVertices();
    graph = Graph(settings: Settings(isDigraph: true));
    /*    v --- y
         /      |
        u ----- z
         \
          w -- x
    */
    graph.addEdge(u, v);
    graph.addEdge(u, w);
    graph.addEdge(u, z);
    graph.addEdge(v, y);
    graph.addEdge(w, x);
    graph.addEdge(y, z);
  });

  test('Test DFS', () {
    var traversal = traverse(graph, u);
    expect(
        traversal.visits,
        anyOf([
          <Vertex>[u, z, v, y, w, x],
          <Vertex>[u, z, w, x, v, y]
        ]));

    traversal = traverse(graph, w);
    expect(traversal.visits, <Vertex>[w, x]);

    traversal = traverse(graph, z);
    expect(traversal.visits, <Vertex>[z]);
  });
}
