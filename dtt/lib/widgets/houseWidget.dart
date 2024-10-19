import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/houseModel.dart';
import '../services/constants.dart';
import '../provider/locationProvider.dart'; // Make sure this is the right import path

class HouseWidget extends StatefulWidget {
  final House house;

  const HouseWidget({super.key, required this.house});

  @override
  _HouseWidgetState createState() => _HouseWidgetState();
}

class _HouseWidgetState extends State<HouseWidget> {
  double? distance;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  void _calculateDistance() {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    if (locationProvider.currentPosition != null) {
      Position position = locationProvider.currentPosition!;
      double houseLatitude = widget.house.latitude.toDouble();
      double houseLongitude = widget.house.longitude.toDouble();

      double calculatedDistance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            houseLatitude,
            houseLongitude,
          ) /
          1000;
      distance = calculatedDistance;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle featureTextStyle = TextStyle(
        fontSize: 10.sp,
        fontFamily: 'GothamSSM',
        fontWeight: FontWeight.w400,
        color: Colors.grey);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.network(
                  Constants.baseUrl + widget.house.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${NumberFormat('#,##0').format(widget.house.price)}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.house.zip}, ${widget.house.city}',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: 'GothamSSM',
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Icon(Icons.bed_outlined, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${widget.house.bedrooms}', style: featureTextStyle),
                      SizedBox(width: 4.w),
                      Icon(Icons.bathtub_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${widget.house.bathrooms}',
                          style: featureTextStyle),
                      SizedBox(width: 4.w),
                      Icon(Icons.layers_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${widget.house.size} m²', style: featureTextStyle),
                      SizedBox(width: 4.w),
                      Icon(Icons.pin_drop_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Consumer<LocationProvider>(
                        builder: (context, locationProvider, child) {
                          if (locationProvider.currentPosition != null) {
                            _calculateDistance();
                            return Text(
                              '${distance != null ? distance!.toStringAsFixed(2) : "..."} km',
                              style: featureTextStyle,
                            );
                          } else {
                            return Text('... km', style: featureTextStyle);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
