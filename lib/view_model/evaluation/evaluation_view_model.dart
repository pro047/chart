import 'dart:async';

import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/model/repository/evaluation/evaluation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationViewModel
    extends FamilyAsyncNotifier<List<EvaluationModel>, int> {
  EvaluationRepository get _repository =>
      ref.read(evaluationRepositoryProvider);

  @override
  FutureOr<List<EvaluationModel>> build(int patientId) async {
    return _repository.getEvaluationById(patientId);
  }

  Future<EvaluationModel> getEvaluationByPatientIdAndRound(
    int patientId,
    int round,
  ) async {
    return await _repository.getEvaluaionByPatientIdAndRound(patientId, round);
  }

  Future<void> updateEvaluation(EvaluationModel updatedEval) async {
    try {
      await _repository.updateEvaluation(updatedEval);

      final currentList = state.valueOrNull;
      if (currentList == null) return;
      print('currentList : $currentList');

      final updatedList = currentList.map((e) {
        return e.id == updatedEval.id ? updatedEval : e;
      }).toList();

      state = AsyncData(updatedList);
    } catch (err, st) {
      print('updateEvaluation Error : $err');
      state = AsyncError(err, st);
      throw Exception('Failed update');
    }
  }

  Future<void> deleteEvaluationByPatientIdAndRound(
    int patientId,
    int round,
  ) async {
    await _repository.deleteEvaluationByPatientIdAndRound(patientId, round);

    final newList = await _repository.getEvaluationById(patientId);
    print('newList : $newList');
    state = AsyncData(newList);
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

  Future<void> submitEval({required List<EvaluationFieldModel> fields}) async {
    final rom = int.tryParse(fields[2].controller.text);
    final vas = int.tryParse(fields[3].controller.text);

    final newEval = EvaluationModel(
      rom: rom,
      vas: vas,
      region: fields[0].controller.text,
      action: fields[1].controller.text,
      hx: fields[4].controller.text,
      sx: fields[5].controller.text,
      patientId: arg,
      createdAt: DateTime.now(),
    );

    final evalWithRound = await createEvalWithNextRound(newEval);
    await _repository.createEvaluation(evalWithRound);

    state = AsyncData([...state.valueOrNull ?? [], evalWithRound]);
  }

  Future<int?> findEvaluationIdByPatientIdAndRound(
    int patientId,
    int round,
  ) async {
    try {
      final evalId = await _repository.findEvaluationIdByPatientIdAndRound(
        patientId,
        round,
      );
      if (evalId == null) {
        throw Exception('해당 평가 기록은 없습니다');
      }
      return evalId;
    } catch (err) {
      print('findEvaluationIdByPatientIdAndRound ViewModel error : $err');
      throw Exception('에러가 발생했습니다');
    }
  }
}

final evaluationViewModelProvider =
    AsyncNotifierProvider.family<
      EvaluationViewModel,
      List<EvaluationModel>,
      int
    >(EvaluationViewModel.new);
