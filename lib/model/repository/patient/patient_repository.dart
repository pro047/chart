import 'package:chart/model/datasource/patient/patient_datasource.dart';
import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientRepository {
  final PatientDatasource _datasource;

  PatientRepository(this._datasource); // 의존성 주입

  Future<List<PatientModel>> fetchAllPatientInfo() async {
    final result = await _datasource.getAllPatientInfo();
    print('fetch patient all data ok');
    return result;
  }

  Future<PatientModel> fetchPatientInfoById(int id) async {
    return await _datasource.getPatientInfoById(id);
  }

  Future<PatientModel> savePatientInfo(PatientModel patientInfo) async {
    print('[repo ok]');
    return await _datasource.savePatientInfo(patientInfo);
  }

  Future<void> updatePatientInfo(PatientModel patient) async {
    await _datasource.updatePatientInfo(patient);
  }

  Future<void> deletePatientInfo(int id) async {
    await _datasource.deletePatientInfo(id);
  }
}

final patientRepositoryProvider = Provider((ref) {
  final datasource = ref.read(patientDatasourceProvider);
  return PatientRepository(datasource);
});
