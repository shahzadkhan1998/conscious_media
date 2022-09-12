
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors_resources.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/images.dart';
import '../../auth/login.dart';
import '../../bottom_nav_bar.dart';
import '../../follow_topics/follow_one.dart';
import '../../my_account/my_account.dart';
import '../../onboarding/onboarding.dart';
import '../../search_members/search_member.dart';
import '../HomePageScreen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/images/new banner copy.png',
                  height: 180,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                        child: Image.asset(Images.splash_logo, height: 40.h, width: 50.w)),
                    // Text('Welcome on the first conscious social media platform!'),
                    Container(
                      padding: EdgeInsets.only(left: 10,top: 5),
                      child: CommonText(
                          height: 50.h,
                          text:
                              "Welcome on the first conscious social media platform!",
                          font_size: 15.sp),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            setState(() {
                              showPage = HomePageScreen();
                              pageIndex = 0;
                              Get.to(BottomNavBar());
                            });
                          });
                          // Get.to(HomePageScreen());
                        },
                        child: CommonText(text: "Home"),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                          onTap: () {},
                          child: CommonText(text: "Monthly Feature")),
                    ),
                    SizedBox(height: 30.h),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                          onTap: () {
                            Get.to(FollowTopicScreen());
                          },
                          child: CommonText(text: "Topics")),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                          onTap: () {
                            Get.to(SearchMembersScreen());
                          },
                          child: CommonText(text: "Members")),
                    ),
                    SizedBox(height: 30.h),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(onTap: () {}, child: CommonText(text: "Invite")),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              showPage = const EditProfileScreen();
                              pageIndex = 4;
                              Get.to(BottomNavBar());
                            });
                          },
                          child: CommonText(text: "Setting")),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 7, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () async{
                          final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                         await _firebaseAuth.signOut();
                          setState(() {

                          });
                          Get.to(()=>OnbordingScreen());
                        },
                        child: CommonText(
                            text: "Log out", text_color: colorGrean)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CommonText extends StatelessWidget {
  CommonText(
      {Key? key, this.text, this.font_size, this.height, this.text_color})
      : super(key: key);

  final String? text;
  final double? font_size;
  final double? height;
  final Color? text_color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 20,
      width: double.infinity.w,
      child: Text(
        text!,
        style: TextStyle(
            fontSize: font_size ?? 18.sp, color: text_color ?? colorBlack),
      ),
    );
  }
}
