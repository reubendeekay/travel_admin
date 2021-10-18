import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_admin/providers/location_provider.dart';

class AddOnMap extends StatefulWidget {
  static const routeName = '/add-on-map';
  @override
  _AddOnMapState createState() => _AddOnMapState();
}

class _AddOnMapState extends State<AddOnMap> {
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    var locData = Provider.of<LocationProvider>(context);
    var _locationData = locData.locationData;

    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          onTap: (value) {
            locData.propertyLocation(value.longitude, value.latitude);

            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      content: Text('Confirm the location'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Yes')),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text('No')),
                        ),
                      ],
                    ));
          },
          onMapCreated: _onMapCreated,
          compassEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(_locationData.latitude, _locationData.longitude),
              zoom: 16),
        ),
      ),
    );
  }
}
