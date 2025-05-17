import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/patient/provider/round_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationHistoryView extends ConsumerWidget {
  const EvaluationHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientId = ref.watch(patientIdProvider);
    final round = ref.watch(roundProvider);

    if (patientId == null || round == null) {
      return Center(child: Text('해당 환자의 평가 기록이 없습니다'));
    }
    final evalProvider = ref.read(
      evaluationViewModelProvider(patientId).notifier,
    );
    final evalFuture = evalProvider.getEvaluationByPatientIdAndRound(
      patientId,
      round,
    );

    return Container(
      child: FutureBuilder<EvaluationModel>(
        future: evalFuture,
        builder: (context, snapshot) {
          final state = snapshot.connectionState;

          switch (state) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();

            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('에러 발생 ${snapshot.hasError}');
              }
              final data = snapshot.data;
              if (data == null) {
                return Text('해당 데이터가 없습니다');
              }
              return _buildEvaluationsList(data);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
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
