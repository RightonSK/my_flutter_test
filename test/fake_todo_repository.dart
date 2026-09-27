import 'package:practice_flutter_test/todo.dart';
import 'package:practice_flutter_test/todo_repository.dart';

class FakeTodoRepository implements TodoRepository {
  final _data = <Todo>[];

  @override
  Future<List<Todo>> fetchAll() async => List.of(_data);

  @override
  Future<void> add(Todo todo) async => _data.add(todo);
}
