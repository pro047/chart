import 'package:chart/main.dart';
import 'package:chart/view/patient/patient_view.dart';
import 'package:chart/view/plan/plan.dart';
import 'package:chart/view/therapist/therapist_view.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  final _pages = [TherapistView(), PatientView(), Plan()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('charpt'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => MyApp()),
                (route) => false,
              );
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'therapist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'patient'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'plan'),
        ],
      ),
    );
  }
}
