
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors_resources.dart';
import '../../utils/font_sizes.dart';
import '../../utils/images.dart';
import '../../utils/onboarding_content.dart';
import '../../widgets/my_button.dart';
import '../auth/login.dart';
import '../auth/sign_up.dart';
import '../member_ship/member_ships.dart';

class OnbordingScreen extends StatefulWidget {
  @override
  _OnbordingScreenState createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  SharedPreferences? preferences;
  int currentIndex = 0;
  PageController? _controller;
  // initailize the sharedprefrence
  initPref() async
  {
    preferences = await SharedPreferences.getInstance();
  }

  /// initailize OneSignal
  void configOneSignal() async
  {
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("f07e9a40-4f23-4ee8-9006-d1a1c99c726b");
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    final status = await OneSignal.shared.getDeviceState();
    final String? playerid = status?.userId;
    print("Player id is ************");
    print(playerid);
    preferences!.setString("oneSignalId", playerid!);
    print("Shred pref data saved .....");
    print(preferences!.getString("oneSignalId"));
  }


  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    initPref();
    configOneSignal();

  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Image.asset(
                height: 100.h,
                Images.splash_logo,
                width: double.infinity.w,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300.h,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              contents[i].title!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            currentIndex == contents.length - 3
                                ? Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: Text(
                                        contents[i].discription!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 23.sp,
                                          color: colorBlack,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Container(
                                      // width: double.infinity,
                                      padding:
                                          currentIndex == contents.length - 2
                                              ? EdgeInsets.symmetric(
                                                  horizontal: 20.w)
                                              : EdgeInsets.symmetric(
                                                  horizontal: 40.w),
                                      child: Text(
                                        currentIndex == contents.length - 2
                                            ? contents[i].discription!
                                            : contents[i].discription!,
                                        textAlign: TextAlign.center,
                                        style:
                                            currentIndex == contents.length - 2
                                                ? TextStyle(
                                                    fontSize: 24.sp,
                                                    color: colorBlack,
                                                  )
                                                : TextStyle(
                                                    fontSize: 24.sp,
                                                    color: colorBlack,
                                                  ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity.w,
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      contents.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 300.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.bottom_onboard),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (currentIndex == contents.length - 1) {
                            Get.to(MemberShipScreen());
                          } else {
                            _controller!.nextPage(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.bounceIn,
                            );
                          }
                        },
                        child: MudasirButton(
                          colorss: colorWhite,
                          text_color: colorBlack,
                          height: 52.h,
                          mergin: EdgeInsets.symmetric(horizontal: 20.h),
                          text: currentIndex == contents.length - 1
                              ? "SIGN UP"
                              : "Next",
                          // onPressedbtn: () {
                          //   if (currentIndex == contents.length - 1) {
                          //     Get.to(MemberShipScreen());
                          //   } else
                          //     _controller!.nextPage(
                          //       duration: Duration(milliseconds: 100),
                          //       curve: Curves.bounceIn,
                          //     );
                          // },
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          if (currentIndex == 0) {
                            Get.offAll(SignInScreen());
                          } else {
                            _controller!.previousPage(
                              duration: Duration(milliseconds: 100),
                              curve: Curves.bounceIn,
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity.h,
                          color: currentIndex == contents.length - 1
                              ? Colors.white30
                              : colorTransprent,
                          child: MudasirButton(
                              mergin: EdgeInsets.zero,
                              colorss: colorTransprent,
                              child: Text(
                                currentIndex == contents.length - 1
                                    ? "Already have an account? SIGN IN"
                                    : "Skip",
                                style: TextStyle(color: colorWhite),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 14.h,
      width: currentIndex == index ? 35.w : 35.w,
      margin: EdgeInsets.only(right: 5.w, top: 5.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index ? appMainColor : Colors.grey,
      ),
    );
  }
}
