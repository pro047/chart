import 'dart:async';
import 'package:chart/model/model/therapist/data/therapist_todolist_model.dart';
import 'package:chart/model/repository/therapist/therapist_todolist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodolistViewModel
    extends FamilyAsyncNotifier<List<TherapistTodolistModel>, int> {
  TherapistTodolistRepository get _repository =>
      ref.read(therapistTodoListRepositoryProvider);

  @override
  Future<List<TherapistTodolistModel>> build(int userId) async {
    print('fetch all todo viewmodel $userId');
    return await _repository.getAllTodoListByUserId(userId);
  }

  Future<void> addTodo(String text) async {
    try {
      final userId = arg;
      final todo = TherapistTodolistModel.newTodo(text: text, isConfirm: true);
      print('todo : ${todo.isConfirm}, ${todo.text}');
      await _repository.saveTodoList(userId, todo);
      state = AsyncData(await _repository.getAllTodoListByUserId(userId));
    } catch (err, st) {
      AsyncError(err, st);
    }
  }

  Future<void> updateTodoText(int todoId, String newText) async {
    try {
      final userId = arg;
      await _repository.updateTodoText(userId, todoId, newText);
      state = AsyncData(await _repository.getAllTodoListByUserId(userId));
    } catch (err, st) {
      AsyncError(err, st);
    }
  }

  Future<void> updateTodoDone(int todoId, bool isDone) async {
    try {
      final userId = arg;
      print('updatetodoDone : $isDone');
      await _repository.updateTodoDone(userId, todoId, isDone);
      state = AsyncData(await _repository.getAllTodoListByUserId(userId));
      print('update success state: $state');
    } catch (err, st) {
      AsyncError(err, st);
    }
  }

  Future<void> updateTodoConfirm(int todoId, bool isConfirm) async {
    try {
      final userId = arg;
      await _repository.updateTodoConfirm(userId, todoId, isConfirm);
      state = AsyncData(await _repository.getAllTodoListByUserId(userId));
    } catch (err, st) {
      AsyncError(err, st);
    }
  }

  Future<void> deleteTodo(int todoId) async {
    try {
      final userId = arg;
      await _repository.deleteTodo(userId, todoId);
      state = AsyncData(await _repository.getAllTodoListByUserId(userId));
    } catch (err, st) {
      AsyncError(err, st);
    }
  }
}

final therapistTodolistViewModelProvider =
    AsyncNotifierProvider.family<
      TherapistTodolistViewModel,
      List<TherapistTodolistModel>,
      int
    >(TherapistTodolistViewModel.new);
