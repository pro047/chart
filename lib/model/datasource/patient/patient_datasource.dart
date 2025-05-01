import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class PatientDatasource {
  Future<List<PatientModel>> getPatientInfo(String name) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'patients',
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.map((i) => PatientModel.fromMap(i)).toList();
  }

  Future<void> savePatientInfo(PatientModel patientInfo) async {
    final db = await DatabaseHelper.instance.database;
    final patient = patientInfo.toMap();
    await db.insert(
      'patients',
      patient,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final patientDatasourceProvider = Provider((ref) => PatientDatasource());
