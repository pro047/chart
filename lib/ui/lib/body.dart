import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/ui/provider/page_provider.dart';
import 'package:chart/view/evaluation/crud/evaluation_add_view.dart';
import 'package:chart/view/evaluation/detail/evaluation_detail_view.dart';
import 'package:chart/view/patient/patient_info/patient_introduce_view.dart';
import 'package:chart/view/patient/patient_main_view.dart';
import 'package:chart/view/plan/plan.dart';
import 'package:chart/view/therapist/therapist_view.dart';
import 'package:flutter/material.dart';

Widget layoutBodyPages(Pages currentPage, PatientModel? patient) {
  switch (currentPage) {
    case Pages.therapist:
      return TherapistView();
    case Pages.patient:
      return PatientView();
    case Pages.plan:
      return Plan();
    case Pages.patientIntroduce:
      return _requiredPatietnPage(patient, () => PatientIntroduceView());
    case Pages.evaluationDetail:
      return _requiredPatietnPage(patient, () => EvaluationDetailView());
    case Pages.addEvaluation:
      return _requiredPatietnPage(patient, () => EvaluationAddView());
  }
}

Widget _requiredPatietnPage(PatientModel? patient, Function() builder) {
  return patient != null
      ? builder()
      : Center(child: Text('please select patient'));
}
