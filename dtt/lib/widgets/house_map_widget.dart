import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dtt/services/utils.dart';

/// HouseMapWidget displays a Google Map centered on the house's location.
/// It shows a marker for the house's position and allows users to launch navigation to the house.

class HouseMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const HouseMapWidget(
      {super.key, required this.latitude, required this.longitude});

  @override
  HouseMapWidgetState createState() => HouseMapWidgetState();
}

class HouseMapWidgetState extends State<HouseMapWidget> {
  late GoogleMapController _mapController;
  late LatLng _houseLocation;

  @override
  void initState() {
    super.initState();
    _houseLocation = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    /// Builds the HouseMapWidget UI, which includes:
    /// - A Google Map centered on the house's location.
    /// - A marker indicating the house's position.
    /// - The ability to launch navigation to the house's location when the marker or map is tapped.
    return Container(
      height: 300.h,
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      child: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_houseLocation, 12),
          );
        },
        initialCameraPosition: CameraPosition(
          target: _houseLocation,
          zoom: 8,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('houseLocation'),
            position: _houseLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            onTap: () {
              Utils.launchMaps(_houseLocation);
            },
          ),
        },
        onTap: (LatLng point) {
          Utils.launchMaps(_houseLocation);
        },
        mapType: MapType.normal,
      ),
    );
  }
}
