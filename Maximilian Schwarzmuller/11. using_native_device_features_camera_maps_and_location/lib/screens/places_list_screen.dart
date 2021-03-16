import 'package:flutter/material.dart';
import 'package:myapp/providers/great_places.dart';
import 'package:myapp/screens/add_place_screen.dart';
import 'package:myapp/screens/place_detail_screen.dart';
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
      body: FutureBuilder(
        // liasten: false -> means only re build the inside of builder but ither this will not , like app bar
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text('Got no place yet, start adding some!'),
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
                              title: Text(
                                greatPlaces.items[i].title,
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              subtitle: Text(
                                greatPlaces.items[i].placeLocation.address,
                              ),
                              // go to details page
                              onTap: () => Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[i].id),
                            ),
                          ),
              ),
      ),
    );
  }
}
