import 'dart:async';
import 'package:chart/model/repository/therapist/therapist_name_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistNameViewModel extends FamilyAsyncNotifier<String, int> {
  TherapistNameRepository get _repository =>
      ref.read(therapistNameRepositoryProvider);

  @override
  FutureOr<String> build(int userId) async {
    return await _repository.getTherapistName(userId);
  }
}

final therapistNameViewModelProvider =
    AsyncNotifierProvider.family<TherapistNameViewModel, String, int>(() {
      return TherapistNameViewModel();
    });
