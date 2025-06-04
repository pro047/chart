import 'package:flutter/widgets.dart';

class PlanFieldModel {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final TextInputType inputType;

  PlanFieldModel({
    required this.controller,
    required this.label,
    required this.hintText,
    this.inputType = TextInputType.text,
  });
}
