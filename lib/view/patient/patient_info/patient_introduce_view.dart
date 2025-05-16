import 'package:chart/view/evaluation/detail/chart_view.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/patient/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientIntroduceView extends ConsumerWidget {
  const PatientIntroduceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${patient!.name} 님'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'eidt':
                  break;
                case 'delete':
                  break;
              }
            },
            itemBuilder:
                (_) => [
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
                SizedBox(height: 300, child: ChartView()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
