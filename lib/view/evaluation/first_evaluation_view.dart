// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/view/evaluation/evaluation_form_view.dart';
import 'package:chart/view/patient/patient_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EvaluationView extends ConsumerStatefulWidget {
  final int? patientId;

  const EvaluationView({super.key, required this.patientId});

  @override
  ConsumerState<EvaluationView> createState() => _EvaluationViewState();
}

class _EvaluationViewState extends ConsumerState<EvaluationView> {
  final _evalformKey = GlobalKey<FormState>();

  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _romController = TextEditingController();
  final TextEditingController _vasController = TextEditingController();
  final TextEditingController _hxController = TextEditingController();
  final TextEditingController _sxController = TextEditingController();

  late final List<EvaluationFieldModel> _evalField;

  @override
  void initState() {
    super.initState();
    _evalField = [
      EvaluationFieldModel(controller: _regionController, hintText: 'Region'),
      EvaluationFieldModel(controller: _actionController, hintText: 'Action'),
      EvaluationFieldModel(
        controller: _romController,
        hintText: 'ROM',
        inputType: TextInputType.number,
      ),
      EvaluationFieldModel(
        controller: _vasController,
        hintText: 'VAS',
        inputType: TextInputType.number,
      ),
      EvaluationFieldModel(controller: _hxController, hintText: 'hx'),
      EvaluationFieldModel(controller: _sxController, hintText: 'sx'),
    ];
  }

  @override
  void dispose() {
    _regionController.dispose();
    _actionController.dispose();
    _romController.dispose();
    _vasController.dispose();
    _hxController.dispose();
    _sxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patientState = ref.read(patientViewModelProvider.notifier);
    final patientFuture = patientState.getInfoById(widget.patientId!);

    return Scaffold(
      appBar: AppBar(title: Text('초기 평가')),
      body: Column(
        children: [
          FutureBuilder<PatientModel>(
            future: patientFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              final patient = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    PatientInfoView(patient: patient),
                    EvaluationFormView(
                      formKey: _evalformKey,
                      fields: _evalField,
                      onSubmit: () async {
                        await ref
                            .read(evaluationViewModelProvider.notifier)
                            .submitEval(
                              id: widget.patientId!,
                              fields: _evalField,
                            );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
