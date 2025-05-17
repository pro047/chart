import 'package:flutter/widgets.dart';

class EvaluationFieldModel {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType inputType;

  EvaluationFieldModel({
    required this.controller,
    required this.label,
    required this.hintText,
    this.inputType = TextInputType.text,
  });
}
