import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/view/patient/lib/patient_drawer_view.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:chart/ui/lib/app_bar.dart';
import 'package:chart/ui/lib/body.dart';
import 'package:chart/ui/lib/bottom_nav_bar.dart';
import 'package:chart/ui/provider/page_provider.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(currentPageProvider);
    final patient = ref.watch(patientProvider);

    return Scaffold(
      appBar: appbar(context, currentPage, ref),
      drawer: Drawer(child: PatientDrawer()),
      body: layoutBodyPages(currentPage, patient),
      bottomNavigationBar: bottomNavbar(currentPage, ref),
    );
  }
}
