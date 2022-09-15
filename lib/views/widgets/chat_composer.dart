import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_btn.dart';
import '../app_theme.dart';

Container buildChatComposer(
    Widget? circleAvatar, Widget? circleAvatar4, Color? color) {
  return Container(
    padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 20, bottom: 10),
    color: Colors.white,
    // height: 80,
    child: Row(
      children: [
        Expanded(
          child: Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              child: Row(
                children: [
                  circleAvatar!,
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type message ...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _showBottomSheet(context);
                    },
                    child: Container(
                      width: 50.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: circleAvatar4 ??
                            Image.asset(Images.message_send,
                                color: colorGrean, height: 20.h, width: 20.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
