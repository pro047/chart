import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/view_model/therapist/data/therapist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistProfileCard extends ConsumerWidget {
  const TherapistProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user;
    if (user == null) return Center(child: Text('해당 유저가 없습니다'));

    final theraAsync = ref.watch(therapistViewModelProvider(user.id));

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            theraAsync.when(
              data: (thera) => ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                tileColor: Colors.grey[100],
                leading: CircleAvatar(child: Text(thera.name[0])),
                title: Text('${thera.name} 치료사님'),
                subtitle: Column(
                  children: [Text(thera.hospital), Text(thera.email)],
                ),
              ),
              error: (e, _) => Text('에러 발생 : $e'),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
