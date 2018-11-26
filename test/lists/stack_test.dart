import 'package:algorithms_in_dart/lists/stack.dart';
import 'package:test/test.dart';

void main() {
  Stack<String> mcuHeroes;
  Stack<String> emptyStack;

  setUp(() {
    emptyStack = Stack();
    mcuHeroes = Stack()
      ..push("Iron Man")
      ..push("Captain America")
      ..push("Thor")
      ..push("Hulk");
  });

  test("Push increases the size and adds to the container", () {
    mcuHeroes.push("Ant-man");
    expect(mcuHeroes.size, equals(5));
    expect(mcuHeroes.peek(), equals("Ant-man"));
    mcuHeroes.push("Ben Affleck");
    //expect(mcuHeroes.peek(), equals("Martha"));
    expect(mcuHeroes.size, equals(6));
    expect(mcuHeroes.pop(), equals("Ben Affleck"));
  });
  test("Pop from empty list", () {
    try {
      emptyStack.pop();
    } catch (e) {
      expect(e, isNotNull);
    }
  });
  test("Pop decreases size and returns the top", () {
    expect(mcuHeroes.pop(), equals("Hulk"));
    expect(mcuHeroes.size, equals(3));
    expect(mcuHeroes.pop(), equals("Thor"));
    expect(mcuHeroes.size, equals(2));
    expect(mcuHeroes.pop(), equals("Captain America"));
    expect(mcuHeroes.size, equals(1));
    expect(mcuHeroes.pop(), equals("Iron Man"));
    expect(mcuHeroes.size, equals(0));
    expect(mcuHeroes.isEmpty, equals(true));
  });

  test("Peek an empty list", () {
    expect(emptyStack.peek(), equals(null));
  });

  test("Peek", () {
    expect(mcuHeroes.peek(), equals("Hulk"));
    expect(mcuHeroes.size, equals(4));
  });
}
