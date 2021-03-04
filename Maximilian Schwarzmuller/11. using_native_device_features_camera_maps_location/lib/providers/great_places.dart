import 'dart:io';

import 'package:flutter/foundation.dart';
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
  }
}
