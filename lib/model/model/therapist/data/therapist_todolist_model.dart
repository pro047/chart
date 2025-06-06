class TherapistTodolistModel {
  int id;
  String text;
  bool isDone;
  bool isConfirm;

  TherapistTodolistModel({
    required this.id,
    required this.text,
    this.isDone = false,
    this.isConfirm = false,
  });

  factory TherapistTodolistModel.newTodo({
    required String text,
    bool isConfirm = false,
  }) {
    return TherapistTodolistModel(id: -1, text: text, isConfirm: isConfirm);
  }

  Map<String, dynamic> toMap({required int userId}) {
    final map = <String, dynamic>{
      'user_id': userId,
      'text': text,
      'is_done': isDone ? 1 : 0,
      'is_confirm': isConfirm ? 1 : 0,
    };

    if (id != -1) {
      map['id'] = id;
    }
    return map;
  }

  TherapistTodolistModel copyWith({
    int? id,
    String? text,
    bool? isDone,
    bool? isConfirm,
  }) {
    return TherapistTodolistModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
      isConfirm: isConfirm ?? this.isConfirm,
    );
  }

  factory TherapistTodolistModel.fromMap(Map<String, dynamic> map) =>
      TherapistTodolistModel(
        id: map['id'],
        text: map['text'],
        isDone: map['is_done'] == 1,
        isConfirm: map['is_confirm'] == 1,
      );
}
