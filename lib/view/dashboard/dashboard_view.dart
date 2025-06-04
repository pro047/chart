import 'package:chart/view/dashboard/recent_patients/recent_patients_card_view.dart';
import 'package:chart/view/dashboard/therapist_welcome_card.dart/welcome_card.dart';
import 'package:chart/view/dashboard/todo_section/todo_card.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TherapistWelcomeCard(),

            _sectionTitle(context, '오늘 할 일'),
            TherapistTodoCard(),
            _divider(),
            _sectionTitle(context, '최근 등록한 환자'),
            RecentPatientsCardView(),
          ],
        ),
      ),
    );
  }
}

Widget _sectionTitle(BuildContext context, String text) => Padding(
  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
  child: Text(text, style: Theme.of(context).textTheme.titleMedium),
);

Widget _divider() => Padding(
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey.shade200,
  ),
);
