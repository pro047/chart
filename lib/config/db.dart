import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'chartpt.db';
  static const _databaseVersion = 2;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER NOT NULL UNIQUE PRIMARY KEY, email TEXT NOT NULL UNIQUE, password TEXT NOT NULL, name TEXT NOT NULL)',
        );

        await db.execute('''
    CREATE TABLE patients (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      age INTEGER NOT NULL,
      gender TEXT NOT NULL,
      firstVisit TEXT NOT NULL,
      occupation TEXT DEFAULT "Unknown"
    )
  ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
      CREATE TABLE patients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        gender TEXT NOT NULL,
        firstVisit TEXT NOT NULL,
        occupation TEXT DEFAULT "Unknown"
      )
    ''');
        }
      },
    );
  }
}
