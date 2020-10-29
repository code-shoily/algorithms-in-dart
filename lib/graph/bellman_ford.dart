import 'graph.dart';

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
