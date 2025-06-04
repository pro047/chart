import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/view_model/dashboard/therapist_name_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistWelcomeCard extends ConsumerWidget {
  const TherapistWelcomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateProvider).user;
    if (user == null) return Center(child: Text('해당 유저가 없습니다'));

    final therapistName = ref.watch(therapistNameViewModelProvider(user.id));

    return Padding(
      padding: EdgeInsets.all(16),
      child: therapistName.when(
        data: (name) => Text('$name 치료사님 환영합니다'),
        error: (e, _) => Text('에러 발생 $e'),
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
