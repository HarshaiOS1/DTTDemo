import 'dart:io' show Platform;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

///Utility class to write some of the reusable functions like open third party apps or do reusable calculation .
class Utils {
  ///Opens google maps or apple maps depending on the platform user is in, in case of error webpage is opened with google maps
  static Future<void> launchMaps(LatLng location) async {
    String encodedLatitude = Uri.encodeComponent(location.latitude.toString());
    String encodedLongitude =
        Uri.encodeComponent(location.longitude.toString());

    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$encodedLatitude,$encodedLongitude';
    String appleMapsUrl =
        'http://maps.apple.com/?daddr=$encodedLatitude,$encodedLongitude&dirflg=d';

    if (Platform.isAndroid) {
      final androidUrl = Uri.parse(
          'geo:$encodedLatitude,$encodedLongitude?q=$encodedLatitude,$encodedLongitude');
      if (await canLaunchUrl(androidUrl)) {
        await launchUrl(androidUrl,
            mode: LaunchMode.externalNonBrowserApplication);
      } else {
        throw 'Could not open Google Maps on Android.';
      }
    } else if (Platform.isIOS) {
      final iosUrl = Uri.parse(appleMapsUrl);
      if (await canLaunchUrl(iosUrl)) {
        await launchUrl(iosUrl, mode: LaunchMode.externalNonBrowserApplication);
      } else {
        final fallbackUrl = Uri.parse(googleMapsUrl);
        if (await canLaunchUrl(fallbackUrl)) {
          await launchUrl(fallbackUrl);
        } else {
          throw 'Could not launch maps.';
        }
      }
    } else {
      final fallbackUrl = Uri.parse(googleMapsUrl);
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl);
      } else {
        throw 'Could not launch maps.';
      }
    }
  }
}
