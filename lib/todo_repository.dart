import 'package:cloud_firestore/cloud_firestore.dart';

import 'todo.dart';

// 契約：インターフェース：何ができるかだけ決め、処理は書かない
abstract interface class TodoRepository {
  Future<List<Todo>> fetchAll();
  Future<void> add(Todo todo);
}

class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._db);
  final FirebaseFirestore _db;

  @override
  Future<List<Todo>> fetchAll() async {
    final snapshot = await _db.collection('todos').get();
    return snapshot.docs
        .map(
          (doc) => Todo(
            id: doc.id,
            title: doc['title'] as String,
            isDone: doc['isDone'] as bool? ?? false,
          ),
        )
        .toList();
  }

  @override
  Future<void> add(Todo todo) async {
    await _db.collection('todos').doc(todo.id).set({
      'title': todo.title,
      'isDone': todo.isDone,
    });
  }
}
