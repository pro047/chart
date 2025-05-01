import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> resetDb() async {
  if (kDebugMode) {
    final path = join(await getDatabasesPath(), 'chartpt.db');
    await deleteDatabase(path);
    debugPrint('db reset');
  }
}
