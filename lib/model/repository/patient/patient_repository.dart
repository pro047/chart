import 'package:chart/model/datasource/patient/patient_datasource.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientRepository {
  final PatientDatasource _datasource;

  PatientRepository(this._datasource); // 의존성 주입

  Future<List<PatientModel>> getPatientInfo(String name) {
    return _datasource.getPatientInfo(name);
  }

  Future<void> savePatientInfo(PatientModel patientInfo) {
    return _datasource.savePatientInfo(patientInfo);
  }
}

final patientRepositoryProvider = Provider((ref) {
  final datasource = ref.read(patientDatasourceProvider);
  return PatientRepository(datasource);
});
