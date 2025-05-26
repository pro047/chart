import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/patient/provider/round_provider.dart';

class EvaluationDeleteDialog extends ConsumerStatefulWidget {
  const EvaluationDeleteDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EvaluationDeleteDialogState();
}

class _EvaluationDeleteDialogState
    extends ConsumerState<EvaluationDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);
    final round = ref.watch(roundProvider);
    if (patientId == null || round == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
      });
      return SizedBox.shrink();
    }

    final evalVm = ref.read(evaluationViewModelProvider(patientId).notifier);

    return AlertDialog(
      title: Text('삭제'),
      content: Text('정말 삭제하시겠습니까?'),
      actions: [
        TextButton(
          onPressed: () async {
            try {
              final evalId = await evalVm.findEvaluationIdByPatientIdAndRound(
                patientId,
                round,
              );

              print('evalId in evaldeleteview : $evalId');
              if (evalId == null) {
                throw Exception('해당 회차가 없습니다');
              }
              await evalVm.deleteEvaluationByPatientIdAndEvaluationId(
                patientId,
                evalId,
              );

              if (context.mounted) {
                Navigator.pop(context);
              }
            } catch (err) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('에러 발생'),
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
