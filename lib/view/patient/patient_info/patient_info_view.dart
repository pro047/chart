import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientInfoView extends StatelessWidget {
  final PatientModel patient;
  final bool showName;

  const PatientInfoView({
    super.key,
    required this.patient,
    this.showName = true,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd').format(patient.firstVisit);

    final fields = <String>[
      if (showName) '이름 : ${patient.name}',
      '나이 : ${patient.age}',
      '성별 : ${patient.gender.name}',
      '첫 내원일 : $dateFormat',
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
