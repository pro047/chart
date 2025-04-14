import 'package:chart/config/hash_password.dart';
import 'package:chart/config/my_sql_connector.dart';
import 'package:mysql_client/mysql_client.dart';

Future<void> insertMember(String userName, String password, String name) async {
  final conn = await dbConnector();
  final hash = convertHash(password);

  try {
    await conn.execute(
      "INSERT INTO user (userName, password, name) VALUES (:userName, :password, :name )",
      {"userName": userName, "password": hash, "name": name},
    );
    print(hash);
  } catch (e) {
    print('Error: $e');
  } finally {
    await conn.close();
  }
}

Future<String?> login(String userName, String password) async {
  final conn = await dbConnector();
  final hash = convertHash(password);

  IResultSet? result;

  try {
    result = await conn.execute(
      'SELECT id FROM user WHERE userName = :userName and password = :password',
      {"userName": userName, "password": hash},
    );

    if (result.isNotEmpty) {
      for (final row in result.rows) {
        print(row.assoc());
        return row.colAt(0);
      }
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    await conn.close();
  }
  return '-1';
}

Future<String?> confirmIdCheck(String userName) async {
  final conn = await dbConnector();
  IResultSet? result;

  try {
    result = await conn.execute(
      "SELECT IFNULL ((SELECT userName FROM user WHERE userName=:userName), 0) as idCheck",
      {"userName": userName},
    );

    if (result.isNotEmpty) {
      for (final row in result.rows) {
        return row.colAt(0);
      }
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    await conn.close();
  }
  return '-1';
}
