import 'package:chart/model/datasource/therapist/therapist_name_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistNameRepository {
  final TherapistNameDatasource _datasource;

  TherapistNameRepository(this._datasource);

  Future<String> getTherapistName(int userId) async {
    print('repo');
    print('dg: ${_datasource.getTherapistName()}');
    return await _datasource.getTherapistName();
  }
}

final therapistNameRepositoryProvider = Provider((ref) {
  final datasource = ref.read(therapistNameDatasourceProvider);
  return TherapistNameRepository(datasource);
});
