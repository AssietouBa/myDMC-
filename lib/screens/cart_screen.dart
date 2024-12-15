import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = []; // Liste des articles dans le panier

  // URL de l'API pour gérer le panier
  final String _apiUrl = 'https://dmcomputer.sn/wp-json/wc/v3/cart';
  final String _auth = 'Basic ' + base64Encode(utf8.encode('ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35'));

  @override
  void initState() {
    super.initState();
    _loadCartItems(); // Charger les articles du panier
  }

  // Charger les articles du panier
  Future<void> _loadCartItems() async {
    final response = await http.get(Uri.parse(_apiUrl), headers: {'Authorization': _auth});
    if (response.statusCode == 200) {
      setState(() {
        _cartItems = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Échec de la récupération des articles du panier');
    }
  }

  // Supprimer un produit du panier
  Future<void> _removeFromCart(int index) async {
    final response = await http.delete(Uri.parse('$_apiUrl/${_cartItems[index]['id']}'), headers: {'Authorization': _auth});
    if (response.statusCode == 200) {
      setState(() {
        _cartItems.removeAt(index); // Supprimer l'article du panier
      });
    } else {
      throw Exception('Échec de la suppression du produit du panier');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
      ),
      body: _cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/img.png', width: 100, height: 100),
            SizedBox(height: 10),
            Text('Votre panier est vide', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('Ajoutez des articles à votre panier pour commencer.', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
          ],
        ),
      )
          : ListView.builder(
        itemCount: _cartItems.length,
        itemBuilder: (context, index) {
          var item = _cartItems[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(item['name']),
              subtitle: Text('CFA ${item['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.remove),
                onPressed: () => _removeFromCart(index),
              ),
            ),
          );
        },
      ),
    );
  }
}