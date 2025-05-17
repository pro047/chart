import 'dart:async';

import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/model/repository/patient/patient_repository.dart';
import 'package:chart/view_model/patient/lib/hangul_parser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<PatientModel> sortedByInitial(List<PatientModel> patient) {
  patient.sort((a, b) {
    final aInitial = getInitialConsnant(a.name);
    final bInitial = getInitialConsnant(b.name);
    return aInitial.compareTo(bInitial);
  });
  return patient;
}

Map<String, List<PatientModel>> groupByInitial(List<PatientModel> patients) {
  final Map<String, List<PatientModel>> group = {};

  final sortedGroup = sortedByInitial(patients);

  for (final patient in sortedGroup) {
    final initial = getInitialConsnant(patient.name);
    group.putIfAbsent(initial, () => []);
    group[initial]!.add(patient);
  }
  return group;
}

class GroupedPatientsInitial extends AsyncNotifier<List<PatientModel>> {
  late final PatientRepository _repository;

  @override
  FutureOr<List<PatientModel>> build() async {
    print('build called');
    _repository = ref.read(patientRepositoryProvider);
    print('[fetch all data at vm]');
    return await _repository.fetchAllPatientInfo();
  }

  void addPatientList(PatientModel patient) async {
    if (state case AsyncData(:final value)) {
      state = await AsyncValue.guard(() async {
        print('value: $value');
        return await _repository.fetchAllPatientInfo();
      });
    }
  }
}

final groupedPatientsInitialProvider =
    AsyncNotifierProvider<GroupedPatientsInitial, List<PatientModel>>(() {
      return GroupedPatientsInitial();
    });

final groupedPatientsMapProvider = Provider<Map<String, List<PatientModel>>>((
  ref,
) {
  print('called gpmp');
  final patients = ref.watch(groupedPatientsInitialProvider);
  print(patients);
  if (!patients.hasValue) {
    throw Exception('no data in gpmp');
  }

  return groupByInitial(patients.value!);
});
