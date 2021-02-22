import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, BuildContext context, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 25, color: Colors.purple),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline2,
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text('Cooking Up!',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox(height: 20),
          // if use only pushNamed() method then stack will be bigger and bigger over a time
          // to clear the existing pages have to use pushReplacementNamed() method
          buildListTile('Meals', context, Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters', context, Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
