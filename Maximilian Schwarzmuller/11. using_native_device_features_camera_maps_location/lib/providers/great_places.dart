import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:myapp/helpers/db_helpers.dart';
import 'package:myapp/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: pickedTitle,
      placeLocation: null,
      image: pickedImage,
    );

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              placeLocation: null,
              // load from memory oh that file
              image: File(item['']),
            ))
        .toList();
    notifyListeners(); 
  }
}
