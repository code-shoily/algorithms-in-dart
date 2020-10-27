import 'dart:collection';

import './settings.dart';
import 'node.dart';

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

  /// Adds an edge
  void addEdge(Vertex src, Vertex dst, [int weight = 1]) {
    if (src.key == dst.key && !settings.allowLoops) throw Error();

    src = _getOrAddVertex(src.key, src.value);
    dst = _getOrAddVertex(dst.key, dst.value);
    src.addConnection(dst, weight);

    if (!settings.isDigraph) dst.addConnection(src, weight);
  }

  Vertex<T> _getOrAddVertex(String key, [T value]) =>
      vertices.putIfAbsent(key, () => Vertex(key, value ?? key));
}
