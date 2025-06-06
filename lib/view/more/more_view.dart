import 'package:chart/view/more/logout_section/logout_dialog.dart';
import 'package:chart/view/more/therapist_profile_section/therapist_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoreView extends ConsumerWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TherapistProfileCard(),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => LogoutDialog(),
                );
              },
              label: Text('로그아웃'),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
