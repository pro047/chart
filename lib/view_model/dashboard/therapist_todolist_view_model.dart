import 'dart:async';
import 'package:chart/model/model/therapist/therapist_todolist_model.dart';
import 'package:chart/model/repository/therapist/therapist_todolist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodolistViewModel
    extends FamilyAsyncNotifier<List<TherapistTodolistModel>, int> {
  TherapistTodolistRepository get _repository =>
      ref.read(therapistTodoListRepositoryProvider);

  @override
  Future<List<TherapistTodolistModel>> build(int userId) async {
    return await _repository.getTodoList(userId);
  }

  Future<void> addTodoList() async {
    final newId =
        (state.value!
            .map((i) => i.id)
            .fold<int>(0, (prev, next) => prev > next ? prev : next) +
        1);
    final newList = [
      ...state.value!,
      TherapistTodolistModel(id: newId, text: ''),
    ];
    state = AsyncData(newList);
    _repository.saveTodoList(newList);
  }

  Future<void> updateTodoText(int id, String newText) async {
    final updatedList = state.value!
        .map((todo) => todo.id == id ? todo.copyWith(text: newText) : todo)
        .toList();

    state = AsyncData(updatedList);
    _repository.saveTodoList(updatedList);
  }

  Future<void> deleteTodoByID(int id) async {
    final deletedList = state.value!.where((todo) => todo.id != id).toList();
    state = AsyncData(deletedList);
    _repository.saveTodoList(deletedList);
  }

  Future<void> updateTodoConfirm(int id, bool isConfirm) async {
    final confirmTodo = state.value!
        .map(
          (todo) => todo.id == id ? todo.copyWith(isConfirm: isConfirm) : todo,
        )
        .toList();
    state = AsyncData(confirmTodo);
    _repository.saveTodoList(confirmTodo);
  }

  Future<void> updateTodoDone(int id, bool isDone) async {
    final doneTodo = state.value!
        .map((todo) => todo.id == id ? todo.copyWith(isDone: isDone) : todo)
        .toList();
    state = AsyncData(doneTodo);
    _repository.saveTodoList(doneTodo);
  }
}

final therapistTodolistViewModelProvider =
    AsyncNotifierProvider.family<
      TherapistTodolistViewModel,
      List<TherapistTodolistModel>,
      int
    >(() {
      return TherapistTodolistViewModel();
    });
