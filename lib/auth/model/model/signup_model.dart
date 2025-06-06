import 'package:chart/config/hash_password.dart';

class SignupModel {
  String email;
  String password;
  String name;
  String? hostpital;

  SignupModel({
    required this.email,
    required this.password,
    required this.name,
    this.hostpital,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': convertHash(password),
    'name': name,
    'hospital': hostpital,
  };
}
