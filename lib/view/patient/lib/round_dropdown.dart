import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/evaluation/detail/evaluation_detail_view.dart';
import 'package:chart/view_model/evaluation/evaluation_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/patient/provider/round_provider.dart';

class RoundDropdown extends ConsumerStatefulWidget {
  const RoundDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoundDropdownState();
}

class _RoundDropdownState extends ConsumerState<RoundDropdown> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);

    if (patientId == null) return Center(child: Text('No patient selected'));

    final evalState = ref.watch(evaluationViewModelProvider(patientId));
    final selectedRound = ref.watch(roundProvider);

    return evalState.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text('등록된 평가가 없습니다'));
        }

        final rounds = data.map((e) => e.round).toSet().toList()..sort();
        print('[rounds]: $rounds');

        if (rounds.isEmpty) {
          return const Center(child: Text('회차 정보가 없습니다'));
        }

        final currentRound = selectedRound ?? rounds.first;
        print('[currentRound] : $currentRound');

        if (!rounds.contains(selectedRound)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(roundProvider.notifier).state = rounds.first;
          });
        }

        return DropdownButton<int>(
          value: currentRound,
          items: rounds
              .map(
                (round) => DropdownMenuItem<int>(
                  value: round,
                  child: Text('$round회차'),
                ),
              )
              .toList(),
          onChanged: (value) {
            try {
              if (value != null) {
                setState(() {
                  print('select value: $value');
                  ref.read(roundProvider.notifier).state = value;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EvaluationDetailView()),
                  );
                });
              }
            } catch (err) {
              print('dropdown err : $err');
              throw Exception('드롭 다운 메뉴 선택 오류');
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
