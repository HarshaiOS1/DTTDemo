import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtt/screens/homepage.dart';
import 'package:dtt/services/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/house_model.dart';
import '../services/constants.dart';
import '../provider/location_provider.dart';

/// Displays a card widget containing house details in the list of houses in [HomePage].
/// Accepts a [House] object as a required parameter.
class HouseWidget extends StatefulWidget {
  final House house;

  const HouseWidget({super.key, required this.house});

  @override
  HouseWidgetState createState() => HouseWidgetState();
}

class HouseWidgetState extends State<HouseWidget> {
  double? distance;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  /// Calculates the distance between the user's current location and the house location.
  /// Retrieves the current location from the [LocationProvider], then calculates the distance
  /// in kilometers using the [Geolocator] package.
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
    /// Returns a card containing house information such as price, location,
    ///size, number of bedrooms and bathrooms, and the distance to the house.
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
                child: CachedNetworkImage(
                  imageUrl: Constants.baseUrl + widget.house.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 1,
                    )),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      Text('${widget.house.bedrooms}',
                          style: AppTextStyles.subtitle(color: Colors.grey)),
                      SizedBox(width: 4.w),
                      Icon(Icons.bathtub_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${widget.house.bathrooms}',
                          style: AppTextStyles.subtitle(color: Colors.grey)),
                      SizedBox(width: 4.w),
                      Icon(Icons.layers_outlined,
                          size: 16.sp, color: Colors.grey),
                      SizedBox(width: 2.w),
                      Text('${widget.house.size} m²',
                          style: AppTextStyles.subtitle(color: Colors.grey)),
                      SizedBox(width: 4.w),
                      Consumer<LocationProvider>(
                        builder: (context, locationProvider, child) {
                          if (locationProvider.currentPosition != null) {
                            _calculateDistance();
                            if (distance != null) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop_outlined,
                                    size: 16.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    "${distance!.toStringAsFixed(2)} km",
                                    style: AppTextStyles.subtitle(
                                        color: Colors.grey),
                                  ),
                                ],
                              );
                            }
                          }
                          return Container();
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
