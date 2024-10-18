import 'package:dtt/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'model/houseModel.dart';

class HouseDetailsPage extends StatelessWidget {
  final House house;

  HouseDetailsPage({required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(Constants.baseUrl + house.image,
                height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 16.h),
            Text(
              '\$${house.price}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('${house.zip}, ${house.city}'),
            SizedBox(height: 8.0),
            Text('Bedrooms: ${house.bedrooms}'),
            Text('Bathrooms: ${house.bathrooms}'),
            Text('Size: ${house.size} m²'),
            SizedBox(height: 16.0),
            Text(
              house.description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
