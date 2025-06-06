import 'package:chart/config/db.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class PatientDatasource {
  Future<List<PatientModel>> getAllPatientInfo() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query('patients');
      print('[get all patient ok]');
      return result.map((e) => PatientModel.fromMap(e)).toList();
    } catch (err) {
      rethrow;
    }
  }

  Future<PatientModel> getPatientInfoById(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'patients',
        where: 'id = ?',
        whereArgs: [id],
      );
      return PatientModel.fromMap(result.first);
    } catch (err) {
      rethrow;
    }
  }

  Future<PatientModel> savePatientInfo(PatientModel patient) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final insertedId = await db.insert(
        'patients',
        patient.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return patient.copyWith(id: insertedId);
    } catch (err) {
      rethrow;
    }
  }

  Future<void> updatePatientInfo(PatientModel patient) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'patients',
        patient.toMap(),
        where: 'id = ?',
        whereArgs: [patient.id],
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deletePatientInfo(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      print('삭제 성공 : $id');
      await db.delete('patients', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      rethrow;
    }
  }

  Future<List<PatientModel>> fetchRecentPatients() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'patients',
        orderBy: 'first_visit DESC',
        limit: 5,
      );
      return result.map((e) => PatientModel.fromMap(e)).toList();
    } catch (err) {
      rethrow;
    }
  }
}

final patientDatasourceProvider = Provider((ref) => PatientDatasource());
