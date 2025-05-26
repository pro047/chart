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

  void addPatientInList(PatientModel patient) async {
    try {
      if (state case AsyncData(:final value)) {
        if (value.any((e) => e.id == patient.id)) return;
        state = AsyncData([...value, patient]);
      }
    } catch (err, st) {
      state = AsyncError(err, st);
      throw Exception('추가 실패 : $err');
    }
  }

  void deletePatientInList(int patientId) async {
    try {
      if (state case AsyncData(:final value)) {
        state = AsyncData(value.where((e) => e.id != patientId).toList());
      }
    } catch (err, st) {
      state = AsyncError(err, st);
      throw Exception('삭제 실패  $err');
    }
  }
}

final groupedPatientsInitialProvider =
    AsyncNotifierProvider<GroupedPatientsInitial, List<PatientModel>>(() {
      return GroupedPatientsInitial();
    });

final groupedPatientsMapProvider =
    Provider<AsyncValue<Map<String, List<PatientModel>>>>((ref) {
      print('called gpmp');
      final patients = ref.watch(groupedPatientsInitialProvider);

      return patients.when(
        data: (list) => AsyncData(groupByInitial(list)),
        error: (e, st) => AsyncError(e, st),
        loading: () => AsyncLoading(),
      );
    });
