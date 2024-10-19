import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dtt/services/utils.dart';

class HouseMapWidget extends StatefulWidget {
  final double latitude;
  final double longitude;

  const HouseMapWidget({super.key, required this.latitude, required this.longitude});

  @override
  _HouseMapWidgetState createState() => _HouseMapWidgetState();
}

class _HouseMapWidgetState extends State<HouseMapWidget> {
  late GoogleMapController _mapController;
  late LatLng _houseLocation;

  @override
  void initState() {
    super.initState();
    _houseLocation = LatLng(widget.latitude, widget.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: const EdgeInsets.all(5.0),
      alignment: Alignment.center,
      child: GoogleMap(
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
