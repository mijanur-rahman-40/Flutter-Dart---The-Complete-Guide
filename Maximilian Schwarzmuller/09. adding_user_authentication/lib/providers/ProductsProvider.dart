import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
// import '../models/product.dart';
import 'SingleProductProvider.dart';

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
  String _userId;
  List<Product> _items = [];

  // var _showFavoritesOnly = false;

  void update(authToken, userId, items) {
    _items = items;
    _authToken = authToken;
    _userId = userId;
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

  // positional arguments -> [bool filterByUser = false]
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    // nested map works well with dynamic not anther object, if we use map into that then it will give an error
    // here response is a nested map
    // Map<String,Object> not like
    // it would be Map<String,dynamic>
    final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : '';
    var url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/products.json?auth=$_authToken&$filterString';

    try {
      final response = await http.get(url);
      // here dynameic basically used for nested map
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      url =
          'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      if (extractedData == null) return;
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.add(Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[productId] ?? false,
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
          'creatorId': _userId,
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
    print(id);
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
            'imageUrl': newProduct.imageUrl
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
