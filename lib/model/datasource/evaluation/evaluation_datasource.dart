import 'package:chart/config/db.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

class EvaluationDatasource {
  Future<List<EvaluationModel>> fetchEvaluationById(int patientId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'evaluations',
        where: 'patientId = ?',
        whereArgs: [patientId],
      );

      if (result.isEmpty) {
        throw Exception('평가 데이터가 없습니다 : $patientId');
      }

      return result.map((e) => EvaluationModel.fromMap(e)).toList();
    } catch (err) {
      print('fetchEvaluationById error : $err');
      rethrow;
    }
  }

  Future<EvaluationModel> fetchEvaluationByPatientIdAndRound(
    int patientId,
    int round,
  ) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'evaluations',
        where: 'patientId = ? AND round =?',
        whereArgs: [patientId, round],
      );

      if (result.isEmpty) {
        throw Exception('평가 데이터가 없습니다(patientId : $patientId, roudn: $round})');
      }
      return EvaluationModel.fromMap(result.first);
    } catch (err) {
      print('fetchEvaluationByPatientIdAndRound error : $err');
      rethrow;
    }
  }

  Future<List<EvaluationModel>> insertEvaluation(EvaluationModel eval) async {
    try {
      final db = await DatabaseHelper.instance.database;

      await db.insert(
        'evaluations',
        eval.toMap(includeId: false),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      final result = await db.query(
        'evaluations',
        where: 'patientId = ?',
        whereArgs: [eval.patientId],
      );

      return result.map(EvaluationModel.fromMap).toList();
    } catch (err) {
      print('insertEvaluation error : $err');
      rethrow;
    }
  }

  Future<void> updateEvaluation(EvaluationModel eval) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'evaluations',
        eval.toMap(),
        where: 'id = ?',
        whereArgs: [eval.id],
      );
    } catch (err) {
      print('updateEvaluation error : $err');
      rethrow;
    }
  }

  Future<void> deleteEvaluationByPatientIdAndEvaluationId(
    int patientId,
    int evalId,
  ) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'evaluations',
        where: 'patientId =? AND id = ?',
        whereArgs: [patientId, evalId],
      );
    } catch (err) {
      print('deleteEvaluaion error : $err');
      rethrow;
    }
  }

  Future<int> fetchMaxRound(int patientId) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.rawQuery(
        'SELECT MAX(round) AS maxRound FROM evaluations WHERE patientId = ?',
        [patientId],
      );

      if (result.isEmpty || result.first['maxRound'] == null) {
        return 0;
      }

      final maxRoundValue = result.first['maxRound'];
      final maxRound = maxRoundValue is int
          ? maxRoundValue
          : int.parse(maxRoundValue.toString());
      print('[maxround] : $maxRound');
      return maxRound;
    } catch (err) {
      print('fetchMaxRound error : $err');
      rethrow;
    }
  }

  Future<int?> findEvaluationIdByPatientIdAndRound(
    int patientId,
    int round,
  ) async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'evaluations',
        where: 'patientId = ? AND round = ?',
        whereArgs: [patientId, round],
        limit: 1,
      );

      if (result.isEmpty) {
        return null;
      }
      return result.first['id'] as int;
    } catch (err) {
      print('findEvaluationByPatientIdAndRound error : $err');
      rethrow;
    }
  }
}

final evaluationsDatasourceProvider = Provider((ref) => EvaluationDatasource());
