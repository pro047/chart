import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/evaluation/provider/eval_round_provider.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationInfoView extends ConsumerWidget {
  const EvaluationInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientId = ref.watch(patientIdProvider);
    final round = ref.watch(evalRoundProvider);

    if (patientId == null || round == null) {
      return Center(child: Text('해당 환자의 평가 기록이 없습니다'));
    }
    final evalAsync = ref.watch(evaluationViewModelProvider(patientId));

    return Container(
      padding: EdgeInsets.all(16),
      child: evalAsync.when(
        data: (data) {
          final filtered = data.where((e) => e.round == round).toList();
          if (filtered.isEmpty) {
            return Text('해당 회차의 평가가 업습니다');
          }
          final eval = filtered.first;

          return _buildEvaluationsList(eval);
        },
        error: (e, _) => Text('Error : $e'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEvaluationsList(EvaluationModel data) {
    return Column(
      children: [
        Text('Region : ${data.region}'),
        Text('Action : ${data.action}'),
        Text('ROM : ${data.rom}'),
        Text('VAS : ${data.vas}'),
        Text('Hx : ${data.hx}'),
        Text('Sx : ${data.sx}'),
        Divider(),
      ],
    );
  }
}
