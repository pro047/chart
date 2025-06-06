import 'package:chart/view_model/patient/recent_patient/recent_patient_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class RecentPatientsCardView extends ConsumerWidget {
  const RecentPatientsCardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentPatients = ref.watch(recentPatientCardViewModelrProvider);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            recentPatients.when(
              data: (patients) => patients.isEmpty
                  ? ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      tileColor: Colors.grey[100],
                      title: Center(child: Text('최근 등록한 환자가 없습니다')),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: patients.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 6),
                      itemBuilder: (_, index) {
                        final patient = patients[index];
                        final visited = DateFormat(
                          'yyyy-MM-dd',
                        ).format(patient.firstVisit);

                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          tileColor: Colors.grey[100],
                          leading: CircleAvatar(child: Text(patient.name[0])),
                          title: Text(patient.name),
                          subtitle: Text('첫 내원일: $visited'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        );
                      },
                    ),
              error: (e, _) => Text('에러 발생 : $e'),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );

    // return recentPatients.when(
    //   data: (patients) => ListView.builder(
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     itemCount: patients.length,
    //     itemBuilder: (_, index) {
    //       final patient = patients[index];
    //       return Card(
    //         margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12),
    //         ),
    //         elevation: 3,
    //         child: ListTile(
    //           leading: CircleAvatar(child: Text(patient.name[0])),
    //           title: Text(patient.name),
    //           subtitle: Text('${patient.firstVisit}'),
    //           trailing: Icon(Icons.arrow_forward_ios, size: 16),
    //         ),
    //       );
    //     },
    //   ),
    //   error: (e, _) => Text('에러 발생 : $e '),
    //   loading: () => CircularProgressIndicator(),
    // );
  }
}
