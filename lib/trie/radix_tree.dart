/// A space-optimized trie where each node with only one child is merged
/// with its parent, and edges are labeled with strings.
///
/// Also known as a **compressed trie** or **radix trie**.
class RadixTree {
  /// Root of the tree.
  RadixTreeNode? root;

  /// Tests if this tree is empty.
  bool get isEmpty => root == null;

  /// Adds a [value] to the tree.
  void add(String value) {
    if (isEmpty) {
      root = RadixTreeNode();
    }
    _add(root!, value);
  }

  /// Checks if [value] is contained in the tree.
  bool contains(String value) {
    if (isEmpty) return false;
    var node = _findNode(root!, value);
    return node != null && node.isValue;
  }

  /// Deletes [value] from the tree.
  void delete(String value) {
    if (isEmpty) return;
    _delete(root!, value);
    if (root != null && root!.children.isEmpty && !root!.isValue) {
      root = null;
    }
  }

  /// Empties the tree.
  void nullify() => root = null;

  /// Returns all values in the tree that start with [prefix].
  List<String> findWithPrefix(String prefix) {
    if (isEmpty) return [];
    var result = <String>[];
    _findWithPrefix(root!, prefix, '', result);
    return result;
  }

  void _add(RadixTreeNode node, String value) {
    if (value.isEmpty) {
      node.isValue = true;
      return;
    }

    for (var entry in node.children.entries) {
      var edge = entry.key;
      var child = entry.value;

      var common = _commonPrefix(edge, value);
      if (common.isEmpty) continue;

      if (common == edge) {
        _add(child, value.substring(common.length));
        return;
      }

      var oldSuffix = edge.substring(common.length);
      var newSuffix = value.substring(common.length);

      var intermediate = RadixTreeNode();
      intermediate.children[oldSuffix] = child;

      node.children.remove(edge);
      node.children[common] = intermediate;

      if (newSuffix.isEmpty) {
        intermediate.isValue = true;
      } else {
        intermediate.children[newSuffix] = RadixTreeNode()..isValue = true;
      }
      return;
    }

    node.children[value] = RadixTreeNode()..isValue = true;
  }

  RadixTreeNode? _findNode(RadixTreeNode node, String value) {
    if (value.isEmpty) return node;

    for (var entry in node.children.entries) {
      var edge = entry.key;
      if (value.startsWith(edge)) {
        return _findNode(entry.value, value.substring(edge.length));
      }
      if (edge.startsWith(value)) {
        return null;
      }
    }
    return null;
  }

  bool _delete(RadixTreeNode node, String value) {
    for (var entry in node.children.entries) {
      var edge = entry.key;
      var child = entry.value;

      if (value == edge) {
        child.isValue = false;
        _compress(node, edge, child);
        return true;
      }

      if (value.startsWith(edge)) {
        if (_delete(child, value.substring(edge.length))) {
          _compress(node, edge, child);
          return true;
        }
        return false;
      }
    }
    return false;
  }

  void _compress(RadixTreeNode parent, String edge, RadixTreeNode node) {
    if (node.isValue) return;
    if (node.children.length > 1) return;

    if (node.children.isEmpty) {
      parent.children.remove(edge);
    } else {
      var childEntry = node.children.entries.first;
      var newEdge = edge + childEntry.key;
      parent.children.remove(edge);
      parent.children[newEdge] = childEntry.value;
    }
  }

  void _findWithPrefix(
    RadixTreeNode node,
    String prefix,
    String accumulated,
    List<String> result,
  ) {
    if (prefix.isEmpty) {
      _collect(node, accumulated, result);
      return;
    }

    for (var entry in node.children.entries) {
      var edge = entry.key;
      if (prefix.startsWith(edge)) {
        _findWithPrefix(
          entry.value,
          prefix.substring(edge.length),
          accumulated + edge,
          result,
        );
        return;
      }
      if (edge.startsWith(prefix)) {
        _collect(entry.value, accumulated + edge, result);
        return;
      }
    }
  }

  void _collect(RadixTreeNode node, String prefix, List<String> result) {
    if (node.isValue) result.add(prefix);
    for (var entry in node.children.entries) {
      _collect(entry.value, prefix + entry.key, result);
    }
  }

  String _commonPrefix(String a, String b) {
    var minLen = a.length < b.length ? a.length : b.length;
    var i = 0;
    while (i < minLen && a[i] == b[i]) {
      i++;
    }
    return a.substring(0, i);
  }
}

/// A node in a [RadixTree].
class RadixTreeNode {
  /// Whether this node represents a complete value in the tree.
  bool isValue = false;

  /// Map from edge label to child node.
  Map<String, RadixTreeNode> children = {};
}
