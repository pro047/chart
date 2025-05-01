class TherapistTodolistModel {
  int id;
  String text;
  bool isDone;
  bool isConfirm;

  TherapistTodolistModel({
    int? id,
    required this.text,
    this.isDone = false,
    this.isConfirm = false,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toMap() => {
    'id': id,
    'text': text,
    'isDone': isDone,
    'isConfirm': isConfirm,
  };

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
        isDone: map['isDone'],
        isConfirm: map['isConfirm'],
      );
}
