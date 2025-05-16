import 'package:chart/model/model/patient/patient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final patientIdProvider = StateProvider<int?>((ref) => null);

final patientProvider = StateProvider<PatientModel?>((ref) => null);
