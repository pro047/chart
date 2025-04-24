import 'package:chart/auth/model/model/signup_model.dart';
import 'package:chart/config/db.dart';

class SignupDatasource {
  Future<int> signup(SignupModel signupModel) async {
    final db = await DatabaseHelper.instance.database;
    final userInfo = signupModel.toJson();
    final result = await db.insert('users', userInfo);
    print('signup result: $result');
    return result;
  }
}
