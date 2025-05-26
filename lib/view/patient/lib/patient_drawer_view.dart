import 'package:chart/model/model/patient/patient_model.dart';
import 'package:chart/view/patient/patient_info/patient_introduce_view.dart';
import 'package:chart/view_model/patient/patient_group/patient_group_view_model.dart';
import 'package:chart/view_model/patient/provider/patient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDrawer extends ConsumerWidget {
  const PatientDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final group = ref.watch(groupedPatientsMapProvider);

    return group.when(
      data: ((data) => Drawer(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final initial = data.keys.elementAt(index);
            final patients = data[initial] ?? [];

            return ExpansionTile(
              title: Text(initial),
              children: patients
                  .map((patient) => _buildPatientTile(context, ref, patient))
                  .toList(),
            );
          },
        ),
      )),
      error: (e, st) => Text('에러 발생: $e'),
      loading: () => CircularProgressIndicator(),
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
  Navigator.pop(context);

  Future.microtask(() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PatientIntroduceView()));
  });
}
