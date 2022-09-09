import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors_resources.dart';
// import 'package:google_fonts/google_fonts.dart';

class MyFontTheme {
  MyFontTheme._();

  static final TextStyle onboarding = TextStyle(
    fontSize: 18.sp,
  );

  static final TextStyle font_16 = TextStyle(
    color: colorWhite,
    fontSize: 16.sp,
  );
  static final TextStyle font_header = TextStyle(fontSize: 10.sp);

  static final TextStyle bodyText1 = TextStyle(
      color: Color(0xffAEABC9),
      fontSize: 14,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w500);

  static final TextStyle bodyTextMessage =
      TextStyle(fontSize: 12, letterSpacing: 1);

  static final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
  );
}

class FontWeightManager {
  static const FontWeight fwExLight = FontWeight.w200;
  static const FontWeight fwLight = FontWeight.w300;
  static const FontWeight fwRegular = FontWeight.w400;
  static const FontWeight fwMedium = FontWeight.w400;
  static const FontWeight fwSemiBold = FontWeight.w600;
  static const FontWeight fwBold = FontWeight.w700;
  static const FontWeight fwExtraBold = FontWeight.w800;
}

class FontSizeManager {
  static const double fs8 = 8.0;
  static const double fs9 = 9.0;
  static const double fs10 = 10.0;
  static const double fs11 = 11.0;
  static const double fs12 = 12.0;
  static const double fs13 = 13.0;
  static const double fs14 = 14.0;
  static const double fs15 = 15.0;
  static const double fs16 = 16.0;
  static const double fs17 = 17.0;
  static const double fs18 = 18.0;
  static const double fs19 = 19.0;
  static const double fs20 = 20.0;
  static const double fs21 = 21.0;
  static const double fs22 = 22.0;
  static const double fs23 = 23.0;
  static const double fs24 = 24.0;
  static const double fs25 = 25.0;
  static const double fs26 = 26.0;
  static const double fs28 = 28.0;
  static const double fs30 = 30.0;
  static const double fs52 = 52.0;
}
