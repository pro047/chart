import 'dart:async';

import 'package:chart/model/model/plan/plan_field_model.dart';
import 'package:chart/model/model/plan/plan_model.dart';
import 'package:chart/model/repository/plan/plan_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanViewModel extends FamilyAsyncNotifier<List<PlanModel>, int> {
  late final PlanRepository _repository;

  @override
  FutureOr<List<PlanModel>> build(int patientId) async {
    _repository = ref.read(planRepositoryProvider);
    return _repository.getPlanByPatientId(patientId);
  }

  Future<void> submitPlan({required List<PlanFieldModel> fields}) async {
    final newPlan = PlanModel(
      stg: fields[0].controller.text,
      ltg: fields[1].controller.text,
      treatmentPlan: fields[2].controller.text,
      exercisePlan: fields[3].controller.text,
      homework: fields[4].controller.text,
      patientid: arg,
    );

    await _repository.createPlan(newPlan.toMap(), newPlan.patientid!);

    state = await AsyncValue.guard(() => _repository.getPlanByPatientId(arg));
  }

  Future<void> updatePlan(PlanModel plan) async {
    await _repository.updatePlan(plan);

    state = await AsyncValue.guard(() => _repository.getPlanByPatientId(arg));
  }

  Future<void> deletePlan(int patientId, int round) async {
    await _repository.deletePlan(patientId, round);

    state = await AsyncValue.guard(() => _repository.getPlanByPatientId(arg));
  }
}

final planViewModelProvider =
    AsyncNotifierProvider.family<PlanViewModel, List<PlanModel>, int>(
      PlanViewModel.new,
    );
