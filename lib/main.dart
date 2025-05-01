import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authStateProvider).isLoggedIn;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Layout() : LoginView(),
    );
  }
}
