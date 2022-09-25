import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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

// location
  getUserLocation()async{
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        print("GPS Location service is granted");
      }
    }else{
      print("GPS Location permission granted.");
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      registorController.long = position.longitude;
      registorController.lat = position.latitude;
      print(registorController.lat);
      print(registorController.long);
      setState(() {

      });


    }

  }

  convertToAdress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(registorController.lat!, registorController.long!).then((placemarks) {

      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        registorController.country = placemarks[0].country;
        print(registorController.country);
        setState(() {

        });
      }
      return placemarks;
    });

  }


  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await getUserLocation();
    await convertToAdress();
  }

  bool buttonState = true;

  void _buttonChange() {
    setState(() {
      buttonState = !buttonState;
    });
  }

  @override
  Widget build(BuildContext context) {
    final registorController = Get.put(SignUpController());
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<SignUpController>(
            assignId: true,
            init: SignUpController(),
            builder: (logic) {
              return SingleChildScrollView(
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
                          Get.to(const SignInScreen());
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
                            height: 130.h,
                            width: 130.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(240, 240, 240, 100),
                            ),
                            child: InkWell(
                              onTap: () {
                                registorController.getImage(context);
                                setState(() {

                                });
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     logic.image == null ?ClipRRect(
                                         borderRadius: BorderRadius.circular(30),
                                         child: Image.asset(
                                             "assets/icons/icons.png")

                                     ):ClipRRect(
                                         borderRadius: BorderRadius.circular(50),
                                         child: Image.file(
                                             logic.image!,
                                           height: 120.h,
                                           width: 120.w,
                                           fit: BoxFit.cover,
                                         )

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
                          prefixIcon: const Icon(Icons.person_pin,
                              color: appMainColor),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: MyCustomTextField(

                          controller: registorController.email,
                          hint: "Email",
                          prefixIcon: const Icon(Icons.email,
                              color: appMainColor),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: MyCustomTextField(
                            readonly: "read only",
                            controller: registorController.location,
                            hint: registorController.country.toString(),
                            prefixIcon: InkWell(
                                onTap: () {
                                  registorController.getUserLocation();
                                  registorController.convertToAdress();
                                },
                                child: const Icon(
                                    Icons.location_on, color: appMainColor)),
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
                                child: const Icon(
                                    Icons.gps_fixed, color: colorBlue),
                              ),
                            )),
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: MyCustomPassword(
                          controller: registorController.password,
                          hint: "Password",
                          prefixIcon: const Icon(Icons.lock_rounded,
                              color: appMainColor),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.sp),
                        child: MyCustomPassword(
                          controller: registorController.confirmPassword,
                          hint: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock,
                              color: appMainColor),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          logic.toggle ?
                          GestureDetector(
                            onTap: () {
                              print("tape");
                              // registorController.boolcheck();
                              registorController.validation();

                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(content: Text(
                              //         registorController.toggle.toString())));
                              // _buttonChange();
                            },
                            child: MyCustomButton(
                              buttonBackgroungColor: appMainColor,
                              centerText: "CONTINUE",
                              textColor: whiteColor,
                            ),

                          ):const CircularProgressIndicator()


                        ],
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
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
                                    Get.to(const SignInScreen());
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
