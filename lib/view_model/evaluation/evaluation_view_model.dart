import 'dart:async';

import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/model/repository/evaluation/evaluation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationViewModel extends AsyncNotifier<List<EvaluationModel>> {
  late final EvaluationRepository _repository;

  @override
  FutureOr<List<EvaluationModel>> build() async {
    _repository = ref.read(evaluationRepositoryProvider);
    return [];
  }

  Future<EvaluationModel> getEvaluation(int patientId) async {
    return await _repository.getEvaluationById(patientId);
  }

  Future<void> updateEvaluation(EvaluationModel eval) async {
    await _repository.updateEvaluation(eval);
    final currentList = state.valueOrNull ?? [];
    final index = currentList.indexWhere((e) => e.id == eval.id);
    if (index != -1) {
      final newList = [...currentList];
      newList[index] = eval;
      state = AsyncData(newList);
    }
  }

  Future<void> deleteEvaluation(int id) async {
    await _repository.deleteEvaluation(id);
    state = AsyncData([...state.value!..removeWhere((e) => e.id == id)]);
  }

  Map<int?, List<EvaluationModel>> groupedEvals(EvaluationModel eval) {
    final evals = state.valueOrNull ?? [];
    final group = <int?, List<EvaluationModel>>{};

    for (final eval in evals) {
      final key = eval.round;
      group.putIfAbsent(key, () => []).add(eval);
    }
    return group;
  }

  Future<int> getMaxRound(int patientId) async {
    final maxRound = await _repository.getMaxRound(patientId);
    return maxRound + 1;
  }

  Future<EvaluationModel> createEvalWithNextRound(
    EvaluationModel prevEval,
  ) async {
    final nextRound = await getMaxRound(prevEval.patientId!);
    return prevEval.copyWith(round: nextRound);
  }

  Future<void> submitEval({
    required int id,
    required List<EvaluationFieldModel> fields,
  }) async {
    final rom = int.tryParse(fields[2].controller.text);
    final vas = int.tryParse(fields[3].controller.text);

    final newEval = EvaluationModel(
      rom: rom,
      vas: vas,
      region: fields[0].controller.text,
      action: fields[1].controller.text,
      hx: fields[4].controller.text,
      sx: fields[5].controller.text,
      patientId: id,
    );

    final evalWithRound = await createEvalWithNextRound(newEval);
    await _repository.createEvaluation(evalWithRound);
  }
}

final evaluationViewModelProvider =
    AsyncNotifierProvider<EvaluationViewModel, List<EvaluationModel>>(() {
      return EvaluationViewModel();
    });
