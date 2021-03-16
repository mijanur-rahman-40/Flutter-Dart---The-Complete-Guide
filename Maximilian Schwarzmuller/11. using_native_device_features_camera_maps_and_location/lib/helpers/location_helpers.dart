import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/config/secrets.dart';

// GOOGLE_API_KEY is imported from as staic const

class LocationHelper {
  // return a string image url
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$CONFIG.GOOGLE_API_KEY';
    
  }

  // return a address
  // this is async cause google have to find address related to the lat and lan
  static Future<String> getPlaceAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$CONFIG.GOOGLE_API_KEY';
    final response = await http.get(url);
    // 0 index means most relevent address
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
