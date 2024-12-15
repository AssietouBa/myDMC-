import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'cart_screen.dart';
import 'account_screen.dart';
import 'favorites_screen.dart';
import 'about_screen.dart';
import 'privacy_policy_screen.dart';
import 'SearchScreen.dart';
import 'ShareScreen.dart';
import 'ProductDetailScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentPage = 0;
  late Timer _timer;
  late PageController _pageController;

  List<Map<String, dynamic>> _displayedImages = [];
  String _activeCategory = 'Toutes';
  List<dynamic> _categories = [];
  List<Map<String, dynamic>> _cartItems = [];

  final String _apiUrl = 'https://dmcomputer.sn/wp-json/wc/v3';
  final String _auth = 'Basic ' +
      base64Encode(utf8.encode('ck_ce2175287f13be3edb8c8bb884e2e9051cfe08ad:cs_c95c5bb6027fd918466dd18823a78a227a2d0b35'));

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
    fetchCategories();
    fetchProducts();
    fetchCartItems();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_currentPage < _displayedImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('$_apiUrl/products/categories'),
      headers: {'Authorization': _auth},
    );

    if (response.statusCode == 200) {
      setState(() {
        _categories = json.decode(response.body);
      });
    } else {
      throw Exception('Échec de la récupération des catégories');
    }
  }

  Future<void> fetchProducts([String? categoryId]) async {
    String url = '$_apiUrl/products';
    if (categoryId != null) {
      url += '?category=$categoryId';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': _auth},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _displayedImages = data.map((product) {
          return {
            'name': product['name'],
            'imageUrl': product['images'].isNotEmpty ? product['images'][0]['src'] : 'images/default.jpg',
            'price': double.tryParse(product['price']) ?? 0.0,
            'id': product['id'],
          };
        }).toList();
      });
    } else {
      throw Exception('Échec de la récupération des produits');
    }
  }

  Future<void> fetchCartItems() async {
    final response = await http.get(
      Uri.parse('$_apiUrl/cart'),
      headers: {'Authorization': _auth},
    );

    if (response.statusCode == 200) {
      setState(() {
        _cartItems = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Échec de la récupération des articles du panier');
    }
  }

  Future<void> _addToCart(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/cart/add'),
      headers: {'Authorization': _auth, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': product['id'],
        'quantity': 1,
      }),
    );

    if (response.statusCode == 200) {
      fetchCartItems();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product['name']} a été ajouté au panier!')),
      );
    } else {
      throw Exception('Échec de l\'ajout du produit au panier');
    }
  }

  Future<void> _addToFavorites(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse('$_apiUrl/favorites/add'), // Vérifiez que ce point de terminaison est correct
      headers: {'Authorization': _auth, 'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_id': product['id'],
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product['name']} a été ajouté aux favoris!')),
      );
    } else {
      throw Exception('Échec de l\'ajout du produit aux favoris');
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _activeCategory = categoryId;
    });
    fetchProducts(categoryId);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(child: Text('DMCcomputer', style: TextStyle(fontSize: 20))),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50, backgroundImage: AssetImage('images/dmc.jpg')),
                  SizedBox(height: 10),
                  Text('DMComputer@gmail.sn', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Accueil'),
                    onTap: () => _onItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Recherche'),
                    onTap: () => _onItemTapped(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text('Favoris'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text('Panier'),
                    onTap: () => _onItemTapped(2),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Mon Compte'),
                    onTap: () => _onItemTapped(3),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip),
                    title: Text('Politique de Confidentialité'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('À Propos'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Partager'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShareScreen()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Image carousel
          Container(
            height: 120,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _displayedImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _displayedImages[index]['imageUrl'],
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
          ),
          // Categories title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Catégories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    // Action pour "Voir tout"
                  },
                  child: Text('Voir tout', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
          // Category buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.start,
              children: _categories.map<Widget>((category) {
                return _buildCategoryButton(category['id'].toString(), category['name']);
              }).toList(),
            ),
          ),
          // Displayed images section
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: _displayedImages.length,
              itemBuilder: (context, index) {
                var product = _displayedImages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          name: product['name'],
                          imageUrl: product['imageUrl'],
                          price: product['price'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            product['imageUrl'],
                            fit: BoxFit.contain,
                            height: 700,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              _addToFavorites(product); // Ajouter aux favoris
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'CFA ${product['price'].toString()}',
                                style: TextStyle(color: Colors.red),
                              ),
                              ElevatedButton(
                                onPressed: () => _addToCart(product), // Ajouter au panier
                                child: Text('Ajouter au panier'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Compte',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ElevatedButton _buildCategoryButton(String categoryId, String categoryName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _activeCategory == categoryId ? Colors.green : Colors.white,
        foregroundColor: _activeCategory == categoryId ? Colors.white : Colors.green,
      ),
      onPressed: () => _onCategorySelected(categoryId),
      child: Text(categoryName),
    );
  }
}