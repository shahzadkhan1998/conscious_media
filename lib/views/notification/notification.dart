import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors_resources.dart';
import '../../utils/images.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final imageList = [
    Images.notification_one,
    Images.notification_chats,
    Images.notification_one,
    Images.notification_chats,
  ];
  final title_text = [
    "Lorem ipsum dolor sit amet",
    "John DoeCommented on your post",
    "Notification Title here",
    "New Notification",
  ];
  final descrption_text = [
    "Lorem ipsum dolor sit amet, consectetur...",
    "Comment: ''Awesome and superb''",
    "Lorem ipsum dolor sit amet, consectetur...",
    "Lorem ipsum dolor sit amet",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        foregroundColor: colorBlack,
        title: Text("Notifications"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Center(
                child: Image.asset(
              Images.notification,
              height: 200,
            )),
            Text("No notifications so far"),*/
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: ListView.builder(
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60.h,
                          child: ListTile(
                            dense: true,
                            minLeadingWidth: 40.w,
                            minVerticalPadding: 9.h,
                            visualDensity: VisualDensity.compact,
                            leading: Container(
                              width: 45.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: colorGray_notification,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0.r),
                                child: Image.asset(
                                  width: 10.w,
                                  height: 10.h,
                                  imageList[index],
                                ),
                              ),
                            ),
                            title: Text(title_text[index]),
                            subtitle: Text(
                              descrption_text[index],
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
