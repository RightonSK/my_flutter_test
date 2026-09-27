import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice_flutter_test/todo_providers.dart';

import 'fake_todo_repository.dart';

void main() {
  late FakeTodoRepository repository;
  late ProviderContainer container;

  // 各テストの前に、新しい Fake と Container を作り直す
  setUp(() {
    repository = FakeTodoRepository();
    container = ProviderContainer.test(
      overrides: [
        todoRepositoryProvider.overrideWithValue(repository), // ← 差し替え
      ],
    );
  });

  test('最初は空', () async {
    final todos = await container.read(todoListProvider.future);
    expect(todos, isEmpty);
  });

  test('add するとリストに追加される', () async {
    await container.read(todoListProvider.future);
    await container.read(todoListProvider.notifier).add('牛乳を買う');

    final todos = await container.read(todoListProvider.future);
    expect(todos.map((t) => t.title), ['牛乳を買う']);
  });

  test('空のタイトルは ArgumentError', () async {
    await container.read(todoListProvider.future);
    await expectLater(
      container.read(todoListProvider.notifier).add(''),
      throwsA(isA<ArgumentError>()),
    );
  });
}
