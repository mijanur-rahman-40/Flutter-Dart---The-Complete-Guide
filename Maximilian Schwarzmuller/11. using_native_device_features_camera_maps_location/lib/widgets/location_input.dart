import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:myapp/helpers/location_helpers.dart';
import 'package:myapp/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Location location = new Location();
  LocationData _locationData;

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Future<void> _getCurrebtUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // intiate location
    _locationData = await location.getLocation();
    final staticMapImageurl = LocationHelper.generateLocationPreviewImage(
      latitude: _locationData.latitude,
      longitude: _locationData.longitude,
    );
    setState(() => _previewImageUrl = staticMapImageurl);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MapScreen(isSelecting: true),
      fullscreenDialog: true,
    ));
    if (selectedLocation == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              onPressed: _getCurrebtUserLocation,
              icon: Icon(
                Icons.location_on,
              ),
              textColor: Theme.of(context).primaryColor,
              label: Text('Current Location'),
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(
                Icons.map,
              ),
              textColor: Theme.of(context).primaryColor,
              label: Text('Select on Map'),
            )
          ],
        )
      ],
    );
  }
}
