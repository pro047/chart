import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/ui/provider/page_provider.dart';
import 'package:chart/view_model/patient/patient_group/patient_group.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDrawer extends ConsumerWidget {
  const PatientDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupedPatientsMapProvider);

    return ListView.builder(
      itemCount: group.length,
      itemBuilder: (context, index) {
        final initial = group.keys.elementAt(index);
        final patients = group[initial] ?? [];

        return ExpansionTile(
          title: Text(initial),
          children:
              patients
                  .map((patient) => _buildPatientTile(context, ref, patient))
                  .toList(),
        );
      },
    );
  }
}

Widget _buildPatientTile(
  BuildContext context,
  WidgetRef ref,
  PatientModel patient,
) {
  return ListTile(
    title: Text(patient.name),
    onTap: () => _handlePatientTileTap(context, ref, patient),
  );
}

void _handlePatientTileTap(
  BuildContext context,
  WidgetRef ref,
  PatientModel patient,
) {
  ref.read(patientIdProvider.notifier).state = patient.id;
  ref.read(patientProvider.notifier).state = patient;
  ref.read(currentPageProvider.notifier).state = Pages.patientIntroduce;
  Navigator.pop(context);
}
