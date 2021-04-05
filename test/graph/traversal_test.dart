import 'package:test/test.dart';

import 'package:algorithms/graph/traversal.dart';
import 'package:algorithms/graph/vertex.dart';

void main() {
  late Traversal hydratedTraversal;
  late Traversal emptyTraversal;
  late Vertex v, w, x, y, z;

  void _initializeVertices() {
    v = Vertex('V');
    w = Vertex('W');
    x = Vertex('X');
    y = Vertex('Y');
    z = Vertex('Z');
  }

  setUp(() {
    _initializeVertices();
    emptyTraversal = Traversal();
    hydratedTraversal = Traversal();
    for (var v in <Vertex>[x, y, z]) {
      hydratedTraversal.addVisit(v);
      hydratedTraversal.addVisited(v);
    }
  });

  test('Checks if traversal has a vertex that is visited', () {
    expect(hydratedTraversal.hasVisited(x), isTrue);
    expect(hydratedTraversal.hasVisited(y), isTrue);
    expect(hydratedTraversal.hasVisited(z), isTrue);
    expect(hydratedTraversal.hasVisited(v), isFalse);
    expect(hydratedTraversal.hasVisited(w), isFalse);
  });

  test('Add a visited vertex', () {
    expect(emptyTraversal.hasVisited(x), isFalse);
    expect(emptyTraversal.hasVisited(y), isFalse);
    emptyTraversal.addVisited(x);
    emptyTraversal.addVisited(y);
    expect(emptyTraversal.hasVisited(x), isTrue);
    expect(emptyTraversal.hasVisited(y), isTrue);
  });

  test('Add a vertex on the path', () {
    expect(emptyTraversal.visits, <Vertex>[]);
    emptyTraversal.addVisit(x);
    expect(emptyTraversal.visits, <Vertex>[x]);
    emptyTraversal.addVisit(y);
    expect(emptyTraversal.visits, <Vertex>[x, y]);

    expect(hydratedTraversal.visits, <Vertex>[x, y, z]);
    hydratedTraversal.addVisit(v);
    hydratedTraversal.addVisit(w);
    expect(hydratedTraversal.visits, <Vertex>[x, y, z, v, w]);
  });
}
