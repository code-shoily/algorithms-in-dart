import '../lists/queue.dart';
import 'simple_graph.dart';
import 'traversal.dart';
import 'vertex.dart';

/// Recursively traverse graph in depth first.
Traversal traverse(SimpleGraph graph, Vertex vertex) {
  var traversal = Traversal();

  _doBFS(graph, vertex, traversal);

  return traversal;
}

void _doBFS(SimpleGraph graph, Vertex vertex, Traversal traversal) {
  var queue = Queue<Vertex>();
  traversal.addVisited(vertex);
  queue.enqueue(vertex);

  while (!queue.isEmpty) {
    var currentVertex = queue.dequeue();
    traversal.addVisit(currentVertex);
    for (var connectedVertex in currentVertex.outgoingVertices) {
      if (!traversal.hasVisited(connectedVertex)) {
        traversal.addVisited(connectedVertex);
        queue.enqueue(connectedVertex);
      }
    }
  }
}
