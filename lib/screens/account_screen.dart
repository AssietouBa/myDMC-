import 'package:flutter/material.dart';
import 'package:mydcm/screens/login_screen.dart';
import 'package:mydcm/screens/signup_screen.dart';


class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mon Compte')),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text('Se connecter'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: Text('S\'inscrire'),
          ),
        ],
      )),
    );
  }
}