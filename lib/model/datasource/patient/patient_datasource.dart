import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class PatientDatasource {
  Future<List<PatientModel>> getAllPatientInfo() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('patients');
    print('[get all patient ok]');
    return result.map((e) => PatientModel.fromMap(e)).toList();
  }

  Future<PatientModel> getPatientInfoById(int id) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('patients', where: 'id = ?', whereArgs: [id]);
    return PatientModel.fromMap(result.first);
  }

  Future<PatientModel> savePatientInfo(PatientModel patient) async {
    final db = await DatabaseHelper.instance.database;
    final insertedId = await db.insert(
      'patients',
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    print('[ds ok]');
    return patient.copyWith(id: insertedId);
  }

  Future<void> updatePatientInfo(PatientModel patient) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'patients',
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  Future<void> deletePatientInfo(int id) async {
    final db = await DatabaseHelper.instance.database;
    print('삭제 성공 : $id');
    await db.delete('patients', where: 'id = ?', whereArgs: [id]);
  }
}

final patientDatasourceProvider = Provider((ref) => PatientDatasource());
