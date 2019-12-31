import 'dart:collection';

/// A vertex of a [Graph]. A vertex contains a `key` that uniquely identifies it.
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

  Vertex(this._key, [T value]) {
    connections = HashMap();
    this.value = value ?? key;
  }

  /// Adds a connectiob with [Vertex] `dst` and with `weight`
  bool addConnection(Vertex dst, [weight = 1]) {
    try {
      connections.update(dst.key, (v) {
        v.addWeight(weight);
        return v;
      }, ifAbsent: () => Connection(dst, weight));
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Removes a connection with `other` with `weight`. `false` for inexistent connection.
  bool removeConnection(Vertex other, [num weight = 1]) {
    if (!connections.containsKey(other.key)) return false;
    var connection = connections.update(other.key, (v) {
      v.removeWeight(weight);
      return v;
    });

    if (connection.isEmpty) connections.remove(other.key);

    return true;
  }

  /// Removes all connections with the associated vertex. `true` is removal is successful.
  bool removeAll(Vertex other) => connections.remove(other.key) != null;

  /// Checks if [Vertex] `other` is connected to this vertex
  bool contains(Vertex other) => connections.containsKey(other.key);

  /// Checks if [Vertex] with key `key` is connected to this.
  bool containsKey(String key) => connections.containsKey(key);
}

/// A connection represents the outgoing link information. It is a connection with a destination [Vertex]
/// and a set of `weight`. If no weight is mentioned the it is assumed to be `1`. And empty connection is
/// a connection with no weights attached to it.
class Connection {
  final Vertex _vertex;

  /// Destination [Vertex]
  Vertex get vertex => _vertex;

  final Set<num> _weights;

  /// A set of weights.
  Set<num> get weights => _weights;

  Connection(this._vertex, [weight = 1]) : _weights = <num>{weight};

  /// Adds a `weight` for the connected [Vertex]. If it already exists then `false` is returned.
  bool addWeight(num weight) => weights.add(weight);

  /// Removes `weight` from the connected [Vertex]. If the `weight` doesn't exist then returns `false`
  bool removeWeight(num weight) => weights.remove(weight);

  /// Checks if the connection has no weights attached.
  bool get isEmpty => _weights.isEmpty;
}
