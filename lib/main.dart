import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart'; // Importez le splash screen

void main() {
  runApp(MyDMCApp());
}

class MyDMCApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myDMC',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/splash', // Changez cela pour démarrer sur le splash screen
      routes: {
        '/splash': (context) => SplashScreen(), // Écran de lancement
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}