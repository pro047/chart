import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/ui/lib/body.dart';
import 'package:chart/ui/lib/bottom_nav_bar.dart';
import 'package:chart/ui/provider/tab_provider.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedin = ref.watch(authStateProvider).isLoggedIn;
    final currentIndex = ref.watch(currentTabProvider);

    return Scaffold(
      body: isLoggedin ? const BodyLayout() : const LoginView(),
      bottomNavigationBar: isLoggedin ? bottomNavbar(currentIndex, ref) : null,
    );
  }
}
