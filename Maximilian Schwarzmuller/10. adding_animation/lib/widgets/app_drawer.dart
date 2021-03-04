import 'package:flutter/material.dart';
import 'package:myapp/helpers/custom_route.dart';
import 'package:myapp/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('My Shop App'),
            // never add a back button
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop, color: Theme.of(context).primaryColor),
            title: Text('Shop'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment, color: Theme.of(context).primaryColor),
            title: Text('Orders'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),

            // added transition fading animtion into this route
            // onTap: () => Navigator.of(context).pushReplacement(
            //   CustomRoute(widgetBuilder: (context) => OrdersScreen()),
            // ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit, color: Theme.of(context).primaryColor),
            title: Text('Manage Products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app,
                  color: Theme.of(context).primaryColor),
              title: Text('Logout'),
              // cause drawer is still open and this hanrd switch of widgets
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
