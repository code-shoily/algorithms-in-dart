import 'dart:collection';

import 'settings.dart';
import 'vertex.dart';

/// A Graph Type
class Graph<T> {
  /// Vertices of this graph
  HashMap<String, Vertex<T>> vertices;

  /// Settings for this graph
  Settings settings;

  /// Create a new graph based on [settings]
  Graph({Settings settings}) {
    vertices = HashMap();
    this.settings = settings ?? Settings();
  }

  /// Total number of vertices for this graph
  int get numberOfVertices => vertices.entries.length;

  /// Total number of edges
  int get numberOfEdges =>
      vertices.values.map((v) => v.outDegree).fold(0, (a, b) => a + b);

  /// Adds an edge
  void addEdge(Vertex src, Vertex dst, [num weight = 1]) {
    if (src.key == dst.key && !settings.allowLoops) throw Error();

    src = _getOrAddVertex(src);
    dst = _getOrAddVertex(dst);
    src.addConnection(dst, weight);

    if (!settings.isDigraph) dst.addConnection(src, weight);
  }

  /// Checks if vertex is included
  bool containsVertex(Vertex vertex) => vertices[vertex.key] == vertex;

  /// Checks if vertex is included by key
  bool containsVertexKey(String vertexKey) => vertices.containsKey(vertexKey);

  /// Checks if this is a null graph
  bool get isNull => numberOfVertices == 0;

  /// Checks if this is a singleton graph
  bool get isSingleton => numberOfVertices == 1;

  /// Checks if this is an empty graph
  bool get isEmpty => numberOfEdges == 0;

  /// Adds a new vertex
  bool addVertex(Vertex vertex) {
    if (containsVertexKey(vertex.key)) {
      return false;
    }
    vertices[vertex.key] = vertex;
    return true;
  }

  Vertex<T> _getOrAddVertex(Vertex vertex) =>
      vertices.putIfAbsent(vertex.key, () => vertex);
}
