import 'package:chart/model/datasource/therapist/therapist_name_datasource.dart';

class TherapistNameRepository {
  final TherapistNameDatasource datasource = TherapistNameDatasource();

  Future<String> getTherapistName() async {
    print('repo');
    print('dg: ${datasource.getTherapistName()}');
    return await datasource.getTherapistName();
  }
}
