import 'package:chart/ui/lib/app_bar.dart';
import 'package:chart/view/patient/lib/patient_drawer_view.dart';
import 'package:chart/view/patient/lib/patient_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/patient/dialog/patient_dialog.dart';

class PatientView extends ConsumerStatefulWidget {
  const PatientView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PatientViewState();
}

class _PatientViewState extends ConsumerState<PatientView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, ref),
      drawer: PatientDrawer(),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PatientSearch(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
