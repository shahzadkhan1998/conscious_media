import 'dart:async';
import 'package:conscious_media/utils/colors_resources.dart';
import 'package:conscious_media/views/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnbordingScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: colorSplash,

        body: Center(
          child: Container(
              // color: Colors.black,
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 100),
                      Image.asset(
                        "assets/icons/splash.png",
                        height: 160.h,
                        width: 200.w,
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      Container(
                        height: 100.h,
                        // color: colorSplash,
                        child: SpinKitSpinningLines(
                          size: 40.h,
                          duration: const Duration(milliseconds: 1000),
                          color: colorSplash,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
