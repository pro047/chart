import 'package:chart/model/model/evlauation/evaluation_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EvaluationFormView extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final List<EvaluationFieldModel> fields;
  final VoidCallback onSubmit;

  const EvaluationFormView({
    super.key,
    required this.fields,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ...fields.map(
              (field) => TextFormField(
                controller: field.controller,
                decoration: InputDecoration(hintText: field.hintText),
                keyboardType: field.inputType,
              ),
            ),
            TextButton(onPressed: onSubmit, child: Text('저장')),
          ],
        ),
      ),
    );
  }
}
