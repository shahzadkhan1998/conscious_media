
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../auth/login.dart';
import '../auth/sign_up.dart';

class MemberShipScreen extends StatefulWidget {
  const MemberShipScreen({Key? key}) : super(key: key);

  @override
  State<MemberShipScreen> createState() => _MemberShipScreenState();
}

class _MemberShipScreenState extends State<MemberShipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      // crossAxisAlignment: CrossAxisAlignment.spaceBetween,

      children: [
        Column(children: [
          SizedBox(height: 30),
          Image.asset(
              height: 100.h, Images.splash_logo, width: double.infinity.w)
        ]),
        Spacer(),
        Container(
          height: MediaQuery.of(context).size.height * 0.70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            image: const DecorationImage(
              image: AssetImage(Images.member_ship_background),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "SELECT YOUR MEMBERSHIP \nTO CONTINUE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorWhite,
                  fontSize: ScreenUtil().setSp(20.sp),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Container(
                    width: double.infinity.w,
                    height: 135.h,
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Are you an amazing\n ',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: colorBlack,
                            ),
                            children: [
                              TextSpan(
                                text: 'PRIVATE\n',
                                style: TextStyle(
                                  color: colorGrean,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'world-saver?',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 12.h,
                          width: double.infinity.w,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward_outlined,
                              color: appMainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              InkWell(
                onTap: () {
                  Get.to(SignInScreen());
                },
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Container(
                    height: 135.h,
                    width: double.infinity.w,
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Are you a conscious\n ',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: colorBlack,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    'business or organization\n'.toUpperCase(),
                                style: TextStyle(
                                  color: colorGrean,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'working on making the\n',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: colorBlack,
                                ),
                              ),
                              TextSpan(
                                text: 'world a better place?',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 12.h,
                          width: double.infinity.w,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_forward_outlined,
                              color: appMainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
