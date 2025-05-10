import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientInfoView extends ConsumerWidget {
  final PatientModel patient;

  const PatientInfoView({super.key, required this.patient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fields = [
      '이름 : ${patient.name}',
      '나이 : ${patient.age}',
      '성별 : ${patient.gender}',
      '첫 내원일 : ${patient.firstVisit}',
      '직업 : ${patient.occupation}',
    ];
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
