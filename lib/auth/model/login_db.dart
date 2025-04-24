import 'package:chart/config/db.dart';

Future<bool> confirmIdCheck(String email) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    'users',
    where: 'email = ?',
    whereArgs: [email],
  );

  return result.isNotEmpty;
}
