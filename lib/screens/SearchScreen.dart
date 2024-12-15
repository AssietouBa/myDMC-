import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<dynamic> _searchResults = []; // Liste pour stocker les résultats de recherche
  bool _isLoading = false; // Indicateur de chargement

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true; // Démarrer le chargement
    });

    final response = await http.get(
      Uri.parse('https://dmcomputer.sn/wp-json/wc/v3/products?search=$query'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35')),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = json.decode(response.body);
        _isLoading = false; // Arrêter le chargement
      });
    } else {
      setState(() {
        _isLoading = false; // Arrêter le chargement même en cas d'erreur
      });
      throw Exception('Échec de la récupération des résultats de recherche');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search), // Icône de recherche à droite
                  onPressed: () {
                    _searchQuery = _searchController.text;
                    searchProducts(_searchQuery); // Appel de la fonction de recherche
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
              : Expanded(
            child: _searchResults.isEmpty
                ? Center(child: Text('Aucun résultat, veuillez entrer votre recherche.'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                var product = _searchResults[index];
                return ListTile(
                  title: Text(product['name']), // Nom du produit
                  subtitle: Text('CFA ${product['price']}'), // Prix du produit
                  leading: Image.network(
                    product['images'].isNotEmpty ? product['images'][0]['src'] : 'images/default.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    // Logique pour naviguer vers la page de détail du produit
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}