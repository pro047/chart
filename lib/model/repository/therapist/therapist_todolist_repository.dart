import 'package:chart/model/datasource/therapist/therapist_todolist_datasource.dart';
import 'package:chart/model/model/therapist/therapist_todolist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistTodolistRepository {
  final TherapistTodolistDatasource _datasource;

  TherapistTodolistRepository(this._datasource);

  Future<List<TherapistTodolistModel>> getTodoList(int userId) async {
    return _datasource.decodedTodoList();
  }

  Future<void> saveTodoList(List<TherapistTodolistModel> todoList) async {
    return _datasource.encodedTodoList(todoList);
  }
}

final therapistTodoListRepositoryProvider = Provider((ref) {
  final datasource = ref.read(therapistTodolistDatasourceProvider);
  return TherapistTodolistRepository(datasource);
});
