import 'package:chart/view/plan/detail/plan_info_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:chart/view_model/plan/provider/plan_round_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanDeleteDialog extends ConsumerStatefulWidget {
  const PlanDeleteDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanDeleteDialogState();
}

class _PlanDeleteDialogState extends ConsumerState<PlanDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);
    final round = ref.watch(planRoundProvider);

    if (patientId == null || round == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return SizedBox.shrink();
    }

    final planProvider = ref.read(planViewModelProvider(patientId).notifier);

    return AlertDialog(
      title: Text('삭제'),
      content: Text('정말 삭제하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () async {
            try {
              await planProvider.deletePlan(patientId, round);

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PlanInfoView()),
                );
              }
            } catch (err) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('삭제 실패'),
                    content: Text(err.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('확인'),
                      ),
                    ],
                  ),
                );
              }
            }
          },
          child: Text('삭제'),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: Text('취소')),
      ],
    );
  }
}
