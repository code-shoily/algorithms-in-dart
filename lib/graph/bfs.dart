import '../lists/queue.dart';
import 'graph.dart';
import 'traversal.dart';
import 'vertex.dart';

/// Recursively traverse graph in depth first.
Traversal traverse(Graph graph, Vertex vertex) {
  var traversal = Traversal();

  _doBFS(graph, vertex, traversal);

  return traversal;
}

void _doBFS(Graph graph, Vertex vertex, Traversal traversal) {
  var queue = Queue<Vertex>();
  traversal.addVisited(vertex);
  queue.enqueue(vertex);

  while (!queue.isEmpty) {
    var currentVertex = queue.dequeue();
    traversal.addVisit(currentVertex);
    for (var connectedVertex in currentVertex.connectedVertices) {
      if (!traversal.hasVisited(connectedVertex)) {
        traversal.addVisited(connectedVertex);
        queue.enqueue(connectedVertex);
      }
    }
  }
}
