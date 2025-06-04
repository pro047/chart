import 'package:chart/model/model/plan/plan_field_model.dart';
import 'package:chart/model/model/plan/plan_model.dart';
import 'package:chart/view/plan/form/plan_form_view.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanEditView extends ConsumerStatefulWidget {
  final PlanModel plan;

  const PlanEditView({super.key, required this.plan});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanEditViewState();
}

class _PlanEditViewState extends ConsumerState<PlanEditView> {
  final _editPlanKey = GlobalKey<FormState>();

  late final List<TextEditingController> _controllers;
  late final List<PlanFieldModel> _fields;

  @override
  void initState() {
    super.initState();
    _controllers = [
      TextEditingController(text: widget.plan.stg),
      TextEditingController(text: widget.plan.ltg),
      TextEditingController(text: widget.plan.treatmentPlan),
      TextEditingController(text: widget.plan.exercisePlan),
      TextEditingController(text: widget.plan.homework),
    ];

    _fields = [
      PlanFieldModel(
        controller: _controllers[0],
        label: 'STG',
        hintText: 'STG',
      ),
      PlanFieldModel(
        controller: _controllers[1],
        label: 'LTG',
        hintText: 'LTG',
      ),
      PlanFieldModel(
        controller: _controllers[2],
        label: 'Treatment Plan',
        hintText: 'Treatment Plan',
      ),
      PlanFieldModel(
        controller: _controllers[3],
        label: 'Exercise Plan',
        hintText: 'Exercise Plan',
      ),
      PlanFieldModel(
        controller: _controllers[4],
        label: 'Homework',
        hintText: 'Homework',
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    for (var i in _controllers) {
      i.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final planProvider = ref.read(
      planViewModelProvider(widget.plan.patientid!).notifier,
    );

    return Scaffold(
      appBar: AppBar(title: Text('계획 수정')),
      body: PlanFormView(
        formKey: _editPlanKey,
        fields: _fields,
        onSubmit: () async {
          try {
            if (_editPlanKey.currentState!.validate()) {
              final updated = widget.plan.copyWith(
                stg: _controllers[0].text,
                ltg: _controllers[1].text,
                treatmentPlan: _controllers[2].text,
                exercisePlan: _controllers[3].text,
                homeWork: _controllers[4].text,
              );
              await planProvider.updatePlan(updated);
              Navigator.pop(context);
            }
          } catch (err) {
            print('edit error : $err');
            throw Exception('수정 실패');
          }
        },
      ),
    );
  }
}
