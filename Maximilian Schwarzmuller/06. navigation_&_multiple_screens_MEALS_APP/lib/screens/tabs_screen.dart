import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabScreen(this.favoriteMeals);
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // can also add any action key
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    // it is still run before build execution
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoriteScreen(widget.favoriteMeals),
        'title': 'Your Favorite',
      },
    ];
    super.initState();
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // DefaultTabController show into top
    // return DefaultTabController(
    //   length: 2,
    //   // initialIndex: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       // for many tabs can alos add isScrollable: true,
    //       bottom: TabBar(indicatorColor: Colors.white, tabs: <Widget>[
    //         // order of tab is most important for switch
    //         Tab(icon: Icon(Icons.category), text: 'Categories'),
    //         Tab(icon: Icon(Icons.star), text: 'Favorites'),
    //         //  Tab(icon: Icon(Icons.category), text: 'Categories'),
    //         // Tab(icon: Icon(Icons.star), text: 'Favorites'),
    //       ]),
    //     ),
    //     body: TabBarView(
    //         children: <Widget>[CategoriesScreen(), FavoriteScreen()]),
    //   ),
    // );
    // we have to create a bottom tab
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'])),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          // onTap automatically index create which tab is clicked
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).accentColor,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          selectedFontSize: 16,
          // type: BottomNavigationBarType.fixed,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text('Categories',
                  style: Theme.of(context).textTheme.headline4),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text('Favorites',
                  style: Theme.of(context).textTheme.headline4),
            ),
          ]),
    );
  }
}
