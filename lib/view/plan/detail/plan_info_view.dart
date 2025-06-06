import 'package:chart/model/model/plan/plan_model.dart';
import 'package:chart/view/plan/crud/plan_delete_view.dart';
import 'package:chart/view/plan/detail/plan_round_dropdown.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/view_model/plan/plan_view_model.dart';
import 'package:chart/view_model/plan/provider/plan_round_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/patient/patient_info/patient_introduce_view.dart';
import 'package:chart/view/plan/crud/plan_add_view.dart';
import 'package:chart/view/plan/crud/plan_edit_view.dart';

class PlanInfoView extends ConsumerWidget {
  const PlanInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patient = ref.watch(patientProvider);
    final patientId = ref.watch(patientIdProvider);

    if (patient == null || patientId == null) {
      return Center(child: Text('해당 환자의 치료 계획이 없습니다'));
    }

    final round = ref.watch(planRoundProvider);
    print('round $round');

    if (round == null) {
      final roundNotifier = ref.read(planRoundProvider.notifier);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        roundNotifier.state = 1;
      });
      return SizedBox.shrink();
    }

    final planAsync = ref.watch(planViewModelProvider(patientId));
    final PlanModel? plan = planAsync.whenOrNull(
      data: (data) {
        final filtered = data.where((e) => e.round == round).toList();
        if (filtered.isEmpty) {
          return null;
        }
        return filtered.first;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(plan?.round != null ? '$round 회차 치료계획' : ''),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PatientIntroduceView()),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(content: PlanRoundDropdown()),
              );
            },
            icon: Icon(Icons.list),
            label: Text('회차 선택'),
          ),
          PopupMenuButton(
            onSelected: (value) {
              switch (value) {
                case 'add':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlanAddView()),
                  );
                  break;
                case 'edit':
                  if (plan != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlanEditView(plan: plan),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('알림'),
                        content: Text('해당 회차의 평가가 없습니다'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('확인'),
                          ),
                        ],
                      ),
                    );
                  }
                  break;
                case 'delete':
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return PlanDeleteDialog();
                    },
                  );
                  break;
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'add', child: Text('추가')),
              PopupMenuItem(value: 'edit', child: Text('수정')),
              PopupMenuItem(value: 'delete', child: Text('삭제')),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: planAsync.when(
          data: (data) {
            if (plan == null) {
              return Column(
                children: [
                  Center(child: Text('치료 계획이 없습니다')),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PlanAddView()),
                      );
                    },
                    child: Text('환자 추가 하기'),
                  ),
                ],
              );
            }

            return _buildPlanList(plan);
          },
          error: (e, _) => Text('Error : $e'),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Widget _buildPlanList(PlanModel data) {
  return Column(
    children: [
      Text('STG : ${data.stg}'),
      Text('LTG : ${data.ltg}'),
      Text('Teatment Plan : ${data.treatmentPlan}'),
      Text('Exercise Plan : ${data.exercisePlan}'),
      Text('Homework : ${data.homework}'),
    ],
  );
}

            // final filtered = data.where((e) => e.round == round).toList();
            // if (filtered.isEmpty) {
            //   return Text('해당 회차의 계획이 없습니다');
            // }
            // final plan = filtered.first;

            // return _buildPlanList(plan);