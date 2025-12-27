import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalTextStyles {
  static TextStyle get otpTileText {
    return TextStyle(
      color: Colors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle get otpDetailsText {
    return TextStyle(
      color: Colors.black,
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
    );
  }
}
