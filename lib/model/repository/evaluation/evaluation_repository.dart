import 'package:chart/model/datasource/evaluation/evaluation_datasource.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationRepository {
  final EvaluationDatasource _datasource;

  EvaluationRepository(this._datasource);

  Future<EvaluationModel> getEvaluationById(int patientId) async {
    return await _datasource.fetchEvaluationById(patientId);
  }

  Future<List<EvaluationModel>> createEvaluation(EvaluationModel eval) async {
    return await _datasource.insertEvaluation(eval);
  }

  Future<void> updateEvaluation(EvaluationModel eval) async {
    await _datasource.updateEvaluation(eval);
  }

  Future<void> deleteEvaluation(int id) async {
    await _datasource.deleteEvaluation(id);
  }

  Future<int> getMaxRound(int patientId) async {
    return await _datasource.fetchMaxRound(patientId);
  }
}

final evaluationRepositoryProvider = Provider((ref) {
  final datasource = ref.read(evaluationsDatasourceProvider);
  return EvaluationRepository(datasource);
});
