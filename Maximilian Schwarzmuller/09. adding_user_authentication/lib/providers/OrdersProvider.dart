import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './CartProvider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  String _authToken;

  List<OrderItem> get orders {
    return [..._orders];
  }

  void update(authToken, orders) {
    _authToken = authToken;
    _orders = orders;
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/orders.json?auth=$_authToken';
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                ),
              )
              .toList(),
          dateTime: orderData['dateTime'],
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://flutter-shop-project-6012b-default-rtdb.firebaseio.com/orders.json?auth=$_authToken';
    final timeStamp = DateTime.now();
    // toIso8601String -> uniform string representation
    final response = await http.post(
      url,
      body: json.encode({
        "amount": total,
        "dateTime": timeStamp.toIso8601String(),
        "products": cartProducts
            .map((cartProduct) => {
                  "id": cartProduct.id,
                  "title": cartProduct.title,
                  "quantity": cartProduct.quantity,
                  "price": cartProduct.price
                })
            .toList()
      }),
    );
    // "name" is auto generated id
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
