import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Text styles with font and weight which can be used in the app
///
class AppTextStyles {
  static const _fontFamily = 'GothamSSM';

  // Title 01 style with dynamic color input
  static TextStyle title01({Color color = Colors.black}) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700, // Bold
        fontFamily: _fontFamily,
        color: color,
      );

  // Title 01 style with dynamic color input
  static TextStyle titleSemiBold20({Color color = Colors.black}) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400, // Bold
        fontFamily: _fontFamily,
        color: color,
      );

  // Title 01 style with dynami c color input
  static TextStyle titleSemiBold18({Color color = Colors.black}) => TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400, // Bold
        fontFamily: _fontFamily,
        color: color,
      );

  // Title 02 style with dynamic color input
  static TextStyle title02({Color color = Colors.black}) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700, // Bold
        fontFamily: _fontFamily,
        color: color,
      );

  // Title 03 style with dynamic color input
  static TextStyle title03({Color color = Colors.black}) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500, // Medium
        fontFamily: _fontFamily,
        color: color,
      );

  // Body style with dynamic color input
  static TextStyle body({Color color = Colors.black}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600, // Book
        fontFamily: _fontFamily,
        color: color,
      );

  // Input style 14 font size with dynamic color input
  static TextStyle input14({Color color = Colors.black}) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w300, // Light
        fontFamily: _fontFamily,
        color: color,
      );

  // Input style with dynamic color input
  static TextStyle input({Color color = Colors.black}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w300, // Light
        fontFamily: _fontFamily,
        color: color,
      );

  // Hint style with dynamic color input
  static TextStyle hint({Color color = Colors.black}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600, // Book
        fontFamily: _fontFamily,
        color: color,
      );

  // Subtitle style with dynamic color input
  static TextStyle subtitle({Color color = Colors.black}) => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600, // Book
        fontFamily: _fontFamily,
        color: color,
      );

  // Detail style with dynamic color input
  static TextStyle detail({Color color = Colors.black}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600, // Book
        fontFamily: _fontFamily,
        color: color,
      );

  // Detail style light weight with dynamic color input
  static TextStyle detailLight({Color color = Colors.black}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w200, // Book
        fontFamily: _fontFamily,
        color: color,
      );
}
