import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationHistoryView extends ConsumerWidget {
  const EvaluationHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientId = ref.read(patientIdProvider);
    final evalProvider = ref.read(
      evaluationViewModelProvider(patientId!).notifier,
    );
    final evalFuture = evalProvider.getEvaluationById(patientId);

    return Container(
      child: FutureBuilder<List<EvaluationModel>>(
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
              if (data == null || data.isEmpty) {
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

Widget _buildEvaluationsList(List<EvaluationModel> data) {
  return Column(
    children:
        data.map((e) {
          return Column(
            children: [
              Text('Region : ${e.region}'),
              Text('Action : ${e.action}'),
              Text('ROM : ${e.rom}'),
              Text('VAS : ${e.vas}'),
              Text('Hx : ${e.hx}'),
              Text('Sx : ${e.sx}'),
              Divider(),
            ],
          );
        }).toList(),
  );
}
