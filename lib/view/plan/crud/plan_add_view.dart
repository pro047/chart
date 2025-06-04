import 'package:chart/model/model/plan/plan_field_model.dart';
import 'package:chart/view/plan/detail/plan_info_view.dart';
import 'package:chart/view/plan/form/plan_form_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanAddView extends ConsumerStatefulWidget {
  const PlanAddView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanAddViewState();
}

class _PlanAddViewState extends ConsumerState<PlanAddView> {
  final _addPlanFormKey = GlobalKey<FormState>();

  final TextEditingController _stgController = TextEditingController();
  final TextEditingController _ltgController = TextEditingController();
  final TextEditingController _treatmentPlanController =
      TextEditingController();
  final TextEditingController _exercisePlanController = TextEditingController();
  final TextEditingController _homeworkController = TextEditingController();

  final List<PlanFieldModel> _planField = [];

  @override
  void initState() {
    super.initState();
    _planField.addAll([
      PlanFieldModel(controller: _stgController, label: 'STG', hintText: 'STG'),
      PlanFieldModel(controller: _ltgController, label: 'LTG', hintText: 'LTG'),
      PlanFieldModel(
        controller: _treatmentPlanController,
        label: 'Treatmetn Plan',
        hintText: 'Treatment Plan',
      ),
      PlanFieldModel(
        controller: _exercisePlanController,
        label: 'Exercise Plan',
        hintText: 'Exercise Plan',
      ),
      PlanFieldModel(
        controller: _homeworkController,
        label: 'Homework',
        hintText: 'Homework',
      ),
    ]);
  }

  @override
  void dispose() {
    _stgController.dispose();
    _ltgController.dispose();
    _treatmentPlanController.dispose();
    _exercisePlanController.dispose();
    _homeworkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);

    if (patient == null || patientId == null) {
      return Scaffold(body: Center(child: Text('환자가 없습니다')));
    }

    final vmProvider = ref.read(planViewModelProvider(patientId).notifier);

    return Scaffold(
      appBar: AppBar(title: Text('1회차')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PlanFormView(
              fields: _planField,
              formKey: _addPlanFormKey,
              onSubmit: () async {
                try {
                  await vmProvider.submitPlan(fields: _planField);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => PlanInfoView()),
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
