import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../model/house_model.dart';
import '../services/services.dart';

/// A provider class for managing house data and connectivity status.
class HouseProvider extends ChangeNotifier {
  List<House> _houses = [];
  List<House> _filteredHouses = [];
  bool _isLoading = false;
  String _searchQuery = '';

  bool _hasConnection = true;
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<House> get houses => _houses;

  List<House> get filteredHouses => _filteredHouses;

  bool get isLoading => _isLoading;

  bool get hasConnection => _hasConnection;

  HouseProvider() {
    initializeConnectivity();
  }

  /// Loads the houses from the API and updates the state.
  Future<void> loadHouses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _houses = await ApiService().fetchHouses();
      _filteredHouses = _houses;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    Future.microtask(() {
      _isLoading = false;
      notifyListeners();
    });
  }

  /// Filters houses based on the provided search query.
  ///
  /// Updates the [_filteredHouses] list based on matches with the city or zip.
  void filterHouses(String query) {
    _searchQuery = query.trim().toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredHouses = _houses;
    } else {
      final searchTerms =
          _searchQuery.split(RegExp(r'(?<=\D)(?=\d)|(?<=\d)(?=\D)|\s+'));

      _filteredHouses = _houses.where((house) {
        final cityLower = house.city.toLowerCase();
        final zipLower = house.zip.toLowerCase();
        return searchTerms.any((term) {
          return cityLower.contains(term) || zipLower.contains(term);
        });
      }).toList();
    }
    _filteredHouses.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  /// Initializes connectivity status and sets up a listener for connectivity changes.
  Future<void> initializeConnectivity() async {
    List<ConnectivityResult> initialStatus =
        await _connectivity.checkConnectivity();
    _connectionStatus = initialStatus;
    if (_connectionStatus == ConnectivityResult.wifi ||
        _connectionStatus == ConnectivityResult.mobile) {
      _hasConnection = true;
    } else {
      _hasConnection = false;
    }
    Future.microtask(() {
      notifyListeners();
    });

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Updates the connection status based on the new results from the connectivity listener.
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _connectionStatus = results;
    _hasConnection = results.any((result) => result != ConnectivityResult.none);

    Future.microtask(() {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
