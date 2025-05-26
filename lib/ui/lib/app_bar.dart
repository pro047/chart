import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

PreferredSizeWidget? appbar(BuildContext context, WidgetRef ref) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text('chartpt'),
    leading: Builder(
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
