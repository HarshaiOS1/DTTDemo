import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() {
    return _instance;
  }
  LocationService._internal();
  static const int locationUpdateTimeLimit = 15;
  static const double locationUpdateDistanceLimit = 5000;

  Future<Position?> getCurrentLocation({
    Position? cachedPosition,
    DateTime? lastUpdatedTime,
  }) async {
    if (_shouldUpdateLocation(cachedPosition, lastUpdatedTime)) {
      try {
        Position position = await _determinePosition();
        return position;
      } catch (e) {
        if (kDebugMode) {
          print("Error getting location: $e");
        }
        return null;
      }
    }
    return cachedPosition;
  }

  bool _shouldUpdateLocation(
      Position? cachedPosition, DateTime? lastUpdatedTime) {
    if (cachedPosition == null) {
      return true;
    }

    if (lastUpdatedTime != null) {
      final duration = DateTime.now().difference(lastUpdatedTime);
      if (duration.inMinutes > locationUpdateTimeLimit) {
        return true;
      }
    }
    return false;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  bool hasMovedSignificantly(Position cachedPosition, Position newPosition) {
    double distanceInMeters = Geolocator.distanceBetween(
        cachedPosition.latitude,
        cachedPosition.longitude,
        newPosition.latitude,
        newPosition.longitude);
    return distanceInMeters > locationUpdateDistanceLimit;
  }
}
