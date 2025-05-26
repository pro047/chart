import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/view/evaluation/crud/evaluation_add_view.dart';
import 'package:chart/view/evaluation/crud/evaluation_delete_view.dart';
import 'package:chart/view/evaluation/crud/evaluation_edit_view.dart';
import 'package:chart/view/evaluation/detail/evaluation_history_view.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/patient/provider/round_provider.dart';

class EvaluationDetailView extends ConsumerWidget {
  const EvaluationDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);

    if (patient == null || patientId == null) {
      return throw Exception('해당하는 환자가 없습니다');
    }
    final round = ref.watch(roundProvider);
    final evalAsync = ref.watch(evaluationViewModelProvider(patientId));
    final EvaluationModel? eval = evalAsync.whenOrNull(
      data: (data) => data.firstWhere((e) => e.round == round),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('$round회차'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                case 'edit':
                  if (eval != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EvaluationEditView(eval: eval),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('알림'),
                        content: Text('해당 회차의 평가가 없습니다'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                  }
                  break;
                case 'delete':
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return EvaluationDeleteDialog();
                    },
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
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
                PatientInfoView(patient: patient),
                EvaluationHistoryView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
