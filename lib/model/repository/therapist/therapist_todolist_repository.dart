import 'package:chart/model/datasource/therapist/therapist_todolist_datasource.dart';
import 'package:chart/model/model/therapist/therapist_todolist_model.dart';

class TherapistTodolistRepository {
  final TherapistTodolistDatasource _datasource = TherapistTodolistDatasource();

  Future<List<TherapistTodolistModel>> getTodoList() async {
    return _datasource.decodedTodoList();
  }

  Future<void> saveTodoList(List<TherapistTodolistModel> todoList) async {
    return _datasource.encodedTodoList(todoList);
  }
}
