
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/showPost_controller/show_post_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_btn.dart';
import '../home/widgets/post_container.dart';

class Posted_Posts_Screen extends StatefulWidget {
  const Posted_Posts_Screen({Key? key}) : super(key: key);

  @override
  State<Posted_Posts_Screen> createState() => _Posted_Posts_ScreenState();
}

class _Posted_Posts_ScreenState extends State<Posted_Posts_Screen> {
  final ShowPostController _showpostController = Get.put(ShowPostController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowPostController>(
      init: ShowPostController(),
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 50.0.h),
              child: Container(
                height: 1.sh,
                child: Column(children: [
                  Row(
                    children: [
                      BackButton2(),
                      SizedBox(width: 14.0.w),
                      Text(
                        'Posted',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0.h),

                  ///     Row Start home screen add likes and share
                  ReadPost(
                    post_title: "Jessicaa",
                    post_description: "Eco tourism",
                    // post_image: Images.person_three,
                    post_user_image: Image.asset(Images.person_three),
                    post_title_body:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing eli. Nam dapibus ac libero id blandit',
                    // post_like_btn: () {},
                    post_like_count: '10',
                    post_comment_count: '122',
                  ),

                  // TextField for comments
                  Container(
                    width: 0.8.sw,
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: colorGray_notification,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 13.0.w),
                          child: CircleAvatar(
                            radius: 18.r,
                            child: Image.asset(Images.person_three),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type message ...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     // _showBottomSheet(context);
                        //   },
                        Image.asset(
                          Images.message_send,
                          color: colorGrean,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      }
    );
  }
}
