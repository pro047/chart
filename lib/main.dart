import 'package:chart/loginPage/token_check.dart';
import 'package:chart/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:chart/config/my_sql_connector.dart';

void main() {
  dbConnector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/login': (context) => TokenCheck()},
      home: Scaffold(body: SplashScreen()),
    );
  }
}
