// ignore_for_file: avoid_print

import 'package:chart/auth/model/model/user_model.dart';
import 'package:chart/config/db.dart';
import 'package:chart/config/hash_password.dart';

class LoginDatasource {
  Future<UserModel> login(email, password) async {
    final db = await DatabaseHelper.instance.database;
    final hash = convertHash(password);
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hash],
    );

    if (result.isNotEmpty) {
      print('result: $result');
      print('result first: ${result.first}');
      return UserModel.fromMap(result.first);
    } else {
      throw Exception('Invalid exception');
    }
  }
}
