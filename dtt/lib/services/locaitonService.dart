import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  static const int locationUpdateTimeLimitInMinutes = 15;
  static const double locationUpdateDistanceLimitInMeters = 5000;

  Future<Position?> getCurrentLocation({
    Position? cachedPosition,
    DateTime? lastUpdatedTime,
  }) async {
    if (_shouldUpdateLocation(cachedPosition, lastUpdatedTime)) {
      try {
        return await _determinePosition();
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
    if (cachedPosition == null || _isTimeLimitExceeded(lastUpdatedTime)) {
      return true;
    }
    return false;
  }

  bool _isTimeLimitExceeded(DateTime? lastUpdatedTime) {
    if (lastUpdatedTime == null) return true;
    return DateTime.now().difference(lastUpdatedTime).inMinutes > locationUpdateTimeLimitInMinutes;
  }

  Future<Position> _determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
