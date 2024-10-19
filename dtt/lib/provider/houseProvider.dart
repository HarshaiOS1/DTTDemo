import 'package:flutter/material.dart';
import '../model/houseModel.dart';
import '../services/services.dart';

class HouseProvider extends ChangeNotifier {
  List<House> _houses = [];
  List<House> _filteredHouses = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<House> get houses => _houses;

  List<House> get filteredHouses => _filteredHouses;

  bool get isLoading => _isLoading;

  Future<void> loadHouses() async {
    _isLoading = true;
    notifyListeners();
    try {
      _houses = await ApiService().fetchHouses();
      _filteredHouses = _houses;
    } catch (e) {
      print(e);
    }
    _isLoading = false;
    notifyListeners();
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
    // Sort the filtered houses by price (ascending)
    _filteredHouses.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }
}