import 'package:chart/model/model/plan/plan_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanFormView extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final List<PlanFieldModel> fields;
  final VoidCallback onSubmit;

  const PlanFormView({
    super.key,
    required this.formKey,
    required this.fields,
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
                decoration: InputDecoration(
                  labelText: field.label,
                  hintText: field.hintText,
                ),
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
