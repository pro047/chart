import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/model/model/therapist/therapist_todolist_model.dart';
import 'package:chart/view/dashboard/todo_section/todo_item.dart';
import 'package:chart/view_model/dashboard/therapist_todolist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodoCard extends ConsumerStatefulWidget {
  const TherapistTodoCard({super.key});

  @override
  ConsumerState<TherapistTodoCard> createState() => _TherapistTodoCardState();
}

class _TherapistTodoCardState extends ConsumerState<TherapistTodoCard> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    super.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.read(authStateProvider).user?.id;
    if (userId == null) return const SizedBox.shrink();

    final todoState = ref.watch(therapistTodolistViewModelProvider(userId));
    final todoVm = ref.read(
      therapistTodolistViewModelProvider(userId).notifier,
    );
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: todoVm.addTodoList, icon: Icon(Icons.add)),
            todoState.when(
              data: (todoList) {
                _syncControllers(todoList);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todoList.length,
                  itemBuilder: (_, index) {
                    final todo = todoList[index];
                    final controller = _controllers[todo.id];
                    if (controller == null) return SizedBox.shrink();
                    return TodoItem(
                      todo: todo,
                      controller: _controllers[todo.id]!,
                      onConfirm: () {
                        todoVm.updateTodoText(
                          todo.id,
                          _controllers[todo.id]!.text,
                        );
                        todoVm.updateTodoConfirm(todo.id, true);
                      },
                      onEdit: () {
                        todoVm.updateTodoConfirm(todo.id, false);
                        todoVm.updateTodoText(
                          todo.id,
                          _controllers[todo.id]!.text,
                        );
                      },
                      onDelete: () {
                        todoVm.deleteTodoByID(todo.id);
                        setState(() {
                          _controllers.remove(todo.id)?.dispose();
                        });
                      },
                      onDoneChanged: (value) {
                        todoVm.updateTodoDone(todo.id, value);
                      },
                    );
                  },
                );
              },
              error: (e, _) => Center(child: Text('에러 발생 $e')),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  void _syncControllers(List<TherapistTodolistModel> list) {
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
}
