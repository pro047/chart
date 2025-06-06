import 'package:chart/model/datasource/therapist/therapist_todolist_datasource.dart';
import 'package:chart/model/model/therapist/data/therapist_todolist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodolistRepository {
  final TherapistTodolistDatasource _datasource;

  TherapistTodolistRepository(this._datasource);

  Future<List<TherapistTodolistModel>> getAllTodoListByUserId(
    int userId,
  ) async {
    try {
      return await _datasource.fetchAllTodoListByUserId(userId);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> saveTodoList(int userId, TherapistTodolistModel todoList) async {
    try {
      await _datasource.saveTodo(userId, todoList);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateTodoText(int userId, int todoId, String newText) async {
    try {
      await _datasource.updateTodo(
        userId: userId,
        todoId: todoId,
        newText: newText,
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateTodoDone(int userId, int todoId, bool isDone) async {
    try {
      await _datasource.updateTodo(
        userId: userId,
        todoId: todoId,
        isDone: isDone,
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updateTodoConfirm(int userId, int todoId, bool isConfirm) async {
    try {
      await _datasource.updateTodo(
        userId: userId,
        todoId: todoId,
        isConfirm: isConfirm,
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteTodo(int userId, int todoId) async {
    try {
      await _datasource.deleteTodo(userId, todoId);
    } catch (err) {
      rethrow;
    }
  }
}

final therapistTodoListRepositoryProvider = Provider((ref) {
  final datasource = ref.read(therapistTodolistDatasourceProvider);
  return TherapistTodolistRepository(datasource);
});
