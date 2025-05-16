import 'package:chart/view/evaluation/detail/chart_view.dart';
import 'package:chart/view/evaluation/detail/evaluation_history_view.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationDetailView extends ConsumerWidget {
  const EvaluationDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);
    final evalState = ref.read(evaluationViewModelProvider(patientId!));

    return Scaffold(
      appBar: AppBar(
        title: evalState.when(
          data: (data) => Text('${data.first.round}회차'),
          error: (e, _) => Text('error : $e'),
          loading: () => CircularProgressIndicator(),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'add':
                  break;
                case 'eidt':
                  break;
                case 'delete':
                  break;
              }
            },
            itemBuilder:
                (_) => [
                  PopupMenuItem(value: 'add', child: Text('추가')),
                  PopupMenuItem(value: 'edit', child: Text('수정')),
                  PopupMenuItem(value: 'delete', child: Text('삭제')),
                ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                PatientInfoView(patient: patient!),
                SizedBox(height: 300, child: ChartView()),
                EvaluationHistoryView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
