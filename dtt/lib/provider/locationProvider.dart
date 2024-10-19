import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../services/locaitonService.dart';

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
