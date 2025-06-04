import 'package:chart/view/evaluation/crud/evaluation_add_view.dart';
import 'package:chart/view/evaluation/detail/chart_view.dart';
import 'package:chart/view/evaluation/detail/evaluation_detail_view.dart';
import 'package:chart/view/patient/dialog/patient_delete_dialog.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view/patient/patient_main_view.dart';
import 'package:chart/view/plan/detail/plan_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/evaluation/provider/eval_round_provider.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:chart/view_model/plan/provider/plan_round_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientIntroduceView extends ConsumerWidget {
  const PatientIntroduceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);

    if (patient == null || patientId == null) {
      throw Exception('해당하는 환자가 없습니다');
    }

    final evaluationAsync = ref.read(evaluationViewModelProvider(patientId));
    final planAsync = ref.read(planViewModelProvider(patientId));

    final evaluations = evaluationAsync.asData?.value ?? [];
    final plans = planAsync.asData?.value ?? [];

    if (evaluations.isEmpty || plans.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('환자 데이터가 없습니다')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.name} 님'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => PatientView()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'add':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EvaluationAddView()),
                  );
                  break;
                case 'delete':
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PatientDeleteDialog();
                    },
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'add', child: Text('추가')),
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
                PatientInfoView(patient: patient, showName: false),
                SizedBox(height: 300, child: ChartView()),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final evaluationRounds =
                            evaluations
                                .map((e) => e.round)
                                .whereType<int>()
                                .toSet()
                                .toList()
                              ..sort();
                        final firstEvaluationRound = evaluationRounds.first;

                        ref.read(evalRoundProvider.notifier).state =
                            firstEvaluationRound;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EvaluationDetailView(),
                          ),
                        );
                      },
                      child: Text('평가'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final planRounds =
                            plans
                                .map((e) => e.round)
                                .whereType<int>()
                                .toSet()
                                .toList()
                              ..sort();
                        final firstPlanRound = planRounds.first;
                        ref.read(planRoundProvider.notifier).state =
                            firstPlanRound;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PlanInfoView()),
                        );
                      },
                      child: Text('계획'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
