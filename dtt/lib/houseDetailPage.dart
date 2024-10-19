import 'package:dtt/services/constants.dart';
import 'package:dtt/widgets/houseMapWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/houseModel.dart';

class HouseDetailsPage extends StatefulWidget {
  final House house;

  HouseDetailsPage({required this.house});

  @override
  _HouseDetailsPageState createState() => _HouseDetailsPageState();
}

class _HouseDetailsPageState extends State<HouseDetailsPage> {
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
                // House Details
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '\$${widget.house.price}',
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
                          Icon(Icons.location_on, size: 18.sp),
                          SizedBox(width: 4.w),
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
          // Back Button
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
