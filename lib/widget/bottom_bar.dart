import 'package:chart/screen/home.dart';
import 'package:chart/screen/patient.dart';
import 'package:chart/screen/plan.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _index = 0;
  final List<Widget> _pages = [Home(), Patient(), Plan()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _pages[_index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
              print(_index);
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Patient',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_page_rounded),
              label: 'Plan',
            ),
          ],
        ),
      ),
    );
  }
}
