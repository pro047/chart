import 'package:chart/model/datasource/therapist.dart';
import 'package:chart/model/model/therapist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:chart/model/repository/therapist.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // FFI 기반으로 sqflite 테스트용 DB 준비
  sqfliteFfiInit();

  late Database db;
  late TherapistNameRepository repo;

  setUp(() async {
    // 메모리 DB 생성 (앱에 영향 없음)
    databaseFactory = databaseFactoryFfi;
    db = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY,
          email TEXT,
          name TEXT
        )
      ''');
        await db.insert('users', {'email': 'test@email.com', 'name': '홍길동'});
      },
    );

    repo = TherapistNameRepository();

    SharedPreferences.setMockInitialValues({'loggedEmail': 'test@email.com'});
  });
  test('이름이 가져와 지는지', () async {
    final prefs = await SharedPreferences.getInstance();
    final savedEamil = prefs.getString('loggedEmail');
    final email = 'test@email.com';
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      print('saved : $savedEamil');
      final therapistName = TherapistNameModel.fromMap(result.first);
      print('therapistname: ${therapistName.name}');
      return therapistName.name;
    } else {
      throw Error();
    }
  });

  final TherapistNameRepository therapistNameRepository =
      TherapistNameRepository();

  final TherapistNameDatasource datasource = TherapistNameDatasource();

  test('치료사 이름', () async {
    print('repo');
    final name = await datasource.getTherapistName();
    print('dg: $name');

    return name;
  });
}
