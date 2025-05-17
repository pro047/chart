import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Pages {
  therapist,
  patient,
  plan,
  patientIntroduce,
  evaluationDetail,
  addEvaluation,
}

final currentPageProvider = StateProvider<Pages>((ref) => Pages.therapist);
