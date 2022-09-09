
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/signup_controller/signup_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_btn.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_custom_password.dart';
import '../../widgets/my_custom_textfield.dart';
import '../follow_topics/follow_one.dart';
import '../search_members/search_member.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final registorController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: BackButton2(),
              ),
              Container(
                child: Image.asset(
                  height: 60.h,
                  Images.splash_logo,
                  width: double.infinity.w,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(SignInScreen());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Container(
                    width: double.infinity.w,
                    child: Text("SIGN UP",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: colorBlack,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 115.h,
                    width: 115.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(240, 240, 240, 100),
                    ),
                    child: InkWell(
                      onTap: ()

                      {
                        registorController.getImage(context);
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            registorController.image == null ?
                             Image.asset("assets/icons/icons.png"):
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(registorController.image!,
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,

                                  ),
                                ),
                            SizedBox(height: 10.h),
                            const Text(
                              "Set photo",
                              style: TextStyle(color: colorBlack),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: MyCustomTextField(
                  controller: registorController.name,
                  hint: "Full name",
                  prefixIcon: Icon(Icons.person_pin, color: appMainColor),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: MyCustomTextField(
                  controller: registorController.email,
                  hint: "Email",
                  prefixIcon: Icon(Icons.email, color: appMainColor),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: MyCustomTextField(
                    controller: registorController.location,
                    hint: "Location",
                    prefixIcon: InkWell(
                      onTap: ()
                        {
                          // print("Tapped");
                          // registorController.getLocation(context);
                        },
                        child: const Icon(Icons.location_on, color: appMainColor)),
                    suffixIcon: Container(
                      height: 19.h,
                      width: 19.w,
                      margin: EdgeInsets.all(6.w),
                      child: FloatingActionButton(
                        backgroundColor: colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        onPressed: () {},
                        child: const Icon(Icons.gps_fixed, color: colorBlue),
                      ),
                    )),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: MyCustomPassword(
                  controller: registorController.password,
                  hint: "Password",
                  prefixIcon: const Icon(Icons.lock_rounded, color: appMainColor),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: MyCustomPassword(
                  controller: registorController.confirmPassword,
                  hint: "Confirm Password",
                  prefixIcon: Icon(Icons.lock, color: appMainColor),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.to(FollowTopicScreen());
                      registorController. validation();

                    },
                    child: MyCustomButton(
                      buttonBackgroungColor: appMainColor,
                      centerText: "CONTINUE",
                      textColor: whiteColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100.h,
                color: const Color(0xffE8F0E7),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: colorBlack,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SignInScreen());
                          },
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                              color: appMainColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
