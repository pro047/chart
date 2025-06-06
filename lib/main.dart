// import 'package:chart/config/reset_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/config/db.dart';
import 'package:chart/ui/layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // resetDb();

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
    return MaterialApp(
      theme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: const Layout(),
    );
  }
}
