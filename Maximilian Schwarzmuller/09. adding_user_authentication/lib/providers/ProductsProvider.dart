import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
// import '../models/product.dart';
import './product.dart';

// with basically work like extending
// here heve to use with instead of extends
// mixin property add utility function provider with multiple classes
/// mixin Agility{
///  var spen = 10;
/// void sitDown(){
///   print('Sitting down.....)
///    }
///  }
/// clas Person with Agility{
///  }
class ProductsProvider with ChangeNotifier {
  String _authToken;
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var _showFavoritesOnly = false;

  void update(authToken, items) {
    _items = items;
    _authToken = authToken;
    notifyListeners();
  }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((productItem) => productItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((productItem) => productItem.isFavorite).toList();
  }

  Product findById(String productId) {
    return _items.firstWhere((product) => product.id == productId);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  // return async future
  // Future<void> addProduct(Product product) {
  //   const url = 'https://flutter-shop-app-93671.firebaseio.com/products.json';

  //   return http
  //       .post(
  //     url,
  //     body: json.encode({
  //       'title': product.title,
  //       'description': product.description,
  //       'price': product.price,
  //       'imageUrl': product.imageUrl,
  //       'isFavorite': product.isFavorite
  //     }),
  //   )
  //       .then((response) {
  //     final newProduct = Product(
  //       id: json.decode(response.body)['name'],
  //       title: product.title,
  //       description: product.description,
  //       price: product.price,
  //       imageUrl: product.imageUrl,
  //     );
  //     _items.add(newProduct);
  //     notifyListeners();
  //   }).catchError((error) => throw error);
  //   // _items.insert(0, newProduct);  // at the start of the list
  // }

  Future<void> fetchAndSetProducts() async {
    // nested map works well with dynamic not anther object, if we use map into that then it will give an error
    // here response is a nested map
    // Map<String,Object> not like
    // it would be Map<String,dynamic>
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/products.json?auth=$_authToken';
    try {
      final response = await http.get(url);
      // here dynameic basically used for nested map
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // another way of implementing
  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/products.json?auth=$_authToken';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    // _items.insert(0, newProduct);  // at the start of the list
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      final url =
          'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken';
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'isFavorite': newProduct.isFavorite
          }),
        );
      } catch (error) {
        throw error;
      }
      _items[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken';
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    // http.delete(url).then((response) {
    //   print(response.statusCode);
    //   existingProduct = null;
    // }).catchError((_) {
    //   _items.insert(existingProductIndex, existingProduct);
    //   notifyListeners();
    // });
    // _items.removeWhere((product) => product.id == id);

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Coluld not delete product.');
    }
    existingProduct = null;
  }
}
