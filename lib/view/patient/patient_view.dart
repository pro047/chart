import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientView extends ConsumerStatefulWidget {
  const PatientView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientViewState();
}

class _PatientViewState extends ConsumerState<PatientView> {
  final TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(child: Text('환자를 선택해주세요')),
            TextButton(
              onPressed: () {
                showPatientRegisterDialog(context, ref);
              },
              child: Text('환자추가하기'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(hintText: '환자 이름으로 검색'),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showPatientRegisterDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  final patientState = ref.watch(patientViewModelProvider.notifier);
  final formkey = GlobalKey<FormState>();
  String dropdownValue = 'male';
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final occupationController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('환자 등록'),
            content: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(label: Text('이름을 입력해주세요')),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? '이름을 입력해주세요'
                                : null,
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(label: Text('나이를 입력해주세요')),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      final number = int.tryParse(value ?? '');
                      return number == null ? '나이를 입력해주세요' : null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    items:
                        <String>[
                          'male',
                          'female',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      }
                    },
                  ),
                  TextFormField(
                    controller: occupationController,
                    decoration: InputDecoration(label: Text('직업을 입력해주세요')),
                    validator: (value) {
                      return value == null || value.isEmpty
                          ? '직업을 입력해주세요'
                          : null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  if (!formkey.currentState!.validate()) return;
                  final selectedGender =
                      {
                        "male": Gender.male,
                        "female": Gender.female,
                      }[dropdownValue] ??
                      Gender.male;
                  final newPatientInfo = PatientModel(
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    gender: selectedGender,
                    firstVisit: DateTime.now(),
                    occupation: occupationController.text,
                  );
                  await patientState.saveInfo(newPatientInfo);
                  Navigator.pop(context);
                },
                child: Text('등록'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('취소'),
              ),
            ],
          );
        },
      );
    },
  );
  nameController.dispose();
  ageController.dispose();
  occupationController.dispose();
}
