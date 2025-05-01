import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chart/model/model/therapist/therapist_todolist_model.dart';

class TherapistTodolistDatasource {
  Future<List<TherapistTodolistModel>> decodedTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final storedList = prefs.getStringList('todoList') ?? [];
    return storedList
        .map((i) => TherapistTodolistModel.fromMap(jsonDecode(i)))
        .toList();
  }

  Future<void> encodedTodoList(List<TherapistTodolistModel> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedList = todoList.map((i) => jsonEncode(i.toMap())).toList();
    await prefs.setStringList('todoList', encodedList);
  }
}
