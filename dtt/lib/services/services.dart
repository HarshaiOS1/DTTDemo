import 'dart:convert';
import 'package:dtt/services/constants.dart';
import 'package:http/http.dart' as http;

import '../model/houseModel.dart';

class ApiService {
  static var getHouseUrl  = Constants.baseUrl + Constants.getHouseList;
  Map<String, String> requestHeaders = {
    'Access-Key': Constants.accessKey
  };

  Future<List<House>> fetchHouses() async {
    final response = await http.get(Uri.parse(getHouseUrl), headers: requestHeaders);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((house) => House.fromJson(house)).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }
}
