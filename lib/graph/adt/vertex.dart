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

  /// Outgoing connections from this [Vertex]
  HashMap<String, Connection> connections;

  /// Constructor
  Vertex(this._key, [T value]) {
    connections = HashMap();
    this.value = value ?? key;
  }

  /// Adds a connection with [Vertex] `dst` and with `weight`
  bool addConnection(Vertex dst, [num weight = 1]) {
    if (connections.containsKey(dst.key)) {
      return false;
    }
    connections[dst.key] = Connection(dst, weight);

    return true;
  }

  /// Removes a connection with `other` with `weight`. `false` for inexistent
  /// connection.
  bool removeConnection(Vertex other, [num weight = 1]) {
    return connections.remove(other.key) != null;
  }

  /// Adds a connection with [Vertex] `dst` and with `weight`
  bool addConnectionByKey(String dst, [num weight = 1]) {
    if (connections.containsKey(dst)) {
      return false;
    }
    connections[dst] = Connection(Vertex(dst), weight);

    return true;
  }

  /// Removes a connection with `other` with `weight`. `false` if doesn't exist.
  bool removeConnectionByKey(String otherKey, [num weight = 1]) {
    return connections.remove(otherKey) != null;
  }

  /// Checks if [Vertex] `other` is connected to this vertex
  bool contains(Vertex other) => connections[other.key]?.vertex == other;

  /// Checks if [Vertex] with key `key` is connected to this.
  bool containsKey(String key) => connections.containsKey(key);

  /// Get a list of adjacent vertices
  Set<Vertex> get connectedVertices =>
      connections.values.map((connection) => connection.vertex).toSet();

  /// Gets keys of adjacent nodes
  Set<String> get connectedVertexKeys => connections.keys.toSet();

  /// Is this vertex isolated?
  bool get isIsolated => connections.isEmpty;

  /// Calculate the outDegree of the vertex
  int get outDegree => connections.length;
}

/// A connection represents the outgoing link information. It is a connection
/// with a destination [Vertex] and `weight`. If no weight is mentioned
/// then it is assumed to be `1`.
class Connection {
  /// Destination [vertex]
  final Vertex vertex;

  /// Weight for this connection
  final num weight;

  /// Constructor
  Connection(this.vertex, [this.weight = 1]);
}
