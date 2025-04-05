import 'package:flutter/material.dart';

class Patient extends StatelessWidget {
  const Patient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Center(child: Container(child: Text('Patient')))),
    );
  }
}
