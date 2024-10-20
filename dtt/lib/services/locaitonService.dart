import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// A singleton service class to handle location-related operations,
/// including fetching the current location of the device.
class LocationService {
  static final LocationService _instance = LocationService._internal();

  factory LocationService() => _instance;

  LocationService._internal();

  /// Time limit in minutes to refresh the location.
  static const int locationUpdateTimeLimitInMinutes = 15;

  /// Distance limit in meters to refresh the location.
  static const double locationUpdateDistanceLimitInMeters = 5000;

  /// Fetches the current location of the device.
  /// Optionally uses cached position and last updated time to determine
  /// if a new location fetch is necessary.
  ///
  /// Returns:
  /// - A [Position] object representing the current location if successful,
  /// - Otherwise returns null.
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

  /// Determines if the location should be updated based on the cached position
  /// and the last updated time.
  bool _shouldUpdateLocation(
      Position? cachedPosition, DateTime? lastUpdatedTime) {
    if (cachedPosition == null || _isTimeLimitExceeded(lastUpdatedTime)) {
      return true;
    }
    return false;
  }

  /// Checks if the time limit for refreshing the location has been exceeded.
  bool _isTimeLimitExceeded(DateTime? lastUpdatedTime) {
    if (lastUpdatedTime == null) return true;
    return DateTime.now().difference(lastUpdatedTime).inMinutes >
        locationUpdateTimeLimitInMinutes;
  }

  /// Fetches the current position of the device.
  /// Throws an exception if location services are disabled or permissions
  /// are not granted.
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
