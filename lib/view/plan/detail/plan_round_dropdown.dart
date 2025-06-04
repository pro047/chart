import 'package:chart/view/plan/detail/plan_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:chart/view_model/plan/provider/plan_round_provider.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';

class PlanRoundDropdown extends ConsumerStatefulWidget {
  const PlanRoundDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanRoundDropdownState();
}

class _PlanRoundDropdownState extends ConsumerState<PlanRoundDropdown> {
  @override
  Widget build(BuildContext context) {
    final patientId = ref.watch(patientIdProvider);

    if (patientId == null) return Center(child: Text('No patient selected'));

    final planState = ref.watch(planViewModelProvider(patientId));
    final selectedRound = ref.watch(planRoundProvider);

    return planState.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(child: Text('등록된 계획이 없습니다'));
        }

        final rounds = data.map((e) => e.round).toSet().toList()..sort();
        print('[rounds]: $rounds');

        if (rounds.isEmpty) {
          return const Center(child: Text('회차 정보가 없습니다'));
        }

        final currentRound = rounds.contains(selectedRound)
            ? selectedRound
            : rounds.first;
        print('[currentRound] : $currentRound');

        if (!rounds.contains(selectedRound)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(planRoundProvider.notifier).state = rounds.first;
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
                  ref.read(planRoundProvider.notifier).state = value;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlanInfoView()),
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
