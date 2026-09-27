import 'package:flutter_test/flutter_test.dart';
import 'package:practice_flutter_test/todo.dart';

void main() {
  group('Todo', () {
    test('初期状態は未完了', () {
      const todo = Todo(id: '1', title: '牛乳を買う');
      expect(todo.isDone, false);
    });

    test('toggle で完了/未完了が反転する', () {
      const todo = Todo(id: '1', title: '牛乳を買う');
      expect(todo.toggle().isDone, true);
      expect(todo.toggle().toggle().isDone, false);
    });
  });
}
