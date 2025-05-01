import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class PatientDialog extends ConsumerStatefulWidget {
  const PatientDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientDialogState();
}

class _PatientDialogState extends ConsumerState<PatientDialog> {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _occupationController = TextEditingController();

  Gender _dropdownValue = Gender.male;

  @override
  Widget build(BuildContext context) {
    final patientState = ref.read(patientViewModelProvider.notifier);
    return AlertDialog(
      title: Text('환자 등록'),
      content: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(label: Text('이름을 입력해주세요')),
                validator:
                    (value) =>
                        value == null || value.isEmpty ? '이름을 입력해주세요' : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(label: Text('나이를 입력해주세요')),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final number = int.tryParse(value ?? '');
                  return number == null ? '나이를 입력해주세요' : null;
                },
              ),
              DropdownButtonFormField<Gender>(
                value: _dropdownValue,
                icon: Icon(Icons.arrow_downward),
                items:
                    Gender.values.map<DropdownMenuItem<Gender>>((Gender value) {
                      return DropdownMenuItem<Gender>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                onChanged: (Gender? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _dropdownValue = newValue;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _occupationController,
                decoration: InputDecoration(label: Text('직업을 입력해주세요')),
                validator: (value) {
                  return value == null || value.isEmpty ? '직업을 입력해주세요' : null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(Duration(microseconds: 50));
            if (!_formkey.currentState!.validate()) return;
            final newPatientInfo = PatientModel(
              name: _nameController.text,
              age: int.parse(_ageController.text),
              gender: _dropdownValue,
              firstVisit: DateTime.now(),
              occupation: _occupationController.text,
            );
            await patientState.saveInfo(newPatientInfo);
            if (!context.mounted) return;
            Navigator.of(context).pop();
          },
          child: Text('등록'),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: Text('취소')),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    super.dispose();
  }
}
