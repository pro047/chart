import 'package:flutter/cupertino.dart';

class TodoUiState {
  final bool isAdding;
  final String newTodoText;
  final Map<int, TextEditingController> controllers;

  const TodoUiState({
    this.isAdding = false,
    this.newTodoText = '',
    this.controllers = const {},
  });

  TodoUiState copyWith({
    bool? isAdding,
    String? newTodoText,
    Map<int, TextEditingController>? controllers,
  }) {
    return TodoUiState(
      isAdding: isAdding ?? this.isAdding,
      newTodoText: newTodoText ?? this.newTodoText,
      controllers: controllers ?? this.controllers,
    );
  }
}
