# Algorithms in Dart

[![Dart CI](https://github.com/code-shoily/algorithms-in-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/code-shoily/algorithms-in-dart/actions)
[![Dart Version](https://img.shields.io/badge/dart-%3E%3D3.0.0-0175C2?logo=dart)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of classical data structures and algorithms implemented in Dart.

## Lists

| Data Structure | File | Notes |
|----------------|------|-------|
| `SinglyLinkedList<T>` | [`lib/lists/singly_linked_list.dart`](lib/lists/singly_linked_list.dart) | Node-based list with append, insert, remove, peek |
| `DoublyLinkedList<T>` | [`lib/lists/doubly_linked_list.dart`](lib/lists/doubly_linked_list.dart) | Bidirectional links, head/tail operations |
| `CircularSinglyLinkedList<T>` | [`lib/lists/circular_singly_linked_list.dart`](lib/lists/circular_singly_linked_list.dart) | Singly linked with tail-to-head connection |
| `CircularDoublyLinkedList<T>` | [`lib/lists/circular_doubly_linked_list.dart`](lib/lists/circular_doubly_linked_list.dart) | Doubly linked with circular connections |
| `SortedLinkedList<T>` | [`lib/lists/sorted_linked_list.dart`](lib/lists/sorted_linked_list.dart) | Maintains ascending order on insert |
| `Stack<T>` | [`lib/lists/stack.dart`](lib/lists/stack.dart) | LIFO container |
| `Queue<T>` | [`lib/lists/queue.dart`](lib/lists/queue.dart) | FIFO container |

## Heaps

| Data Structure | File | Notes |
|----------------|------|-------|
| `MinHeap<T>` / `MaxHeap<T>` | [`lib/heaps/binary_heap.dart`](lib/heaps/binary_heap.dart) | Binary heap with `BinaryHeapIndex` mixin |
| `HeapBase<T>` | [`lib/heaps/base.dart`](lib/heaps/base.dart) | Abstract base + `InvalidIndexError` |

## Sorts

| Algorithm | File | Complexity | Notes |
|-----------|------|------------|-------|
| Bubble Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n²) | Exchange sort |
| Odd-Even Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n²) | Parallelizable exchange sort |
| Gnome Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n²) | Single-pass swap-based sort |
| Quick Sort | [`lib/sorts/exchange.dart`](lib/sorts/exchange.dart) | O(n log n) avg | Divide-and-conquer |
| Insertion Sort | [`lib/sorts/insertion.dart`](lib/sorts/insertion.dart) | O(n²) | Adaptive sort |
| Selection Sort | [`lib/sorts/selection.dart`](lib/sorts/selection.dart) | O(n²) | In-place comparison sort |
| Heap Sort | [`lib/sorts/selection.dart`](lib/sorts/selection.dart) | O(n log n) | In-place comparison sort |
| Merge Sort | [`lib/sorts/merge.dart`](lib/sorts/merge.dart) | O(n log n) | Stable divide-and-conquer |
| Pigeonhole Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n + range) | Integer sort |
| Counting Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n + k) | Non-comparative integer sort |
| Radix Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(nk) | Digit-by-digit integer sort |
| Bucket Sort | [`lib/sorts/distribution.dart`](lib/sorts/distribution.dart) | O(n) avg | For uniform distributions |

## Search

| Algorithm | File | Complexity | Notes |
|-----------|------|------------|-------|
| Linear Search | [`lib/search/sequential.dart`](lib/search/sequential.dart) | O(n) | Sequential scan |
| Binary Search | [`lib/search/interval.dart`](lib/search/interval.dart) | O(log n) | Requires sorted input |

## Trees

| Data Structure | File | Notes |
|----------------|------|-------|
| `BinarySearchTree<V>` | [`lib/trees/binary_search_tree.dart`](lib/trees/binary_search_tree.dart) | BST with add, delete, balance, traversals |
| `AvlTree<V>` | [`lib/trees/avl_tree.dart`](lib/trees/avl_tree.dart) | Self-balancing BST with rotations |
| `RedBlackTree<V>` | [`lib/trees/red_black_tree.dart`](lib/trees/red_black_tree.dart) | Self-balancing BST with color invariants |
| `ThreadedBinaryTree<V>` | [`lib/trees/threaded_binary_tree.dart`](lib/trees/threaded_binary_tree.dart) | Threaded pointers for stack-free traversal |
| `BTree<V>` | [`lib/trees/b_tree.dart`](lib/trees/b_tree.dart) | Multi-way search tree with configurable degree |
| `BPlusTree<V>` | [`lib/trees/b_plus_tree.dart`](lib/trees/b_plus_tree.dart) | B+ Tree with linked leaves for fast range scans |

## Trie

| Data Structure | File | Notes |
|----------------|------|-------|
| `Trie<V>` | [`lib/trie/trie.dart`](lib/trie/trie.dart) | Prefix tree for string keys |
| `RadixTree` | [`lib/trie/radix_tree.dart`](lib/trie/radix_tree.dart) | Compressed trie with string edge labels |

## Graph

| Algorithm / Structure | File | Notes |
|-----------------------|------|-------|
| `SimpleGraph<T>` | [`lib/graph/simple_graph.dart`](lib/graph/simple_graph.dart) | Digraph / undirected graph with weighted edges |
| `Vertex<T>` | [`lib/graph/vertex.dart`](lib/graph/vertex.dart) | Graph vertex with in/out connections |
| `Traversal` | [`lib/graph/traversal.dart`](lib/graph/traversal.dart) | Result ADT for graph traversals |
| BFS | [`lib/graph/bfs.dart`](lib/graph/bfs.dart) | Breadth-first search traversal |
| DFS | [`lib/graph/dfs.dart`](lib/graph/dfs.dart) | Depth-first search traversal |
| Dijkstra | [`lib/graph/dijkstra.dart`](lib/graph/dijkstra.dart) | Shortest path from source (non-negative weights) |
| Bellman-Ford | [`lib/graph/bellman_ford.dart`](lib/graph/bellman_ford.dart) | Shortest path (handles negative weights) |
| Topological Sort | [`lib/graph/topological_sort.dart`](lib/graph/topological_sort.dart) | Kahn's algorithm for DAGs |

## Math

| Algorithm | File | Notes |
|-----------|------|-------|
| GCD / LCM | [`lib/math/common.dart`](lib/math/common.dart) | Greatest common divisor & least common multiple |
| Factorial | [`lib/math/common.dart`](lib/math/common.dart) | n! with integer arithmetic |

## Helpers

| Utility | File | Notes |
|---------|------|-------|
| `NumRange` | [`lib/helpers/range.dart`](lib/helpers/range.dart) | `int.to(end)` extension for ranges |

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
