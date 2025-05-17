import 'package:chart/ui/provider/page_provider.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/patient/provider/round_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoundDropdown extends ConsumerStatefulWidget {
  const RoundDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoundDropdownState();
}

class _RoundDropdownState extends ConsumerState<RoundDropdown> {
  int? selectedRound;

  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);

    if (patientId == null) return Center(child: Text('No patient selected'));

    final evalState = ref.watch(evaluationViewModelProvider(patientId));
    return evalState.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text('등록된 평가가 없습니다'));
        }

        final rounds = data.map((e) => e.round).toSet().toList()..sort();

        selectedRound ??= rounds.first;

        return DropdownButton(
          value: selectedRound,
          items:
              rounds
                  .map(
                    (round) => DropdownMenuItem<int>(
                      value: round,
                      child: Text('$round회차'),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedRound = value;
                ref.read(roundProvider.notifier).state = value;
                ref.watch(currentPageProvider.notifier).state =
                    Pages.evaluationDetail;
              });
            }
          },
          menuMaxHeight: 400,
        );
      },
      error: (e, st) => Text('$e'),
      loading: () => CircularProgressIndicator(),
    );
  }
}
