import 'vertex.dart';

/// A Graph Type
class Graph<T> {
  /// Vertices of this graph
  Set<Vertex<T>> vertices;

  /// Settings for this graph
  /// Is this a Digraph?
  bool isDigraph;

  /// Does this graph allow loops?
  bool allowLoops;

  /// Create a new graph
  Graph({this.isDigraph = true, this.allowLoops = false}) {
    vertices = <Vertex<T>>{};
  }

  /// Total number of vertices for this graph
  int get numberOfVertices => vertices.length;

  /// Total number of edges
  int get numberOfEdges =>
      vertices.map((v) => v.outDegree).fold(0, (a, b) => a + b);

  /// Adds an edge
  void addEdge(Vertex src, Vertex dst, [num weight = 1]) {
    if (src.key == dst.key && !allowLoops) throw Error();

    src = _getOrAddVertex(src);
    dst = _getOrAddVertex(dst);
    src.addConnection(dst, weight);

    if (!isDigraph) dst.addConnection(src, weight);
  }

  /// Checks if vertex is included
  bool containsVertex(Vertex vertex) => vertices.contains(vertex);

  /// Checks if this is a null graph
  bool get isNull => numberOfVertices == 0;

  /// Checks if this is a singleton graph
  bool get isSingleton => numberOfVertices == 1;

  /// Checks if this is an empty graph
  bool get isEmpty => numberOfEdges == 0;

  /// Adds a new vertex
  bool addVertex(Vertex vertex) => vertices.add(vertex);

  Vertex<T> _getOrAddVertex(Vertex vertex) =>
      vertices.add(vertex) ? vertex : vertex;

  /// Gets an edge list for [this].
  List<List> get edges => [
        for (var vertex in vertices) ...[
          for (var connection in vertex.outgoingConnections.entries)
            [vertex, connection.key, connection.value]
        ]
      ];
}
