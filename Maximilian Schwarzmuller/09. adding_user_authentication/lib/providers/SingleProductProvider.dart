import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// nested models and providers
// here listener added cause isFavorite always change
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;

    // just like work setSate in provider package
    notifyListeners();
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      // patch basically override the existing status
      // using put can pass true or false value
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
