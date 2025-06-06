import 'package:chart/config/db.dart';
import 'package:chart/model/model/therapist/data/therapist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistDatasource {
  Future<TherapistModel> getTherapistInfo(int userId) async {
    try {
      final db = await DatabaseHelper.instance.database;

      print('userId : $userId');

      final result = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (result.isEmpty) throw Exception('사용자 정보가 없습니다');
      print('result : ${result.first.keys}');
      return TherapistModel.fromMap(result.first);
    } catch (err) {
      throw Exception('datasource error : $err');
    }
  }
}

final therapistNameDatasourceProvider = Provider(
  (ref) => TherapistDatasource(),
);
