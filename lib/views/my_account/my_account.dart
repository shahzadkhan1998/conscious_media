import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/utils/global_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller/profile_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_custom_textfield.dart';
import 'my_profile_two.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller  = Get.put(ProfileController());

  getUserinfo()
  {
    final currentuser  = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance.collection("users").doc(currentuser).collection("users").get().then((QuerySnapshot querySnapshot) {
      for(var doc in querySnapshot.docs)
      {
        controller.name = doc["name"];
        controller.image = doc["image"];
        controller.following = doc["FollowedUser"] as List;
        controller.topicfollowed = doc["selectedTopics"] as List;
        controller.location = doc["location"];
        print(doc["name"]);




      }

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserinfo();

  }
  @override
  Widget build(BuildContext context) {
    final controller  = Get.put(ProfileController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.36.sh,
              child: Stack(
                children: [
                  Image.asset(Images.profile_screen // fit: BoxFit.cover,
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
                    top: 160.h,
                    bottom: 0.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundImage: NetworkImage(controller.image),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10.h),
                Text(controller.name, style: TextStyle(fontSize: 22.sp)),
                SizedBox(height: 5.h),
                Text(controller.name,
                    style: TextStyle(fontSize: 18.sp, letterSpacing: 1)),
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
                          child: Text("0 Followers",
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
                          child: Text("${controller.following.length}  Following",
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
                    child: Text("Edit Profile"),
                  ),
                  SizedBox(height: 10.h),
                  MyCustomTextField(
                      maxLines: 1,
                      hint: "${controller.topicfollowed}",
                      suffixIcon:
                          Icon(Icons.arrow_forward_ios, color: colorBlack)),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: Text("My Location"),
                  ),
                  SizedBox(height: 20.h),
                  MyCustomTextField(
                    maxLines: 1,
                    hint: "${controller.location}",
                    prefixIcon: Icon(Icons.location_on, color: appMainColor),
                    suffixIcon: Icon(Icons.edit, color: colorBlack),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: Text("About Me"),
                  ),
                  SizedBox(height: 10.h),
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
                        Icon(Icons.edit),
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
