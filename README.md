# Algorithms in Dart

[![Build Status](https://github.com/code-shoily/algorithms-in-dart/actions/workflows/dart.yml/badge.svg)](https://github.com/code-shoily/algorithms-in-dart/actions)

Implementation of several algorithms with Dart programming language.

Use `dartdoc` to generate documentation.

## Lists

List data structures are implemented under the package `lists`.

### SinglyLinkedList

`lib/lists/singly_linked_list.dart`

### DoublyLinkedList

`lib/lists/doubly_linked_list.dart`

### CircularLinkedList

`lib/lists/circular_singly_linked_list.dart` and `lib/lists/circular_doubly_linked_list.dart`

### Stack

`lib/lists/stack.dart`

### Queue

`lib/lists/queue.dart`

## Heaps

### BinaryHeap

All base classes are in `lib/heaps/base.dart`

`lib/heaps/binary_heap.dart` - `BinaryHeap`, `MinHeap` and `MaxHeap`

## Sorts

`lib/sorts/common.dart` contains helper functions and typedefs for sorting algorithms.

`lib/sorts/exchange.dart` - `Bubble Sort`, `Odd-Even Sort`, `Gnome Sort`, `Quick Sort`

`lib/sorts/insertion.dart` - `Insertion Sort`

`lib/sorts/selection.dart` - `Heap Sort`, `Selection Sort`

`lib/sorts/distribution.dart` - `Pigeonhole Sort`, `Counting Sort`, `Radix Sort`

`lib/sorts/merge.dart` - `Merge Sort`

## Searching

`lib/search/sequential.dart` - `Linear Search`

`lib/search/interval.dart` - `Binary Search`

## Trees

### Binary Search Tree

`lib/trees/binary_search_tree.dart`

### AVL Tree

`lib/trees/avl_tree.dart`

### Red Black Tree

`lib/trees/red_black_tree.dart `

## Math

`lib/math/common.dart` - `GCD`, `LCM`, `Factorial`

## Graph

### ADT

`lib/graph/graph.dart` - `Graph` ADT

`lib/graph/vertex.dart` - `Vertex`

`lib/graph/traversal.dart` - `Traversal` ADT to represent graph traversal
results.

### Traversals

`lib/graph/dfs.dart` - Algorithm for DFS traversal on graphs.

`lib/graph/bfs.dart` - Algorithm for BFS traversal on graphs.

### Graph Paths

`lib/graph/topological_sort.dart` - Topological sort on acyclic digraphs.

`lib/graph/bellman_ford.dart` - Bellman Ford Algorithm

`lib/graph/dijkstra.dart` - Dijkstra's algorithm
