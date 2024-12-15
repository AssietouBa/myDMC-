import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Politique de Confidentialité'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Politique de Confidentialité de DMC',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 20),
              Text(
                'Chez DMC, nous nous engageons à protéger votre vie privée. Cette politique de confidentialité '
                    'explique comment nous collectons, utilisons et partageons vos informations lorsque vous utilisez '
                    'notre application.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                '1. **Informations Collectées**',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                'Nous collectons des informations que vous nous fournissez directement, comme votre nom, '
                    'votre adresse e-mail et d\'autres détails lors de votre inscription ou lorsque vous passez une commande.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                '2. **Utilisation de vos Informations**',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                'Nous utilisons vos informations pour traiter vos commandes, améliorer notre service client, '
                    'et vous tenir informé des mises à jour et promotions.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                '3. **Partage d\'Informations**',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                'Nous ne vendons ni ne louons vos informations personnelles à des tiers. Nous pouvons partager '
                    'vos informations avec des partenaires de confiance pour améliorer nos services.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                '4. **Sécurité**',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                'Nous prenons des mesures raisonnables pour protéger vos informations personnelles. Cependant, '
                    'aucune méthode de transmission sur Internet ou de stockage électronique n\'est totalement sécurisée.',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                '5. **Contactez-nous**',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
              SizedBox(height: 10),
              Text(
                'Si vous avez des questions concernant notre politique de confidentialité, veuillez nous contacter à '
                    'l\'adresse suivante :',
                style: TextStyle(fontSize: 18, color: Colors.green),
              ),
              SizedBox(height: 10),
              Text(
                'mydmc@gmail.com',
                style: TextStyle(fontSize: 18, color: Colors.green[900]),
              ),
              SizedBox(height: 20),
              Text(
                'En utilisant notre application, vous acceptez les termes de cette politique de confidentialité.',
                style: TextStyle(fontSize: 18, color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}