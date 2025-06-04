import 'package:chart/model/model/therapist/therapist_todolist_model.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final TherapistTodolistModel todo;
  final TextEditingController controller;
  final VoidCallback onConfirm;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onDoneChanged;

  const TodoItem({
    super.key,
    required this.todo,
    required this.controller,
    required this.onConfirm,
    required this.onEdit,
    required this.onDelete,
    required this.onDoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          todo.isConfirm
              ? Text(todo.text)
              : TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: '오늘의 일정을 작성해주세요'),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: onConfirm, icon: Icon(Icons.check)),
              IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
              Checkbox(value: todo.isDone, onChanged: (value) => onDoneChanged),
            ],
          ),
        ],
      ),
    );
  }
}
