import 'package:chart/ui/lib/tab_keys.dart';
import 'package:chart/ui/provider/tab_provider.dart';
import 'package:chart/view/patient/patient_main_view.dart';
import 'package:chart/view/plan/plan.dart';
import 'package:chart/view/therapist/therapist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyLayout extends ConsumerWidget {
  const BodyLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabProvider);

    print('body layout build');
    print('patientKey: ${Tabkeys.patientKey}');
    print('therapistKey: ${Tabkeys.therapistKey}');
    print('planKey: ${Tabkeys.planKey}');

    return IndexedStack(
      index: currentIndex,
      children: [
        _buildTabNavigator(
          key: Tabkeys.therapistKey,
          initialPage: const TherapistView(),
        ),
        _buildTabNavigator(
          key: Tabkeys.patientKey,
          initialPage: const PatientView(),
        ),
        _buildTabNavigator(key: Tabkeys.planKey, initialPage: const Plan()),
      ],
    );
  }
}

Widget _buildTabNavigator({
  required GlobalKey<NavigatorState> key,
  required Widget initialPage,
}) {
  return Navigator(
    key: key,
    onGenerateRoute: (settings) {
      return MaterialPageRoute(builder: (_) => initialPage);
    },
  );
}
