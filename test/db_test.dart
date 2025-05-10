import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    final path = join(await getDatabasesPath(), 'chartpt.db');
    await deleteDatabase(path);
    final db = await DatabaseHelper.instance.database;

    await db.insert('patients', {
      'id': 1,
      'name': 'ljs',
      'age': 20,
      'gender': 'male',
      'firstVisit': 20250509,
      'occupation': 'pt',
    });
  });

  test('db test', () async {
    final db = await DatabaseHelper.instance.database;
    final tables = await db.rawQuery(
      'SELECT name FROM sqlite_master WHERE type="table"',
    );
    print('tables : $tables');

    expect(
      tables.any((row) => row['name'] == 'evaluations'),
      true,
      reason: 'evaluations table must be exist',
    );
  });

  test('fetch all patients', () async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('patients');
    print(result);

    expect(result.map((e) => PatientModel.fromMap(e)).toList(), isNotEmpty);
  });
}
