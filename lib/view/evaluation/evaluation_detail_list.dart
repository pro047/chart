import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EvaluationDetailList extends ConsumerStatefulWidget {
  final int? patientId;

  const EvaluationDetailList({super.key, required this.patientId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EvaluationDetailListState();
}

class _EvaluationDetailListState extends ConsumerState<EvaluationDetailList> {
  @override
  Widget build(BuildContext context) {
    final patientState = ref.watch(patientViewModelProvider.notifier);
    final evalState = ref.read(evaluationViewModelProvider.notifier);

    final patient = patientState.getInfoById(widget.patientId!);

    return Scaffold(
      appBar: AppBar(title: Text('list')),
      body: Center(child: Text('리스트')),
    );
  }
}
