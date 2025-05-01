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

  Future<void> saveInfo(PatientModel info) async {
    await _repository.savePatientInfo(info);
  }

  Future<List<PatientModel>> getInfo(String name) async {
    return await _repository.getPatientInfo(name);
  }
}

final patientViewModelProvider =
    AsyncNotifierProvider<PatientViewModel, List<PatientModel>>(() {
      return PatientViewModel();
    });
