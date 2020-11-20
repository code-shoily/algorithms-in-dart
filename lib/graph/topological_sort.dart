import 'dart:collection';

import 'simple_graph.dart';
import 'vertex.dart';

/// Returns topological sort using Kahn's algorithm
List<Vertex>? topologicalSort(SimpleGraph graph) {
  var sorted = <Vertex>[];
  var inDegreeData = inDegrees(graph);
  var noInDegrees = <Vertex>{};

  inDegreeData.forEach((key, value) {
    if (value == 0) {
      noInDegrees.add(key);
    }
  });

  while (noInDegrees.isNotEmpty) {
    var vertex = noInDegrees.first;
    noInDegrees.remove(vertex);
    sorted.add(vertex);

    for (var connectedVertex in vertex.outgoingVertices) {
      inDegreeData[connectedVertex] = inDegreeData[connectedVertex]! - 1;
      if (inDegreeData[connectedVertex] == 0) {
        noInDegrees.add(connectedVertex);
      }
    }
  }

  if (_detectCycle(inDegreeData)) {
    return null;
  }
  return sorted;
}

bool _detectCycle(HashMap<Vertex, int> inDegreeData) =>
    inDegreeData.values.where((element) => element > 0).isNotEmpty;

/// Returns in degrees of all vertices of [graph]
HashMap<Vertex, int> inDegrees(SimpleGraph graph) {
  var inDegrees = HashMap<Vertex, int>();
  var vertices = graph.vertices;

  for (var vertex in vertices) {
    inDegrees.putIfAbsent(vertex, () => 0);
    for (var connectedVertex in vertex.outgoingVertices) {
      inDegrees.update(connectedVertex, (value) => value + 1,
          ifAbsent: () => 1);
    }
  }

  return inDegrees;
}
