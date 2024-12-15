import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;

  ProductDetailScreen({required this.name, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Image.asset(imageUrl),
          SizedBox(height: 16),
          Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('\$${price.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, color: Colors.green)),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Logique pour ajouter au panier
            },
            child: Text('Ajouter au panier'),
          ),
        ],
      ),
    );
  }
}