import 'package:chart/auth/view/login_view.dart';
import 'package:chart/auth/view/signup_view.dart';
import 'package:chart/view/therapist/therapist_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
        '/signup': (context) => SignupView(),
        'therapist': (context) => TherapistView(),
      },
    );
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: '/',
    //   routes: {
    //     '/': (context) => SplashScreen(),
    //     '/login': (context) => TokenCheck(),
    //     '/home': (context) => Home(),
    //     '/therapist': (context) => Therapist(),
    //     '/patient': (context) => Patient(),
    //     '/plan': (context) => Plan(),
    //   },
    // );
  }
}
