import 'vertex.dart';

/// ADT for graph traversal
class Traversal {
  final Set<Vertex> _visitedVertices;
  final List<Vertex> _visits;

  /// The visited vertices
  List<Vertex> get visits => _visits;

  /// Constructor
  Traversal()
      : _visitedVertices = <Vertex>{},
        _visits = <Vertex>[];

  /// Did this vertex visit already?
  bool hasVisited(Vertex vertex) {
    return _visitedVertices.contains(vertex);
  }

  /// Add this vertex to the visited set
  void addVisited(Vertex vertex) {
    _visitedVertices.add(vertex);
  }

  /// Add a new visit to the traversed list
  void addVisit(Vertex vertex) {
    _visits.add(vertex);
  }

  @override
  String toString() => _visitedVertices.toString();
}
