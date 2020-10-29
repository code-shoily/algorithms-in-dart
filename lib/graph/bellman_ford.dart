import 'dart:collection';

import 'graph.dart';
import 'vertex.dart';

/// Gets an edge list for [graph].
///
/// **NOTE** This function may be moved to [Graph] as method after a future
/// refactor/refinement. Also, considering adding `Edge` class or using `Tuple`
/// library for this.
List<List> getEdges(Graph graph) {
  return [
    for (var vertex in graph.vertices.values) ...[
      for (var connection in vertex.connections.values)
        [vertex, connection.vertex, connection.weight]
    ]
  ];
}

/// Run the Bellman Ford algorithm to get the shortest paths from [source] to
/// all vertices.
HashMap<Vertex, num> bellmanFord(Graph graph, Vertex source) {
  var distances = HashMap<Vertex, num>();
  distances[source] = 0;

  var edges = getEdges(graph);
  var counter = graph.numberOfVertices - 1;

  bool shouldUpdate(Vertex u, Vertex v, num w) {
    if (!distances.containsKey(u)) return false;
    var uValue = distances[u];
    var vValue = distances[v] ?? (uValue + w + 1);

    return uValue + w < vValue;
  }

  while (counter > 0) {
    for (var edge in edges) {
      var u = edge[0];
      var v = edge[1];
      var w = edge[2];
      if (shouldUpdate(u, v, w)) {
        distances[v] = distances[u] + w;
      }
    }

    counter--;
  }

  for (var edge in edges) {
    var u = edge[0];
    var v = edge[1];
    var w = edge[2];
    if (shouldUpdate(u, v, w)) {
      return null;
    }
  }

  return distances;
}
