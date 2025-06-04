import 'dart:async';

import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/model/repository/patient/patient_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentPatientCardViewModel extends AsyncNotifier<List<PatientModel>> {
  @override
  FutureOr<List<PatientModel>> build() {
    return ref.read(patientRepositoryProvider).fetchRecentPatients();
  }
}

final recentPatientCardViewModelrProvider =
    AsyncNotifierProvider<RecentPatientCardViewModel, List<PatientModel>>(
      () => RecentPatientCardViewModel(),
    );
