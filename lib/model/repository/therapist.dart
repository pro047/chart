import 'package:chart/model/datasource/therapist.dart';

class TherapistNameRepository {
  final TherapistNameDatasource datasource = TherapistNameDatasource();

  Future<String> getTherapistName() async {
    print('repo');
    print('dg: ${datasource.getTherapistName()}');
    return await datasource.getTherapistName();
  }
}
