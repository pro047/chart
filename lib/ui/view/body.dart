import 'package:chart/ui/constants/tab_keys.dart';
import 'package:chart/ui/provider/tab_provider.dart';
import 'package:chart/view/dashboard/dashboard_view.dart';
import 'package:chart/view/more/more_view.dart';
import 'package:chart/view/patient/patient_main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BodyLayout extends ConsumerWidget {
  const BodyLayout({super.key});

  //todo : 바디 정렬하기
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabProvider);

    return IndexedStack(
      index: currentIndex,
      children: [
        _buildTabNavigator(
          key: Tabkeys.dashboardKey,
          initialPage: const DashboardView(),
        ),
        _buildTabNavigator(
          key: Tabkeys.patientKey,
          initialPage: const PatientView(),
        ),
        _buildTabNavigator(key: Tabkeys.morekey, initialPage: const MoreView()),
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
