import 'dart:collection';

import 'package:algorithms_in_dart/graph/adt/settings.dart';
import 'node.dart';

class Graph<T> {
  HashMap<String, Vertex<T>> vertices;
  Settings settings;

  Graph({Settings settings}) {
    vertices = HashMap();
    this.settings = settings ?? Settings();
  }

  int get numberOfVertices => vertices.entries.length;

  /// Adds an edge
  void addEdge(Vertex src, Vertex dst, [weight = 1]) {
    if (src.key == dst.key && !settings.allowLoops) throw Error();

    src = _getOrAddVertex(src.key, src.value);
    dst = _getOrAddVertex(dst.key, dst.value);
    src.addConnection(dst, weight);

    if (!settings.isDigraph) dst.addConnection(src, weight);
  }

  Vertex<T> _getOrAddVertex(String key, [T value]) =>
      vertices.putIfAbsent(key, () => Vertex(key, value ?? key));
}
