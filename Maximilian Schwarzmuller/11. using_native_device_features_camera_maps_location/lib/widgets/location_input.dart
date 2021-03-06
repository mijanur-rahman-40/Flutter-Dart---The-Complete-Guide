import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:myapp/helpers/location_helpers.dart';
import 'package:myapp/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  //  get function from add place screen
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  Location location = new Location();
  LocationData _locationData;

  void _showPreview({double latitude, double longitude}) {
    final staticMapImageurl = LocationHelper.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );
    setState(() => _previewImageUrl = staticMapImageurl);
  }

  // checking for servce is enabled and permission is granted
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  Future<void> _getCurrentUserLocation() async {
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
    try {
      // intiate location
      _locationData = await location.getLocation();
      // show preview image
      _showPreview(
        latitude: _locationData.latitude,
        longitude: _locationData.longitude,
      );

    // to access class element, we have to use widget  
      widget.onSelectPlace(_locationData.latitude, _locationData.longitude);
    } catch (error) {
      return;
    }
  }

  // as map creation is a asynchronous task so we have to handle with Future and Builder
  Future<void> _selectOnMap() async {
    // get lat and lan data from map screen when we using pop
    // final LatLng selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
    // or
    final selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) => MapScreen(isSelecting: true),
      fullscreenDialog: true,
    ));

    if (selectedLocation == null) return;

    // show preview image
    _showPreview(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );

    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
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
              onPressed: _getCurrentUserLocation,
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
