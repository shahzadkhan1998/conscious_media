import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/my_custom_textfield.dart';

class EditProfileTwoScreen extends StatefulWidget {
  const EditProfileTwoScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileTwoScreen> createState() => _EditProfileTwoScreenState();
}

class _EditProfileTwoScreenState extends State<EditProfileTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(Images.profile_two_screen // fit: BoxFit.cover,
                    ),
                SizedBox(
                  height: 5.h,
                  width: 10.w,
                ),
                // arrowBack(),
                Padding(
                  padding: EdgeInsets.only(top: 40.0.h, left: 20.0.w),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                        color: colorWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Positioned(
                  // top: 150.h,
                  bottom: -50.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(const EditProfileTwoScreen());
                          },
                          child: CircleAvatar(
                            radius: 70.r,
                            backgroundColor: colorWhite,
                            child: Padding(
                              padding: EdgeInsets.all(4.0.h),
                              child: Image.asset(
                                Images.person_two,
                                // fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 10.h),
                Text("Kathrin Ava", style: TextStyle(fontSize: 18.sp)),
                SizedBox(height: 5.h),
                const Text("kathrin22@email.com"),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 52.h,
                          width: double.infinity.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0.r),
                            color: colorGray,
                          ),
                          child: Text("283 Followers",
                              style: TextStyle(
                                  color: colorGrean,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Container(
                          height: 52.h,
                          width: double.infinity.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0.r),
                            color: colorGray,
                          ),
                          child: Text("54 Following",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: colorPurple,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: const Text("Edit Profile"),
                  ),
                  MyCustomTextField(
                      maxLines: 1,
                      hint: "My Following Topics (04)",
                      suffixIcon:
                          const Icon(Icons.arrow_forward_ios, color: colorBlack)),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: const Text("My Location"),
                  ),
                  MyCustomTextField(
                    maxLines: 1,
                    hint: "12 ST Down Town- New York, USA",
                    prefixIcon: const Icon(Icons.location_on, color: appMainColor),
                    suffixIcon: const Icon(Icons.edit, color: colorBlack),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: const Text("About Me"),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0.r),
                      color: colorGray,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                              child: const Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero id blandit. In risus neque, commodo quis luctus a, convallis quis sapien. Aliquam vitae pharetra nibh. Sed mollis interdum ante sit amet mollis. Vivamus efficitur tincidunt iaculis.")),
                        ),
                        const Icon(Icons.edit),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
