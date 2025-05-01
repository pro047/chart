import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view_model/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chart/main.dart';
import 'package:chart/view/patient/patient_view.dart';
import 'package:chart/view/plan/plan.dart';
import 'package:chart/view/therapist/therapist_view.dart';
import 'package:flutter/material.dart';

class Layout extends ConsumerStatefulWidget {
  const Layout({super.key});

  @override
  ConsumerState<Layout> createState() => _LayoutState();
}

class _LayoutState extends ConsumerState<Layout> {
  int _currentIndex = 0;

  final _pages = [TherapistView(), PatientView(), Plan()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chartpt'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginView()),
                (route) => false,
              );
              ref.read(authStateProvider.notifier).logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:
            (newIndex) => setState(() {
              _currentIndex = newIndex;
            }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'therapist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'patient'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'plan'),
        ],
      ),
    );
  }
}
