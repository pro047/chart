import 'package:flutter/material.dart';

renderTextFormField({
  required String label,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  TextInputType? keyboardType,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      TextFormField(
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        textInputAction: TextInputAction.done,
      ),
      SizedBox(height: 20),
    ],
  );
}
