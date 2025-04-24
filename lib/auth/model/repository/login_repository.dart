import 'package:chart/auth/model/datasource/login_datasource.dart';
import 'package:chart/auth/model/model/user_model.dart';

class LoginRepository {
  final LoginDatasource datasource = LoginDatasource();

  Future<UserModel> login(email, password) {
    return datasource.login(email, password);
  }
}
