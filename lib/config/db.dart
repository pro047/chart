import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'chartpt.db';
  static const _databaseVersion = 5;

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

        await db.execute(
          'CREATE TABLE patients (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER NOT NULL,gender TEXT NOT NULL, firstVisit TEXT NOT NULL, occupation TEXT DEFAULT "Unknown")',
        );
        try {
          await db.execute(
            'CREATE TABLE evaluations (id INTEGER PRIMARY KEY AUTOINCREMENT, createdAt TEXT DEFAULT CURRENT_TIMESTAMP,patientId INTEGER NOT NULL, round INTEGER NOT NULL,rom INTEGER, vas INTEGER, region TEXT, action TEXT, hx TEXT, sx TEXT, FOREIGN KEY (patientId) REFERENCES patients(id) ON DELETE CASCADE)',
          );
          print('테이블 생성 성공');
        } catch (e) {
          print('$e');
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 4) {
          await db.execute(
            'ALTER TABLE evaluations ADD COLUMN createdAt TEXT DEFATULT CURRENT_TIMESTAMP',
          );
          print('db 업그레이드 완료 : 컬럼 추가 됨');
        }
      },
    );
  }
}
