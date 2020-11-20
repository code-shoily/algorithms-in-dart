/// Trie is an ordered tree data structure used to store a dynamic set
///  or associative array where the keys are usually strings.
class Trie<V extends Comparable> {
  /// Root of the trie.
  TrieNode? root;

  /// Separates the value into it's components.
  final Function splitter;

  List _components;

  /// Initialises trie with custom set of values.
  Trie(Set components, this.splitter) : _components = [...components];

  /// Generates trie of lower-case alphabets.
  Trie.ofAlphabets()
      : this({...List.generate(26, (i) => String.fromCharCode(97 + i))},
            (value) => value.split(''));

  /// Returns the set of [components] that make up a value.
  Set<V> get components => {..._components};

  /// Tests if this trie is empty.
  bool get isEmpty => root?.children == null ? true : false;

  /// Adds a [value] to the trie.
  void add(V value) {
    var list = _split(value) as List<V>;
    if (isEmpty) {
      root ??= TrieNode({..._components});
    }
    _add(root!, list);
  }

  /// Checks if [value] is contained in the trie.
  bool contains(V value) {
    var list = _split(value) as List<V>;
    return isEmpty ? false : _contains(root!, list);
  }

  /// Deletes [value] from the trie.
  void delete(V value) {
    var list = _split(value) as List<V>;
    var returnValue = _delete(root, list);
    returnValue ?? nullify();
  }

  /// Empty the trie.
  void nullify() => root?.children = null;

  /// Traverses the path following [value]
  ///  and marks `node.isValue` to true at end.
  void _add(TrieNode node, List<V> value) {
    if (value.isEmpty) {
      node.isValue = true;
      return;
    }
    var path = _indexOf(value.first);
    value = value.sublist(1);

    if (node.children![path] == null) {
      node.children![path] = TrieNode(components);
    }

    _add(node.children![path]!, value);
  }

  bool _contains(TrieNode node, List<V> value) {
    if (value.isEmpty) {
      return node.isValue;
    }
    var path = _indexOf(value.first);
    value = value.sublist(1);

    if (node.children![path] != null) {
      return _contains(node.children![path]!, value);
    } else {
      return false;
    }
  }

  /// Traverses the path following [value] and marks
  ///  `node.isValue` to `false` at end. Deletes values eagerly i.e.
  ///  cleans up any parent nodes that are no longer necessary.
  TrieNode? _delete(TrieNode? node, List<V> value) {
    if (value.isEmpty) {
      // In case trie is empty and an empty value is passed.
      if (node == null) return null;

      node.isValue = false;

      // Checks all the children. If null, then deletes the node.
      var allNull = true;
      for (var child in node.children!) {
        if (child != null) {
          allNull = false;
          break;
        }
      }
      return allNull ? null : node;
    }

    // In case trie is empty and some value is passed.
    if (node == null) return null;

    var path = _indexOf(value.first);
    value = value.sublist(1);

    // Path to value doesn't exist.
    if (node.children![path] == null) {
      return node;
    }

    node.children![path] = _delete(node.children![path]!, value);

    // Delete node if all children are null.
    if (node.children![path] == null) {
      var allNull = true;
      for (var child in node.children!) {
        if (child != null) {
          allNull = false;
          break;
        }
      }
      return allNull ? null : node;
    }

    return node;
  }

  /// Returns index, which represents the [component] in `node.children`.
  int _indexOf(V component) => _components.indexOf(component);

  List _split(V value) {
    List<V> list = splitter(value);
    for (var component in list) {
      // TODO: Implement an error class instead.
      if (!components.contains(component)) throw ('$component ∉ $components');
    }
    return list;
  }
}

/// Node of the trie, has connection to the set of components as [children].
class TrieNode<V extends Comparable> {
  /// If this node represents a value in the trie.
  bool isValue = false;

  /// Connection to [children].
  List<TrieNode?>? children;

  /// Initializes the node to have as many [children]
  ///  as there are components in the trie.
  TrieNode(Set components)
      : children = List<TrieNode?>.filled(components.length, null);
}
