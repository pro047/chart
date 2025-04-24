import 'package:chart/auth/model/datasource/signup_datasource.dart';
import 'package:chart/auth/model/model/signup_model.dart';

class SignupRepository {
  final SignupDatasource datasource = SignupDatasource();

  Future<int> signup(SignupModel signupModel) {
    return datasource.signup(signupModel);
  }
}
