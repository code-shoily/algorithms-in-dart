import 'package:test/test.dart';

import 'package:algorithms/graph/simple_graph.dart';
import 'package:algorithms/graph/topological_sort.dart';
import 'package:algorithms/graph/vertex.dart';

void main() {
  late SimpleGraph emptyGraph, singleGraph, graph;
  late Vertex a, b, c, d, e, f, g, h, i, j, k, x, y;

  void _initializeVertex() {
    a = Vertex('A');
    b = Vertex('B');
    c = Vertex('C');
    d = Vertex('D');
    e = Vertex('E');
    f = Vertex('F');
    g = Vertex('G');
    h = Vertex('H');
    i = Vertex('I');
    j = Vertex('J');
    k = Vertex('K');
    x = Vertex('X');
    y = Vertex('Y');
  }

  setUp(() {
    _initializeVertex();
    emptyGraph = SimpleGraph(isDigraph: true);
    graph = SimpleGraph(isDigraph: true);
    /*
      (a) -> (b) -> (c) -> (f) <- (h)
       |      |        (i)
      _|     _|      _/   \_
      (d) -> (e) -> (g)   (j) <- (k)
    */
    graph.addEdge(a, b);
    graph.addEdge(b, c);
    graph.addEdge(c, f);
    graph.addEdge(h, f);
    graph.addEdge(a, d);
    graph.addEdge(b, e);
    graph.addEdge(d, e);
    graph.addEdge(e, g);
    graph.addEdge(i, g);
    graph.addEdge(i, j);
    graph.addEdge(k, j);

    singleGraph = SimpleGraph();
    singleGraph.addEdge(x, y);
  });

  test('Get in degrees', () {
    var expectedInDegrees = <Vertex, int>{
      a: 0,
      b: 1,
      c: 1,
      d: 1,
      e: 2,
      f: 2,
      g: 2,
      h: 0,
      i: 0,
      j: 2,
      k: 0,
    };
    expect(inDegrees(emptyGraph), isEmpty);
    expect(inDegrees(graph), equals(expectedInDegrees));
  });

  test('Test topological sort using Kahn', () {
    expect(topologicalSort(emptyGraph), isEmpty);
    expect(
        topologicalSort(singleGraph),
        anyOf([
          <Vertex>[x, y],
          <Vertex>[y, x]
        ]));
    var expectedSort = <Set<Vertex>>[
      {a, h, i, k},
      {d, b, j},
      {c, e},
      {f, g}
    ];
    var sortedList = topologicalSort(graph)!;
    var actualSort = [
      {...sortedList.sublist(0, 4)},
      {...sortedList.sublist(4, 7)},
      {...sortedList.sublist(7, 9)},
      {...sortedList.sublist(9, 11)}
    ];

    expect(actualSort, equals(expectedSort));
  });

  test('Test topological sort fails on cycle', () {
    graph.addEdge(j, k);
    expect(topologicalSort(graph), isNull);
  });

  test('Topological sort fails on undirected graph', () {
    var unDirectedGraph = SimpleGraph(isDigraph: false);
    unDirectedGraph.addEdge(Vertex('A'), Vertex('B'));
    expect(topologicalSort(unDirectedGraph), isNull);
  });
}
