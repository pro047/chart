import 'package:chart/view/patient/patient_detail.dart';
import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  const Patient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('환자를 선택해주세요'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientDetail()),
                    );
                  },
                  child: Text('환자 추가하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
