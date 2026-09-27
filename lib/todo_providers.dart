import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'todo.dart';
import 'todo_repository.dart';

// ① Repository を提供する Provider（DI コンテナの役割）
final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepositoryImpl(FirebaseFirestore.instance);
});

// ② ロジック本体。Repository（インターフェース）にだけ依存する
final todoListProvider = AsyncNotifierProvider<TodoListNotifier, List<Todo>>(
  TodoListNotifier.new,
);

class TodoListNotifier extends AsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() {
    return ref.watch(todoRepositoryProvider).fetchAll();
  }

  Future<void> add(String title) async {
    if (title.trim().isEmpty) {
      throw ArgumentError('タイトルを入力してください');
    }
    final todo = Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
    );
    await ref.read(todoRepositoryProvider).add(todo);
    ref.invalidateSelf(); // 再取得させる
    await future;
  }
}
