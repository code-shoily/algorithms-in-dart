import 'package:test/test.dart';

import 'package:algorithms/graph/bfs.dart';
import 'package:algorithms/graph/graph.dart';
import 'package:algorithms/graph/settings.dart';
import 'package:algorithms/graph/vertex.dart';

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

  test('Test BFS', () {
    var traversal = traverse(graph, u);
    expect(
        traversal.visits,
        anyOf([
          <Vertex>[u, v, w, z, x, y],
          <Vertex>[u, v, z, w, x, y],
          <Vertex>[u, w, v, z, x, y],
          <Vertex>[u, w, z, v, x, y],
          <Vertex>[u, z, v, w, x, y],
          <Vertex>[u, z, w, v, x, y],
          <Vertex>[u, v, w, z, y, y],
          <Vertex>[u, v, z, w, y, x],
          <Vertex>[u, w, v, z, y, x],
          <Vertex>[u, w, z, v, y, x],
          <Vertex>[u, z, v, w, y, x],
          <Vertex>[u, z, w, v, y, x],
        ]));

    traversal = traverse(graph, w);
    expect(traversal.visits, <Vertex>[w, x]);

    traversal = traverse(graph, z);
    expect(traversal.visits, <Vertex>[z]);
  });
}
