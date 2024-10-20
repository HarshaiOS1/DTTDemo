import 'package:dtt/services/constants.dart';
import 'package:dtt/widgets/houseMapWidget.dart';
import 'package:dtt/widgets/houseWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../model/houseModel.dart';

/// HouseDetailsPage displays detailed information about a selected house.
/// It shows the house's image, price, description, and location on a map.

class HouseDetailsPage extends StatefulWidget {
  final House house;

  const HouseDetailsPage({super.key, required this.house});

  @override
  _HouseDetailsPageState createState() => _HouseDetailsPageState();
}

class _HouseDetailsPageState extends State<HouseDetailsPage> {
  /// Builds the HouseDetailsPage UI, which includes:
  /// - The house's image at the top.
  /// - The house's price, bedrooms, bathrooms, and size.
  /// - A description of the house.
  /// - A map widget showing the house's location.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  Constants.baseUrl + widget.house.image,
                  height: 250.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Displays the price, number of bedrooms, bathrooms, and size of the house.

                      Row(
                        children: [
                          Text(
                            '\$${NumberFormat('#,##0').format(widget.house.price)}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.bed, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text('${widget.house.bedrooms}'),
                          SizedBox(width: 16.w),
                          Icon(Icons.bathtub, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text('${widget.house.bathrooms}'),
                          SizedBox(width: 16.w),
                          Icon(Icons.square_foot, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text('${widget.house.size} m²'),
                          SizedBox(width: 16.w),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.house.description,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 20.h),

                      /// Displays the location header and the map widget.
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      HouseMapWidget(
                        latitude: widget.house.latitude.toDouble(),
                        longitude: widget.house.longitude.toDouble(),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.h,
            left: 16.w,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 35),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
