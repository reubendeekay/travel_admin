import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_admin/models/property_model.dart';

class PropertyDetailsLocation extends StatefulWidget {
  final PropertyModel property;
  PropertyDetailsLocation(this.property);
  @override
  _PropertyDetailsLocationState createState() =>
      _PropertyDetailsLocationState();
}

class _PropertyDetailsLocationState extends State<PropertyDetailsLocation> {
  GoogleMapController mapController;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(value);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('myMarker'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          position: widget.property.location.latitude == null
              ? LatLng(-3.2406865930924504, 40.12467909604311)
              : LatLng(widget.property.location.latitude,
                  widget.property.location.longitude),
          infoWindow: InfoWindow(title: 'Watamu Residence'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        const Text(
          'Location',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey[300],
                width: 1,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: GoogleMap(
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.property.location.latitude,
                      widget.property.location.longitude),
                  zoom: 16),
            ),
          ),
        ),
      ],
    );
  }
}
