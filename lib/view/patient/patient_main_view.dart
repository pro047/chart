import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/patient/patient_dialog.dart';

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
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return PatientDialog();
                  },
                );
              },
              child: Text('환자추가하기'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
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
