import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  await initializeDateFormatting('ko_KR', '');

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;

  setUpAll(() async {
    final path = join(await getDatabasesPath(), 'chartpt.db');
    await deleteDatabase(path);
    db = await databaseFactory.openDatabase(path);

    await db.execute("""
    CREATE TABLE patients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INTEGER,
    gender TEXT,
    firstVisit TEXT,
    occupation TEXT
    )
    """);
  });

  test('fetch all patient', () async {
    final mockPatient = PatientModel(
      name: 'test',
      age: 20,
      gender: Gender.male,
      firstVisit: DateTime.now(),
      occupation: '개발자',
    );

    db.insert('patients', mockPatient.toMap());

    final result = await db.query('patients');
    print('all patient result: $result');
    expect(result.map((e) => PatientModel.fromMap(e)).toList(), isNotEmpty);
  });
}
