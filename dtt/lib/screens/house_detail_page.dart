import 'package:dtt/services/constants.dart';
import 'package:dtt/widgets/house_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../model/house_model.dart';
import '../services/app_text_styles.dart';

/// HouseDetailsPage displays detailed information about a selected house.
/// Builds the HouseDetailsPage UI, which includes:
/// - The house's image at the top.
/// - The house's price, bedrooms, bathrooms, and size.
/// - A description of the house.
/// - A map widget showing the house's location.
///
class HouseDetailsPage extends StatelessWidget {
  final House house;

  const HouseDetailsPage({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.network(
            Constants.baseUrl + house.image,
            height: 250.h,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ScrollablePositionedList.builder(
              padding: EdgeInsets.fromLTRB(0.0, 240.h, 0.0, 0.0),
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    '\$${NumberFormat('#,##0').format(house.price)}',
                                    style: AppTextStyles.titleSemiBold20()),
                                const Spacer(),
                                Icon(Icons.bed,
                                    size: 18.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text(
                                  '${house.bedrooms}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 16.w),
                                Icon(Icons.bathtub,
                                    size: 18.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text(
                                  '${house.bathrooms}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 16.w),
                                Icon(Icons.square_foot,
                                    size: 18.sp, color: Colors.grey),
                                SizedBox(width: 4.w),
                                Text(
                                  '${house.size} m²',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SizedBox(width: 16.w),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Description',
                              style: AppTextStyles.titleSemiBold18(),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              house.description,
                              style: AppTextStyles.detailLight(),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Location',
                              style: AppTextStyles.titleSemiBold18(),
                            ),
                            SizedBox(height: 16.h),
                            HouseMapWidget(
                              latitude: house.latitude.toDouble(),
                              longitude: house.longitude.toDouble(),
                            ),
                            SizedBox(height: 30.h),
                          ]),
                    ),
                  ),
                );
              }),
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
