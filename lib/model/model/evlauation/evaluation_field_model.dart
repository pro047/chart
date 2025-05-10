import 'package:flutter/widgets.dart';

class EvaluationFieldModel {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;

  EvaluationFieldModel({
    required this.controller,
    required this.hintText,
    this.inputType = TextInputType.text,
  });
}
