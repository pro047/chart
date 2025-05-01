import 'package:chart/view_model/therapist/therapist_name_view_model.dart';
import 'package:chart/view_model/therapist/therapist_todolist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistView extends ConsumerStatefulWidget {
  const TherapistView({super.key});

  @override
  ConsumerState<TherapistView> createState() => _TherapistViewState();
}

class _TherapistViewState extends ConsumerState<TherapistView> {
  // ignore: no_leading_underscores_for_local_identifiers

  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final therapistName = ref.watch(therapistNameViewModelProvider);
    final therapistTodo = ref.watch(
      therapistTodolistViewModelProvider.notifier,
    );
    final todoState = ref.watch(therapistTodolistViewModelProvider);

    // ignore: avoid_unnecessary_containers
    return Scaffold(
      appBar: AppBar(title: Text('therapist')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('${therapistName.value} 치료사님 안녕하세요'),
            Text('오늘 해야 할 일은 어떤건가요?'),
            IconButton(
              onPressed: therapistTodo.addTodoList,
              icon: Icon(Icons.add),
            ),
            todoState.when(
              data:
                  (todoList) => Expanded(
                    child: Builder(
                      builder: (context) {
                        final ids = todoList.map((i) => i.id).toSet();
                        // ignore: no_leading_underscores_for_local_identifiers
                        final _controllersIds = _controllers.keys.toSet();
                        for (final id in ids.difference(_controllersIds)) {
                          final todo = todoList.firstWhere((i) => i.id == id);
                          _controllers[id] = TextEditingController(
                            text: todo.text,
                          );
                        }
                        for (final id in _controllersIds.difference(ids)) {
                          _controllers.remove(id)?.dispose();
                        }
                        return ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context, int index) {
                            final todo = todoList[index];
                            final id = todo.id;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                children: [
                                  todo.isConfirm
                                      ? Text(todo.text)
                                      : TextField(
                                        controller: _controllers[id],
                                        decoration: InputDecoration(
                                          hintText: 'to do',
                                        ),
                                      ),
                                  SizedBox(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            therapistTodo.updateTodoText(
                                              id,
                                              _controllers[id]!.text,
                                            );
                                            therapistTodo.updateTodoConfirm(
                                              id,
                                              true,
                                            );
                                          },
                                          icon: Icon(Icons.check),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            therapistTodo.updateTodoConfirm(
                                              id,
                                              false,
                                            );
                                            therapistTodo.updateTodoText(
                                              id,
                                              _controllers[id]!.text,
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            therapistTodo.deleteTodoByID(id);
                                            setState(() {
                                              _controllers
                                                  .remove(id)
                                                  ?.dispose();
                                            });
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                        Checkbox(
                                          value: todo.isDone,
                                          onChanged: (bool? value) {
                                            therapistTodo.updateTodoDone(
                                              id,
                                              value!,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('error: $e')),
            ),
          ],
        ),
      ),
    );
  }
}
