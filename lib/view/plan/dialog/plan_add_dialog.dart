import 'package:chart/view/plan/crud/plan_add_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanAddDialog extends ConsumerStatefulWidget {
  const PlanAddDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlanAddDialogState();
}

class _PlanAddDialogState extends ConsumerState<PlanAddDialog> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);
    if (patientId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return SizedBox.shrink();
    }

    return AlertDialog(
      title: Text('계획 추가'),
      content: Text('계획이 없습니다\n계획을 추가하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PlanAddView()),
            );
          },
          child: Text('추가하러가기'),
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
