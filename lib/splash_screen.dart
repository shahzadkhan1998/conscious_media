import 'dart:async';
import 'package:conscious_media/utils/colors_resources.dart';
import 'package:conscious_media/views/auth/login.dart';
import 'package:conscious_media/views/bottom_nav_bar.dart';
import 'package:conscious_media/views/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/signup_controller/signup_controller.dart';
int? isviewed;
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? preferences;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () {
        checkScreen();
        getToken();

      },
    );
  }


  var token;
  getToken() async {
    token = await FirebaseAuth.instance.currentUser?.getIdToken();
    print(token);
    if (token != null) {

      Get.offAll(() => BottomNavBar());
    } else {
      Get.snackbar("Login", "Welcome to Our App");
    }
  }



  initPref() async
  {
    preferences = await SharedPreferences.getInstance();
  }
  void configOneSignal() async
  {
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("f07e9a40-4f23-4ee8-9006-d1a1c99c726b");
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    final status = await OneSignal.shared.getDeviceState();
    final String? playerid = await status?.userId;
    print("Player id is ************");
    print(playerid);
    preferences!.setString("oneSignalId", playerid!);
    print("Shred pref data saved .....");
    print(preferences!.getString("oneSignalId"));
  }





  _storeOnboardInfo() async {
    print("Shared pref called");
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    print(prefs.getInt('onBoard'));
  }

  checkScreen() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isviewed = prefs.getInt('onBoard');
    if(isviewed != 0)
    {
      Get.offAll(OnbordingScreen());
    }
    else
    {
      Get.offAll(const SignInScreen());
    }
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
