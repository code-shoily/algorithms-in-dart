# Algorithms in Dart

[![Build Status](https://github.com/code-shoily/algorithms-in-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/code-shoily/algorithms-in-dart/actions)

A collection of classical data structures and algorithms implemented in Dart.

## Algorithm Catalog

| Category | Algorithm / Data Structure | File | Notes |
|----------|---------------------------|------|-------|
| **Lists** | `SinglyLinkedList<T>` | [`lib/lists/singly_linked_list.dart`](lib/lists/singly_linked_list.dart) | Node-based list with append, insert, remove, peek |
| **Lists** | `DoublyLinkedList<T>` | [`lib/lists/doubly_linked_list.dart`](lib/lists/doubly_linked_list.dart) | Bidirectional links, head/tail operations |
| **Lists** | `CircularSinglyLinkedList<T>` | [`lib/lists/circular_singly_linked_list.dart`](lib/lists/circular_singly_linked_list.dart) | Singly linked with tail-to-head connection |
| **Lists** | `CircularDoublyLinkedList<T>` | [`lib/lists/circular_doubly_linked_list.dart`](lib/lists/circular_doubly_linked_list.dart) | Doubly linked with circular connections |
| **Lists** | `SortedLinkedList<T>` | [`lib/lists/sorted_linked_list.dart`](lib/lists/sorted_linked_list.dart) | Maintains ascending order on insert |
| **Lists** | `Stack<T>` | [`lib/lists/stack.dart`](lib/lists/stack.dart) | LIFO container |
| **Lists** | `Queue<T>` | [`lib/lists/queue.dart`](lib/lists/queue.dart) | FIFO container |
| **Heaps** | `MinHeap<T>` / `MaxHeap<T>` | [`lib/heaps/binary_heap.dart`](lib/heaps/binary_heap.dart) | Binary heap with `BinaryHeapIndex` mixin |
| **Heaps** | `HeapBase<T>` | [`lib/heaps/base.dart`](lib/heaps/base.dart) | Abstract base + `InvalidIndexError` |
| **Sorts** | Bubble Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n²) exchange sort |
| **Sorts** | Odd-Even Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | Parallelizable exchange sort |
| **Sorts** | Gnome Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | Single-pass swap-based sort |
| **Sorts** | Quick Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n log n) average divide-and-conquer |
| **Sorts** | Insertion Sort | [`lib/sorts/insertion.dart`](lib/sorts/insertion.dart) | O(n²) adaptive sort |
| **Sorts** | Selection Sort | [`lib/sorts/selection.dart`](lib/sorts/selection.dart) | O(n²) in-place comparison sort |
| **Sorts** | Heap Sort | [`lib/sorts/selection.dart`](lib/sorts/selection.dart) | O(n log n) in-place comparison sort |
| **Sorts** | Merge Sort | [`lib/sorts/merge.dart`](lib/sorts/merge.dart) | O(n log n) stable divide-and-conquer |
| **Sorts** | Pigeonhole Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n + range) integer sort |
| **Sorts** | Counting Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n + k) non-comparative integer sort |
| **Sorts** | Radix Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(nk) digit-by-digit integer sort |
| **Sorts** | Bucket Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n) average for uniform distributions |
| **Search** | Linear Search | [`lib/search/sequential.dart`](lib/search/sequential.dart) | O(n) sequential scan |
| **Search** | Binary Search | [`lib/search/interval.dart`](lib/search/interval.dart) | O(log n) on sorted lists |
| **Trees** | `BinarySearchTree<V>` | [`lib/trees/binary_search_tree.dart`](lib/trees/binary_search_tree.dart) | BST with add, delete, balance, traversals |
| **Trees** | `AvlTree<V>` | [`lib/trees/avl_tree.dart`](lib/trees/avl_tree.dart) | Self-balancing BST with rotations |
| **Trees** | `RedBlackTree<V>` | [`lib/trees/red_black_tree.dart`](lib/trees/red_black_tree.dart) | Self-balancing BST with color invariants |
| **Trees** | `ThreadedBinaryTree<V>` | [`lib/trees/threaded_binary_tree.dart`](lib/trees/threaded_binary_tree.dart) | Threaded pointers for stack-free traversal |
| **Trie** | `Trie<V>` | [`lib/trie/trie.dart`](lib/trie/trie.dart) | Prefix tree for string keys |
| **Graph** | `SimpleGraph<T>` | [`lib/graph/simple_graph.dart`](lib/graph/simple_graph.dart) | Digraph / undirected graph with weighted edges |
| **Graph** | `Vertex<T>` | [`lib/graph/vertex.dart`](lib/graph/vertex.dart) | Graph vertex with in/out connections |
| **Graph** | `Traversal` | [`lib/graph/traversal.dart`](lib/graph/traversal.dart) | Result ADT for graph traversals |
| **Graph** | BFS | [`lib/graph/bfs.dart`](lib/graph/bfs.dart) | Breadth-first search traversal |
| **Graph** | DFS | [`lib/graph/dfs.dart`](lib/graph/dfs.dart) | Depth-first search traversal |
| **Graph** | Dijkstra | [`lib/graph/dijkstra.dart`](lib/graph/dijkstra.dart) | Shortest path from source (non-negative weights) |
| **Graph** | Bellman-Ford | [`lib/graph/bellman_ford.dart`](lib/graph/bellman_ford.dart) | Shortest path (handles negative weights) |
| **Graph** | Topological Sort | [`lib/graph/topological_sort.dart`](lib/graph/topological_sort.dart) | Kahn's algorithm for DAGs |
| **Math** | GCD / LCM | [`lib/math/common.dart`](lib/math/common.dart) | Greatest common divisor & least common multiple |
| **Math** | Factorial | [`lib/math/common.dart`](lib/math/common.dart) | n! with integer arithmetic |
| **Helpers** | `NumRange` | [`lib/helpers/range.dart`](lib/helpers/range.dart) | `int.to(end)` extension for ranges |

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  algorithms:
    git: https://github.com/code-shoily/algorithms-in-dart.git
```

Then run:

```bash
dart pub get
```

## Usage

```dart
import 'package:algorithms/sorts/exchange.dart';
import 'package:algorithms/search/interval.dart';
import 'package:algorithms/trees/binary_search_tree.dart';

void main() {
  // Sorting
  var numbers = [64, 34, 25, 12, 22, 11, 90];
  print(quickSort(numbers)); // [11, 12, 22, 25, 34, 64, 90]

  // Searching
  print(binarySearch(numbers, 22)); // 4

  // BST
  var tree = BinarySearchTree<int>.fromList([11, -2, 1, 0, 21, 17]);
  print(tree.inOrder()); // [-2, 0, 1, 11, 17, 21]
}
```

## Development

### Running Tests

```bash
dart test
```

Run tests for a specific module:

```bash
dart test test/trees/avl_tree_test.dart
```

### Formatting & Analysis

```bash
dart format --output=none --set-exit-if-changed .
dart analyze
```

### Documentation

Generate API docs with:

```bash
dart doc
```
