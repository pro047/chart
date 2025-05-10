import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('patients insert well', () async {
    final db = await DatabaseHelper.instance.database;
    final newPatient = PatientModel(
      name: 'ljs',
      age: 20,
      gender: Gender.female,
      firstVisit: DateTime.now(),
      occupation: 'pt',
    );

    final inserted = await db.insert('patients', newPatient.toMap());
    print(inserted);

    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    print(today);

    final result = await db.query('patients');
    print(result);

    if (result.isNotEmpty) {
      final patient = PatientModel.fromMap(result.first);
      print('[조회 성공] 방문 일자 : ${patient.firstVisit}');
    } else {
      print('조회 실패');
    }
  });

  test('db test', () async {
    final db = await DatabaseHelper.instance.database;
    final table = await db.rawQuery(
      'SELECT * FROM sqlite_master WHERE type="table"',
    );
    print('table: $table');
  });
}
