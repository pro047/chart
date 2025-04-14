import 'package:mysql_client/mysql_client.dart';

Future<MySQLConnection> dbConnector() async {
  print('Connectiong to mysql server...');

  final conn = await MySQLConnection.createConnection(
    host: 'localhost',
    port: 3306,
    userName: 'root',
    password: 'wlstjd1153',
    databaseName: 'chartpt',
  );

  await conn.connect();

  print('Connected');

  return conn;
}
