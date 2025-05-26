import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/patient/patient_main_view.dart';
import 'package:chart/view_model/patient/patient_group/patient_group_view_model.dart';
import 'package:chart/view_model/patient/patient_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';

class PatientDeleteDialog extends ConsumerStatefulWidget {
  const PatientDeleteDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PatientDeleteDialogState();
}

class _PatientDeleteDialogState extends ConsumerState<PatientDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);
    if (patientId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return SizedBox.shrink();
    }

    final patientVm = ref.read(patientViewModelProvider.notifier);
    final groupVm = ref.read(groupedPatientsInitialProvider.notifier);

    return AlertDialog(
      title: Text('삭제'),
      content: Text('정말 삭제하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () async {
            try {
              await patientVm.deleteInfo(patientId);
              groupVm.deletePatientInList(patientId);
              Navigator.pop(context);
              Future.microtask(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PatientView()),
                );
              });
            } catch (err) {
              print('delete err : $err');
              Navigator.pop(context);
            }
          },
          child: Text('삭제'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
      ],
    );
  }
}
