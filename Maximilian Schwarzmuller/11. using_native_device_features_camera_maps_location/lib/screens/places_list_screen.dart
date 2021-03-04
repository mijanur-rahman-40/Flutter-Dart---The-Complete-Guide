import 'package:flutter/material.dart';
import 'package:myapp/providers/great_places.dart';
import 'package:myapp/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            ),
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: Center(
            child: const Text('Got no place yet, start adding smome!'),
          ),
          builder: (context, greatPlaces, child) =>
              greatPlaces.items.length <= 0
                  ? child
                  : ListView.builder(
                      itemCount: greatPlaces.items.length,
                      itemBuilder: (context, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            greatPlaces.items[i].image,
                          ),
                        ),
                        title: Text(greatPlaces.items[i].title),
                        onTap: (){
                          // go to details page
                        },
                      ),
                    ),
        ));
  }
}
