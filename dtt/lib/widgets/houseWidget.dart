import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../model/houseModel.dart';
import '../services/constants.dart';

class HouseWidget extends StatelessWidget {
  final House house;

  const HouseWidget({super.key, required this.house});

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
                  Constants.baseUrl + house.image,
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
                    '\$${NumberFormat('#,##0').format(house.price)}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${house.zip}, ${house.city}',
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontFamily: 'GothamSSM',
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                      Icon(Icons.bed_outlined, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${house.bedrooms}', style: featureTextStyle), // Fixed
                      SizedBox(width: 4.w),
                      Icon(Icons.bathtub_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${house.bathrooms}', style: featureTextStyle), // Fixed
                      SizedBox(width: 4.w),
                      Icon(Icons.layers_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${house.size} m²', style: featureTextStyle), // Fixed
                      SizedBox(width: 4.w),
                      Icon(Icons.pin_drop_outlined,
                          size: 16.sp, color: Colors.grey),
                      // SizedBox(width: 2.w),
                      // Text('$distance km', style: featureTextStyle),
                    ],
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
