# Algorithms in Dart

Implementation of several algorithms with Dart programming language.

I will be implementing algorithms (In random order, perhaps) with Dart as I am learning this simple language. This readme will be updated with each implementation.

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

`lib/sorts/distribution.dart` - `Pigeonhole Sort`, `Counting Sort`

`lib/sorts/merge.dart` - `Merge Sort`

## Searching

`lib/search/sequential.dart` - `Linear Search`

`lib/search/interval.dart` - `Binary Search`

## Trees

### Binary Tree

`lib/trees/binary.dart`
