import 'package:chart/config/db.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/model/model/therapist/data/therapist_todolist_model.dart';
import 'package:sqflite/sql.dart';

class TherapistTodolistDatasource {
  Future<List<TherapistTodolistModel>> fetchAllTodoListByUserId(
    int userId,
  ) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'todos',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'created_at DESC',
      );
      print('fetch all todo datasource ${result.length} $userId');
      return result.map((e) => TherapistTodolistModel.fromMap(e)).toList();
    } catch (err) {
      throw Exception('fetch all todoList error id : $userId error : $err ');
    }
  }

  Future<void> saveTodo(int userId, TherapistTodolistModel todo) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert(
        'todos',
        todo.toMap(userId: userId),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    } catch (err) {
      throw Exception('save todo error : $err');
    }
  }

  Future<void> updateTodo({
    required int userId,
    required int todoId,
    String? newText,
    bool? isDone,
    bool? isConfirm,
  }) async {
    try {
      final db = await DatabaseHelper.instance.database;

      final Map<String, dynamic> updateField = {};

      if (newText != null) {
        updateField['text'] = newText;
      }

      if (isDone != null) {
        updateField['is_done'] = isDone ? 1 : 0;
      }

      if (isConfirm != null) {
        updateField['is_confirm'] = isConfirm ? 1 : 0;
      }

      await db.update(
        'todos',
        updateField,
        where: 'user_id = ? AND id = ?',
        whereArgs: [userId, todoId],
      );
    } catch (err) {
      throw Exception('update todo error : $err');
    }
  }

  Future<void> deleteTodo(int userId, int todoId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'todos',
        where: 'user_id = ? AND id = ?',
        whereArgs: [userId, todoId],
      );
    } catch (err) {
      throw Exception('delete todo error : $err');
    }
  }
}

final therapistTodolistDatasourceProvider = Provider(
  (ref) => TherapistTodolistDatasource(),
);
