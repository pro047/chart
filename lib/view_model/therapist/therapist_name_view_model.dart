import 'dart:async';
import 'package:chart/model/repository/therapist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistNameViewModel extends AsyncNotifier<String> {
  final TherapistNameRepository _therapistNameRepository =
      TherapistNameRepository();

  @override
  FutureOr<String> build() async {
    final therapistName = await _therapistNameRepository.getTherapistName();
    print(therapistName);
    return therapistName;
  }
}

final therapistNameViewModelProvider =
    AsyncNotifierProvider<TherapistNameViewModel, String>(() {
      return TherapistNameViewModel();
    });
