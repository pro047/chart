import 'dart:async';
import 'package:chart/model/model/therapist/data/therapist_model.dart';
import 'package:chart/model/repository/therapist/therapist_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistViewModel extends FamilyAsyncNotifier<TherapistModel, int> {
  TherapistRepository get _repository => ref.read(therapistRepositoryProvider);

  @override
  FutureOr<TherapistModel> build(int userId) async {
    print('[theraViewModel] build userID: $userId');
    return await _repository.getTherapistInfo(userId);
  }
}

final therapistViewModelProvider =
    AsyncNotifierProvider.family<TherapistViewModel, TherapistModel, int>(() {
      return TherapistViewModel();
    });
