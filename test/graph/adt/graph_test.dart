import 'package:algorithms_in_dart/graph/adt/node.dart';
import 'package:test/test.dart';

import 'package:algorithms_in_dart/graph/adt/graph.dart';

void main() {
  Graph simpleGraph;

  setUp(() {
    /*    b -4- c            
         /      | 
        a <-2-< d 
         \      
          f -7- e 
    */
    simpleGraph = Graph();

    var a = Vertex('a');
    var b = Vertex('b');
    var c = Vertex('c');
    var d = Vertex('d');
    var e = Vertex('e');
    var f = Vertex('f');

    simpleGraph.addEdge(a, b);
    simpleGraph.addEdge(a, f);
    simpleGraph.addEdge(b, c, 4);
    simpleGraph.addEdge(d, a, 2);
    simpleGraph.addEdge(f, e, 7);
    simpleGraph.addEdge(c, d);
  });
}
