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
    throw UnimplementedError();
  }

  @override
  Future<void> add(Todo todo) async {
    throw UnimplementedError();
  }
}
