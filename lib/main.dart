import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/config/db.dart';
import 'package:chart/ui/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseHelper.instance.database;
  final tables = await db.rawQuery(
    'SELECT name FROM sqlite_master WHERE type="table"',
  );
  print('현재 테이블 목록 : $tables');
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
