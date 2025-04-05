import 'package:chart/screen/patient.dart';
import 'package:chart/screen/plan.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  final List<Widget> _pages = [Patient(), Plan()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(child: _pages[_index]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patient'),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              label: 'Plan',
            ),
          ],
        ),
        //
        //
        //
        //
        //
        //
        //
        //
        //
        // BottomAppBar(
        //   child: Row(
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Home()),
        //           );
        //         },
        //         icon: Icon(Icons.home),
        //       ),
        //       IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Home()),
        //           );
        //         },
        //         icon: Icon(Icons.person),
        //       ),
        //       IconButton(
        //         onPressed: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => Home()),
        //           );
        //         },
        //         icon: Icon(Icons.contact_page),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
