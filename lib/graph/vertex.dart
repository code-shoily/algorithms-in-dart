import 'dart:collection';

/// A vertex of a [Graph]. A vertex contains a `key` uniquely identifying it.
/// Value is optional, it is used when complex data structure may be attached to
/// the vertex. By default, the `key` and `value` are the same.
class Vertex<T> {
  final String _key;

  /// Uniquely identifiable key to this [Vertex]
  String get key => _key;

  /// Optional value
  T value;

  final LinkedHashMap<Vertex, num> _incomingConnections;

  /// Incoming connections from this [Vertex]
  LinkedHashMap<Vertex, num> get incomingConnections => _incomingConnections;

  final LinkedHashMap<Vertex, num> _outgoingConnections;

  /// Outgoing connections from this [Vertex]
  LinkedHashMap<Vertex, num> get outgoingConnections => _outgoingConnections;

  /// Constructor
  Vertex(this._key, [T value])
      : _incomingConnections = <Vertex, num>{} as LinkedHashMap,
        _outgoingConnections = <Vertex, num>{} as LinkedHashMap {
    this.value = value ?? key;
  }

  /// Adds a connection with [Vertex] `dst` and with `weight`
  bool addConnection(Vertex dst, [num weight = 1]) {
    if (outgoingConnections.containsKey(dst)) {
      return false;
    }
    _outgoingConnections[dst] = weight;
    dst._incomingConnections[this] = weight;
    return true;
  }

  /// Removes a connection with `other` with `weight`. `false` for non-existent
  /// connection.
  bool removeConnection(Vertex other, [num weight = 1]) {
    var outgoingRemoved = _outgoingConnections.remove(other) != null;
    var incomingRemoved = other._incomingConnections.remove(this) != null;
    return outgoingRemoved || incomingRemoved;
  }

  /// Checks if [Vertex] `other` is connected to this vertex
  bool containsConnectionTo(Vertex other) =>
      outgoingConnections.containsKey(other);

  /// Checks if [Vertex] `other` is connected to this vertex
  bool containsConnectionFrom(Vertex other) =>
      incomingConnections.containsKey(other);

  /// Get a list of adjacent incoming vertices
  Set<Vertex> get incomingVertices =>
      incomingConnections.keys.map((connection) => connection).toSet();

  /// Get a list of adjacent outgoing vertices
  Set<Vertex> get outgoingVertices =>
      outgoingConnections.keys.map((connection) => connection).toSet();

  /// Is this vertex isolated?
  bool get isIsolated => outgoingConnections.isEmpty;

  /// Calculate the inDegree of the vertex
  int get inDegree => incomingConnections.length;

  /// Calculate the outDegree of the vertex
  int get outDegree => outgoingConnections.length;

  @override
  String toString() => key;
}
