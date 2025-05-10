import 'package:chart/view/evaluation/first_evaluation_view.dart';
import 'package:chart/view_model/patient/patient_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientDrawer extends ConsumerStatefulWidget {
  const PatientDrawer({super.key});

  @override
  ConsumerState<PatientDrawer> createState() => _PatientDrawerState();
}

class _PatientDrawerState extends ConsumerState<PatientDrawer> {
  @override
  Widget build(BuildContext context) {
    final group = ref.watch(groupedPatientsMapProvider);
    print(group);

    return ListView(
      children:
          group.entries.map((entry) {
            final initial = entry.key;
            final patientName = entry.value;

            return ExpansionTile(
              title: Text(initial),
              children:
                  patientName
                      .map(
                        (i) => ListTile(
                          title: TextButton(
                            onPressed: () {
                              print(i.id);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (_) => EvaluationView(patientId: i.id),
                                ),
                              );
                            },
                            child: Text(i.name),
                          ),
                        ),
                      )
                      .toList(),
            );
          }).toList(),
    );
  }
}
