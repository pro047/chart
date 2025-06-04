import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/config/db.dart';
import 'package:chart/model/model/plan/plan_model.dart';

class PlanDatasource {
  Future<List<PlanModel>> fetchPlanByPatientId(int patientId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'plans',
        where: 'patient_id = ?',
        whereArgs: [patientId],
      );
      for (var row in result) {
        print(row);
      }
      return result.map((e) => PlanModel.fromMap(e)).toList();
    } catch (err) {
      print('fetchPlanByPatientId error : $err');
      rethrow;
    }
  }

  Future<void> insertPlan(Map<String, dynamic> plan, int patientId) async {
    try {
      final db = await DatabaseHelper.instance.database;

      await db.transaction((txn) async {
        final result = await txn.rawQuery(
          'SELECT COALESCE(MAX(round), 0) + 1 AS nextRound FROM plans WHERE patient_id = ?',
          [patientId],
        );

        print('result : $result');
        final nextRound = result.first['nextRound'] as int;
        print('nextRound : $nextRound');

        final insertResult = await txn.insert('plans', {
          'patient_id': patientId,
          ...plan,
          'round': nextRound,
        });
        print('insertResult : $insertResult');
      });
    } catch (err) {
      print('insertPlan error : $err');
      rethrow;
    }
  }

  Future<void> updatePlan(PlanModel plan) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'plans',
        plan.toMap(),
        where: 'round = ?',
        whereArgs: [plan.round],
      );
    } catch (err) {
      print('updatePlan error : $err');
      rethrow;
    }
  }

  Future<void> deletePlanByPatientIdAndRound(int patientId, int round) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'plans',
        where: 'patient_id = ? AND round = ?',
        whereArgs: [patientId, round],
      );
    } catch (err) {
      print('deletePlan error : $err');
      rethrow;
    }
  }
}

final planDatasourceProvider = Provider((ref) => PlanDatasource());
