import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../model/houseModel.dart';
import '../services/services.dart';

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

  void filterHouses(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isNotEmpty) {
      _filteredHouses = _houses.where((house) {
        final cityMatch = house.city.toLowerCase().contains(_searchQuery);
        final zipMatch = house.zip.toLowerCase().contains(_searchQuery);
        return cityMatch || zipMatch;
      }).toList();
    } else {
      _filteredHouses = _houses;
    }
    _filteredHouses.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

// TODO : create network provide and have other providers listen to network proxy provider
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
