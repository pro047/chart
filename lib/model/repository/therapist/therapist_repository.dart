import 'package:chart/model/datasource/therapist/therapist_datasource.dart';
import 'package:chart/model/model/therapist/data/therapist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistRepository {
  final TherapistDatasource _datasource;

  TherapistRepository(this._datasource);

  Future<TherapistModel> getTherapistInfo(int userId) async {
    try {
      final result = await _datasource.getTherapistInfo(userId);
      print('repo result : $result');
      return result;
    } catch (err, st) {
      print('repo st: $st');
      throw Exception('레포에서 에러 발생 : $err');
    }
  }
}

final therapistRepositoryProvider = Provider((ref) {
  final datasource = ref.read(therapistNameDatasourceProvider);
  return TherapistRepository(datasource);
});
