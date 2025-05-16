import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/ui/provider/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const hideAppBarPages = [Pages.patientIntroduce, Pages.evaluationDetail];

PreferredSizeWidget? appbar(
  BuildContext context,
  Pages currentPage,
  WidgetRef ref,
) {
  if (hideAppBarPages.contains(currentPage)) return null;

  return AppBar(
    automaticallyImplyLeading: false,
    title: Text('chartpt'),
    leading:
        currentPage == Pages.therapist
            ? null
            : Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
              },
            ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginView()),
            (route) => false,
          );
          ref.read(authStateProvider.notifier).logout();
        },
        icon: Icon(Icons.logout),
      ),
    ],
  );
}
