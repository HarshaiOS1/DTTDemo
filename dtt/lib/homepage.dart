import 'package:dtt/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'Provider/houseProvider.dart';
import 'houseDetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    TextStyle featureTextStyle = TextStyle(
        fontSize: 10.sp, fontWeight: FontWeight.normal, color: Colors.grey);

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "DTT REAL ESTATE",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 24.sp),
        ),
        centerTitle: false,
      ),
      body: Consumer<HouseProvider>(builder: (context, houseProvider, child) {
        if (houseProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: houseProvider.houses.length,
          itemBuilder: (context, index) {
            final house = houseProvider.houses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HouseDetailsPage(house: house),
                  ),
                );
              },
              child: Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Icon(Icons.bed_outlined,
                                    size: 16.sp, color: Colors.grey),
                                // Same light gray
                                SizedBox(width: 2.w),
                                // Responsive width
                                Text('${house.bedrooms}',
                                    style: featureTextStyle),
                                SizedBox(width: 4.w),
                                Icon(Icons.bathtub_outlined,
                                    size: 16.sp, color: Colors.grey),
                                SizedBox(width: 2.w),
                                Text('${house.bathrooms}',
                                    style: featureTextStyle),
                                SizedBox(width: 4.w),
                                Icon(Icons.layers_outlined,
                                    size: 16.sp, color: Colors.grey),
                                SizedBox(width: 2.w),
                                Text('${house.size} m²',
                                    style: featureTextStyle),
                                SizedBox(width: 4.w),
                                Icon(Icons.pin_drop_outlined,
                                    size: 16.sp, color: Colors.grey),
                                SizedBox(width: 2.w),
                                Text('${house.size} km',
                                    style: featureTextStyle),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
