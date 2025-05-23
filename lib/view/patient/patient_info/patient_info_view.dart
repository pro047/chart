import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/ui/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PatientInfoView extends ConsumerWidget {
  final PatientModel patient;

  const PatientInfoView({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('yyyy-MM-dd').format(patient.firstVisit);
    final currentPage = ref.watch(currentPageProvider);

    final fields = <String>[
      '나이 : ${patient.age}',
      '성별 : ${patient.gender}',
      '첫 내원일 : $dateFormat',
      '직업 : ${patient.occupation}',
    ];
    if (currentPage != Pages.patientIntroduce) {
      fields.insert(0, '이름 : ${patient.name}');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...fields.map(
          (field) => Padding(
            padding: EdgeInsets.all(8),
            child: Text(field, style: TextStyle(fontSize: 15)),
          ),
        ),
      ],
    );
  }
}
