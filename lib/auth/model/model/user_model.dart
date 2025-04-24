class UserModel {
  int id;
  String email;
  String name;

  UserModel({required this.id, required this.email, required this.name});

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModel(id: map['id'], email: map['email'], name: map['name']);
}
