import 'package:flutter/material.dart';
import 'dart:async'; // Pour utiliser Timer

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Délai de 4 secondes avant de passer à l'écran d'accueil
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/dmc.jpg'), // Vérifiez que le chemin est correct
            fit: BoxFit.cover, // L'image remplit tout l'écran
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Ajout d'un flou léger sur le texte
              Container(
                color: Colors.black54, // Couleur de fond semi-transparente
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Bienvenue sur myDMC',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(), // Indicateur de chargement
            ],
          ),
        ),
      ),
    );
  }
}