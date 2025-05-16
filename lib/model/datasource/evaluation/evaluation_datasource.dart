import 'package:chart/config/db.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqlite_api.dart';

class EvaluationDatasource {
  Future<List<EvaluationModel>> fetchEvaluationById(int patientId) async {
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
  }

  Future<List<EvaluationModel>> insertEvaluation(EvaluationModel eval) async {
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
  }

  Future<void> updateEvaluation(EvaluationModel eval) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'evaluations',
      eval.toMap(),
      where: 'id = ?',
      whereArgs: [eval.id],
    );
  }

  Future<void> deleteEvaluation(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('evaluations', where: 'patientId = ?', whereArgs: [id]);
  }

  Future<int> fetchMaxRound(int patientId) async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(
      'SELECT MAX(round) as maxRound FROM evaluations WHERE patientId = ?',
      [patientId],
    );
    final maxRound = result.first['maxRound'] as int?;
    return maxRound ?? 0;
  }
}

final evaluationsDatasourceProvider = Provider((ref) => EvaluationDatasource());
