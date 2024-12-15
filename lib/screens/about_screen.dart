import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À Propos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'À Propos de DMC',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'DMC est une application dédiée à la vente d\'ordinateurs et d\'appareils informatiques. '
                    'Nous proposons une large gamme de produits de haute qualité adaptés à tous vos besoins, '
                    'que ce soit pour le travail, les études ou le divertissement.',
                style: TextStyle(fontSize: 22, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Pour toute question ou demande d\'information, n\'hésitez pas à nous contacter à l\'adresse suivante :',
                style: TextStyle(fontSize: 22, color: Colors.green),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'mydmc@gmail.com',
                style: TextStyle(fontSize: 22, color: Colors.green[900]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}