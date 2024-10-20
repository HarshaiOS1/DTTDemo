import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../services/locaitonService.dart';

/// LocationProvider manages the current user's location and notifies listeners
/// of any changes to the location.
class LocationProvider with ChangeNotifier {
  Position? _currentPosition;

  Position? get currentPosition => _currentPosition;

  LocationProvider() {
    _updateCurrentLocation();
  }

  Future<void> _updateCurrentLocation() async {
    try {
      Position? position = await LocationService().getCurrentLocation();
      if (position != null) {
        _currentPosition = position;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current location: $e');
      }
    }
  }

  Future<void> refreshLocation() async {
    await _updateCurrentLocation();
  }
}
