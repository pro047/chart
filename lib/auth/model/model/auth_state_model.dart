import 'package:chart/auth/model/model/user_model.dart';

class AuthStateModel {
  final bool isLoggedIn;
  final UserModel? user;

  AuthStateModel({required this.isLoggedIn, required this.user});
}
