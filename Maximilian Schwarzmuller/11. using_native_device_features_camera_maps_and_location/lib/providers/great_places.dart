import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:myapp/helpers/db_helpers.dart';
import 'package:myapp/helpers/location_helpers.dart';
import 'package:myapp/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) => _items.firstWhere((place) => place.id == id);

  void addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedPlaceLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedPlaceLocation.latitude,
      pickedPlaceLocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: pickedPlaceLocation.latitude,
      longitude: pickedPlaceLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      placeLocation: updatedLocation,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'locationLatitude': newPlace.placeLocation.latitude,
      'locationLongitude': newPlace.placeLocation.longitude,
      'address': newPlace.placeLocation.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              placeLocation: PlaceLocation(
                latitude: item['locationLatitude'],
                longitude: item['locationLongitude'],
                address: item['address'],
              ),
              // load from memory oh that file
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }
}
