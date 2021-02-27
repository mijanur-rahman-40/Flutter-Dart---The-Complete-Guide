import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';

import './providers/OrdersProvider.dart';
import './providers/CartProvider.dart';
import './providers/ProductsProvider.dart';

import './screens/products_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  return ChangeNotifierProvider(
    //   create: (_) => ProductsProvider(),
    // if does not depend on the context then simply use .value
    // it is efficient into when works with GridView or ListView
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amberAccent,
          errorColor: Colors.red,
          fontFamily: 'Raleway',
          iconTheme: ThemeData.light()
              .iconTheme
              .copyWith(color: Colors.purple, size: 25),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
                headline2: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
                headline3: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                bodyText1: TextStyle(fontSize: 20),
              ),
        ),
        home: ProductsOverviwScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName:(context)=> UserProductsScreen(),
          EditProductScreen.routeName:(context) => EditProductScreen()
        },
      ),
    );
  }
}
