import 'package:chart/model/datasource/plan/plan_datasource.dart';
import 'package:chart/model/model/plan/plan_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class PlanRepository {
  final PlanDatasource _datasource;

  PlanRepository(this._datasource);

  Future<List<PlanModel>> getPlanByPatientId(int patientId) async {
    return await _datasource.fetchPlanByPatientId(patientId);
  }

  Future<void> createPlan(Map<String, dynamic> plan, int patientId) async {
    return await _datasource.insertPlan(plan, patientId);
  }

  Future<void> updatePlan(PlanModel plan) async {
    await _datasource.updatePlan(plan);
  }

  Future<void> deletePlan(int patientId, int round) async {
    await _datasource.deletePlanByPatientIdAndRound(patientId, round);
  }
}

final planRepositoryProvider = Provider((ref) {
  final datasource = ref.read(planDatasourceProvider);
  return PlanRepository(datasource);
});
