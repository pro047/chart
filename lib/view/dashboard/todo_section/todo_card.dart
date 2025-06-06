import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/view/dashboard/todo_section/todo_item.dart';
import 'package:chart/view_model/therapist/data/therapist_todolist_view_model.dart';
import 'package:chart/view_model/therapist/ui/therapist_todolist_ui_view_model.dart';

class TherapistTodoCard extends ConsumerWidget {
  const TherapistTodoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.read(authStateProvider).user?.id;
    if (userId == null) return const SizedBox.shrink();

    final todoState = ref.watch(therapistTodolistViewModelProvider(userId));
    final todoVm = ref.read(
      therapistTodolistViewModelProvider(userId).notifier,
    );

    final todoUiState = ref.watch(therapistTodolistUiViewModelProvider);
    final todoUiVm = ref.read(therapistTodolistUiViewModelProvider.notifier);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                todoUiVm.toggleIsAdding();
                print(todoUiState.isAdding);
              },
              icon: todoUiState.isAdding == true
                  ? Icon(Icons.delete)
                  : Icon(Icons.add),
            ),

            if (todoUiState.isAdding)
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      onChanged: (value) {
                        todoUiVm.updateNewTodoText(value);
                      },
                      decoration: InputDecoration(hintText: '새로운 일정을 작성해주세요'),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await todoVm.addTodo(todoUiState.newTodoText);
                      todoUiVm.reset();
                    },
                    icon: Icon(Icons.check),
                  ),
                ],
              ),

            todoState.when(
              data: (todoList) {
                todoList.isEmpty
                    ? ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: Colors.grey[100],
                        title: Center(child: Text('최근 일정이 없습니다')),
                      )
                    : todoUiVm.syncControllers(todoList);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todoList.length,
                  itemBuilder: (_, index) {
                    final todo = todoList[index];
                    final controller = todoUiVm.controllers[todo.id];
                    if (controller == null) return SizedBox.shrink();
                    return TodoItem(
                      key: ValueKey(todo.id),
                      todo: todo,
                      controller: todoUiVm.controllers[todo.id]!,
                      onConfirm: () {
                        todoVm.updateTodoText(
                          todo.id,
                          todoUiState.controllers[todo.id]!.text,
                        );
                        todoVm.updateTodoConfirm(todo.id, true);
                      },
                      onEdit: () {
                        todoVm.updateTodoConfirm(todo.id, false);
                        todoVm.updateTodoText(
                          todo.id,
                          todoUiState.controllers[todo.id]!.text,
                        );
                      },
                      onDelete: () {
                        todoVm.deleteTodo(todo.id);
                        todoUiVm.dispostControllers(todo.id);
                      },
                      onDoneChanged: (value) {
                        print('value : $value');
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
}
