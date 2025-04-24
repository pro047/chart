import 'package:chart/config/hash_password.dart';

class SignupModel {
  String email;
  String password;
  String name;

  SignupModel({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': convertHash(password),
    'name': name,
  };
}
