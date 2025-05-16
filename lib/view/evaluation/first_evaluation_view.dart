// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/view/evaluation/evaluation_detail_view.dart';
import 'package:chart/view/evaluation/evaluation_form_view.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/patient_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class FirstEvaluationView extends ConsumerStatefulWidget {
  const FirstEvaluationView({super.key});

  @override
  ConsumerState<FirstEvaluationView> createState() =>
      _FirstEvaluationViewState();
}

class _FirstEvaluationViewState extends ConsumerState<FirstEvaluationView> {
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
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);

    if (patientId == null) {
      return Scaffold(body: Center(child: Text('환자가 없습니다')));
    }

    final vmProvider = ref.read(
      evaluationViewModelProvider(patientId).notifier,
    );

    return Scaffold(
      appBar: AppBar(title: Text('초기 평가')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PatientInfoView(patient: patient!),
            EvaluationFormView(
              fields: _evalField,
              formKey: _evalformKey,
              onSubmit: () async {
                try {
                  await vmProvider.submitEval(fields: _evalField);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EvaluationDetailView()),
                  );
                } catch (err) {
                  throw Exception('에러 발생 : $err');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
