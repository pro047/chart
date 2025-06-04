// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/view/evaluation/form/evaluation_form_view.dart';
import 'package:chart/view/patient/patient_info/patient_info_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EvaluationAddView extends ConsumerStatefulWidget {
  const EvaluationAddView({super.key});

  @override
  ConsumerState<EvaluationAddView> createState() => _EvaluationAddViewState();
}

class _EvaluationAddViewState extends ConsumerState<EvaluationAddView> {
  final _addEvalFormKey = GlobalKey<FormState>();

  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _actionController = TextEditingController();
  final TextEditingController _romController = TextEditingController();
  final TextEditingController _vasController = TextEditingController();
  final TextEditingController _hxController = TextEditingController();
  final TextEditingController _sxController = TextEditingController();

  final List<EvaluationFieldModel> _evalField = [];

  int? _round;

  @override
  void initState() {
    super.initState();
    _evalField.addAll([
      EvaluationFieldModel(
        controller: _regionController,
        label: 'Region',
        hintText: 'Region',
      ),
      EvaluationFieldModel(
        controller: _actionController,
        label: 'Action',
        hintText: 'Action',
      ),
      EvaluationFieldModel(
        controller: _romController,
        label: 'ROM',
        hintText: 'ROM',
        inputType: TextInputType.number,
      ),
      EvaluationFieldModel(
        controller: _vasController,
        label: 'VAS',
        hintText: 'VAS',
        inputType: TextInputType.number,
      ),
      EvaluationFieldModel(
        controller: _hxController,
        label: 'Hx',
        hintText: 'Hx',
      ),
      EvaluationFieldModel(
        controller: _sxController,
        label: 'Sx',
        hintText: 'Sx',
      ),
    ]);

    _loadRound();
  }

  Future<void> _loadRound() async {
    final patientId = ref.read(patientIdProvider);
    if (patientId == null) return;

    final vmProvider = ref.read(
      evaluationViewModelProvider(patientId).notifier,
    );
    final round = await vmProvider.getMaxRound(patientId);
    setState(() {
      _round = round;
    });
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

    if (patientId == null || patient == null) {
      return Scaffold(body: Center(child: Text('환자가 없습니다')));
    }

    if (_round == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final vmProvider = ref.read(
      evaluationViewModelProvider(patientId).notifier,
    );
    return Scaffold(
      appBar: AppBar(title: Text('$_round 회차')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PatientInfoView(patient: patient),
            EvaluationFormView(
              fields: _evalField,
              formKey: _addEvalFormKey,
              onSubmit: () async {
                try {
                  await vmProvider.submitEval(fields: _evalField);
                  Navigator.pop(context);
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
