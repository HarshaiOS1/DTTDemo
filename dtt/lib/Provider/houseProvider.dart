import 'package:flutter/material.dart';
import '../model/houseModel.dart';
import '../services/services.dart';

class HouseProvider extends ChangeNotifier {
  List<House> _houses = [];
  bool _isLoading = false;

  List<House> get houses => _houses;
  bool get isLoading => _isLoading;

  Future<void> loadHouses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _houses = await ApiService().fetchHouses();
    } catch (e) {
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}
