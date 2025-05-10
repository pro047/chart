import 'dart:async';

import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/model/repository/patient/patient_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientViewModel extends AsyncNotifier<List<PatientModel>> {
  late final PatientRepository _repository;

  @override
  FutureOr<List<PatientModel>> build() async {
    _repository = ref.read(patientRepositoryProvider);
    return [];
  }

  Future<PatientModel> getInfoById(int id) async {
    return await _repository.fetchPatientInfoById(id);
  }

  Future<PatientModel> addInfo(PatientModel patient) async {
    print('[vm ok]');
    return await _repository.savePatientInfo(patient);
  }

  Future<void> updateInfo(PatientModel patient) async {
    await _repository.updatePatientInfo(patient);
    final newList = [...state.value!];
    final index = newList.indexWhere((e) => e.id == patient.id);
    if (index != -1) {
      newList[index] = patient;
    }
    state = AsyncData(newList);
  }

  Future<void> deleteInfo(int id) async {
    await _repository.deletePatientInfo(id);
    state = AsyncData([...state.value!..removeWhere((e) => e.id == id)]);
  }
}

final patientViewModelProvider =
    AsyncNotifierProvider<PatientViewModel, List<PatientModel>>(() {
      return PatientViewModel();
    });
