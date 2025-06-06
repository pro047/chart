import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/ui/view/body.dart';
import 'package:chart/ui/view/bottom_nav_bar.dart';
import 'package:chart/ui/provider/tab_provider.dart';

class Layout extends ConsumerWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authStateProvider).isLoggedIn;
    final currentIndex = ref.watch(currentTabProvider);
    print('[layout] isLoggedIn : $isLoggedIn');

    return Scaffold(
      body: isLoggedIn ? const BodyLayout() : const LoginView(),
      bottomNavigationBar: isLoggedIn ? bottomNavbar(currentIndex, ref) : null,
    );
  }
}
