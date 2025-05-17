import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:chart/model/model/evlauation/evaluation_model.dart';
import 'package:chart/ui/provider/page_provider.dart';
import 'package:chart/view/evaluation/form/evaluation_form_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class EvaluationEditView extends ConsumerStatefulWidget {
  final EvaluationModel eval;

  const EvaluationEditView({super.key, required this.eval});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EvaluationEditViewState();
}

class _EvaluationEditViewState extends ConsumerState<EvaluationEditView> {
  final _editEvalFormKey = GlobalKey<FormState>();

  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = [
      TextEditingController(text: widget.eval.region),
      TextEditingController(text: widget.eval.action),
      TextEditingController(text: widget.eval.rom.toString()),
      TextEditingController(text: widget.eval.vas.toString()),
      TextEditingController(text: widget.eval.hx),
      TextEditingController(text: widget.eval.sx),
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
    final evalProvider = ref.read(
      evaluationViewModelProvider(widget.eval.patientId!).notifier,
    );

    final fields = [
      EvaluationFieldModel(
        controller: _controllers[0],
        label: 'Region',
        hintText: 'Region',
      ),
      EvaluationFieldModel(
        controller: _controllers[1],
        label: 'Action',
        hintText: 'Action',
      ),
      EvaluationFieldModel(
        controller: _controllers[2],
        label: 'ROM',
        hintText: 'ROM',
      ),
      EvaluationFieldModel(
        controller: _controllers[3],
        label: 'VAS',
        hintText: 'VAS',
      ),
      EvaluationFieldModel(
        controller: _controllers[4],
        label: 'Hx',
        hintText: 'Hx',
      ),
      EvaluationFieldModel(
        controller: _controllers[5],
        label: 'Sx',
        hintText: 'Sx',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('평가 수정')),
      body: EvaluationFormView(
        fields: fields,
        formKey: _editEvalFormKey,
        onSubmit: () async {
          if (_editEvalFormKey.currentState!.validate()) {
            final updated = widget.eval.copyWith(
              region: _controllers[0].text,
              action: _controllers[1].text,
              rom: int.tryParse(_controllers[2].text),
              vas: int.tryParse(_controllers[3].text),
              hx: _controllers[4].text,
              sx: _controllers[5].text,
            );
            await evalProvider.updateEvaluation(updated);
            ref.read(currentPageProvider.notifier).state = Pages.patient;
          }
        },
      ),
    );
  }
}
