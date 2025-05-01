import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('patient model frommap should parse correctly', () {
    final mockPatient = {
      'name': '이진성',
      'age': 20,
      'gender': 'male',
      'firstVisit': DateTime.now().toIso8601String(),
      'occupation': 'developer',
    };

    final patient = PatientModel.fromMap(mockPatient);

    expect(patient.name, '이진성');
    expect(patient.age, 20);
    expect(patient.gender, Gender.male);
    expect(patient.occupation, 'developer');
  });

  test('patient model frommap should parse correctly check gender', () {
    final mockPatient = {
      'name': '김진성',
      'age': 20,
      'gender': 'unknown',
      'firstVisit': DateTime.now().toIso8601String(),
      'occupation': 'developer',
    };

    final patient = PatientModel.fromMap(mockPatient);

    expect(patient.gender, Gender.male);
  });

  test('db test', () async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('patients');
    print(result);
    for (var row in result) {
      print('gender is ${row['gender']}');
    }
  });
}
