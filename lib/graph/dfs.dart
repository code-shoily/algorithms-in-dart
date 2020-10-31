import 'graph.dart';
import 'traversal.dart';
import 'vertex.dart';

/// Recursively traverse graph in depth first.
Traversal traverse(Graph graph, Vertex vertex) {
  var traversal = Traversal();

  _doDFS(graph, vertex, traversal);

  return traversal;
}

void _doDFS(Graph graph, Vertex vertex, Traversal traversal) {
  traversal.addVisited(vertex);
  traversal.addVisit(vertex);
  for (var connectedVertex in vertex.outgoingVertices) {
    if (!traversal.hasVisited(connectedVertex)) {
      _doDFS(graph, connectedVertex, traversal);
    }
  }
}