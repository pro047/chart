import 'package:chart/model/model/therapist/data/therapist_todolist_model.dart';
import 'package:chart/model/model/therapist/ui/therapist_todolist_ui_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodolistUiViewModel extends StateNotifier<TodoUiState> {
  TherapistTodolistUiViewModel() : super(const TodoUiState());

  final Map<int, TextEditingController> _controllers = {};

  void toggleIsAdding() {
    state = state.copyWith(isAdding: !state.isAdding);
  }

  void updateNewTodoText(String text) {
    state = state.copyWith(newTodoText: text);
  }

  void reset() {
    state = const TodoUiState();
  }

  void syncControllers(List<TherapistTodolistModel> list) {
    final ids = list.map((e) => e.id).toSet();
    final controllersIds = _controllers.keys.toSet();

    for (final id in ids.difference(controllersIds)) {
      final text = list.firstWhere((e) => e.id == id).text;
      _controllers[id] = TextEditingController(text: text);
    }
    for (final id in controllersIds.difference(ids)) {
      _controllers.remove(id)?.dispose();
    }
  }

  Map<int, TextEditingController> get controllers => _controllers;

  void dispostControllers(int id) {
    _controllers.remove(id)?.dispose();
  }
}

final therapistTodolistUiViewModelProvider =
    StateNotifierProvider<TherapistTodolistUiViewModel, TodoUiState>(
      (ref) => TherapistTodolistUiViewModel(),
    );
