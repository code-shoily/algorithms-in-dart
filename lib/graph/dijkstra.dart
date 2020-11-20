import 'simple_graph.dart';
import 'vertex.dart';

/// Returns the shortest path from [source] of [graph]
Map<Vertex, num> dijkstra(SimpleGraph graph, Vertex source) {
  _ensurePositiveWeight(graph);
  var path = <Vertex, int>{source: 0};
  var pathSet = <Vertex>{};
  var vertices = graph.vertices;

  for (var _ in vertices) {
    var u = _minimumDistance(vertices, path, pathSet);
    pathSet.add(u);

    u.outgoingConnections.forEach((v, w) {
      if (!pathSet.contains(v)) {
        _relax(path, u, v, w);
      }
    });
  }

  return path;
}

void _relax(Map path, Vertex u, Vertex v, num w) {
  if (_shouldRelax(path, u, v, w)) {
    path[v] = path[u] + w;
  }
}

bool _shouldRelax(Map path, Vertex u, Vertex v, num w) => path.containsKey(v)
    ? path.containsKey(u)
        ? path[v] > path[u] + w
        : false
    : path.containsKey(u);

Vertex _minimumDistance(
    List<Vertex> vertices, Map<Vertex, int> path, Set<Vertex> pathSet) {
  int? min;
  Vertex? vertex;

  for (var v in vertices) {
    var updateMinimum = min == null || (path.containsKey(v) && path[v]! < min);
    if (updateMinimum && !pathSet.contains(v)) {
      min = path[v];
      vertex = v;
    }
  }

  return vertex!;
}

void _ensurePositiveWeight(SimpleGraph g) {
  for (var edge in g.edges) {
    if (edge[2] <= 0) {
      throw AssertionError('Graph cannot contain negative or zero value');
    }
  }
}
