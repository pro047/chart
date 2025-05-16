import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/view/evaluation/first_evaluation_view.dart';
import 'package:chart/view_model/patient/patient_group.dart';
import 'package:chart/view_model/patient/patient_provider.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

// enum + switch pattern

enum DialogState { form, success }

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

  DialogState _state = DialogState.form;

  Gender _dropdownValue = Gender.male;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_state == DialogState.form ? '환자 등록' : '등록 완료'),
      content:
          _state == DialogState.form ? _buildForm() : _buildSuccessMessage(),
      actions:
          _state == DialogState.form
              ? [
                TextButton(onPressed: _handleSubmit, child: Text('등록')),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소'),
                ),
              ]
              : [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    Future.microtask(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FirstEvaluationView(),
                        ),
                      );
                    });
                  },
                  child: Text('완료', textAlign: TextAlign.center),
                ),
              ],
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _nameController,
              decoration: InputDecoration(label: Text('이름을 입력해주세요')),
              validator:
                  (value) =>
                      value == null || value.isEmpty ? '이름을 입력해주세요' : null,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _occupationController,
              decoration: InputDecoration(label: Text('직업을 입력해주세요')),
              validator: (value) {
                return value == null || value.isEmpty ? '직업을 입력해주세요' : null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check),
        SizedBox(height: 20),
        Text('등록이 완료되었습니다', textAlign: TextAlign.center),
      ],
    );
  }

  // todo : view-model로 뺴기
  void _handleSubmit() async {
    if (!_formkey.currentState!.validate()) return;
    final newPatientInfo = PatientModel(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      gender: _dropdownValue,
      firstVisit: DateTime.now(),
      occupation: _occupationController.text,
    );

    final savedPatient = await ref
        .read(patientViewModelProvider.notifier)
        .addInfo(newPatientInfo);

    print('savedPatient.firstvisit : ${savedPatient.firstVisit}');
    ref
        .read(groupedPatientsInitialProvider.notifier)
        .addPatientList(savedPatient);

    ref.read(patientIdProvider.notifier).state = savedPatient.id;
    ref.read(patientProvider.notifier).state = savedPatient;

    if (!context.mounted) return;
    setState(() {
      _state = DialogState.success;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _occupationController.dispose();
    super.dispose();
  }
}
