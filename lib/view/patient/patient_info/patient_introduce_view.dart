import 'package:chart/view/evaluation/crud/evaluation_add_view.dart';
import 'package:chart/view/evaluation/detail/chart_view.dart';
import 'package:chart/view/patient/dialog/patient_delete_dialog.dart';
import 'package:chart/view/patient/lib/round_dropdown.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientIntroduceView extends ConsumerWidget {
  const PatientIntroduceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    print('[debug] patient state : $patient');

    if (patient == null) {
      throw Exception('해당하는 환자가 없습니다');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.name} 님'),
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
                RoundDropdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
