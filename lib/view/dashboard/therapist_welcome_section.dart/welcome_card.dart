import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:chart/view_model/therapist/data/therapist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistWelcomeCard extends ConsumerWidget {
  const TherapistWelcomeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateProvider).user;
    if (user == null) return Center(child: Text('해당 유저가 없습니다'));
    print('user : ${user.id}');

    final theraAsync = ref.watch(therapistViewModelProvider(user.id));
    print('theraAsync : ${theraAsync.hasValue}');

    return Padding(
      padding: EdgeInsets.all(16),
      child: theraAsync.when(
        data: (thera) => Text('${thera.name} 치료사님 환영합니다'),
        error: (e, st) {
          print('error: $e\n st: $st');
          return Text('에러 발생 $e');
        },
        loading: () => CircularProgressIndicator(),
      ),
    );
  }
}
