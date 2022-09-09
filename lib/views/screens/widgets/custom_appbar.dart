import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors_resources.dart';
import '../../../utils/images.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({Key? key, this.image}) : super(key: key);

  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        // elevation: 5,
        height: 200,
        decoration: BoxDecoration(
            color: appMainColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r))),

        child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 35,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.0.w, top: 8.0.h, bottom: 8.0.h),
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8.r)),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: colorWhite),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            /*AppbarBackButton(color: Colors.white30, size: 5.sp)*/
            title: Row(
              children: [
                Container(
                    height: 50.h,
                    width: 40.w,
                    child: image ?? Image.asset(Images.chats_person_one)),
                const Text("\t\tJohn Doe")
              ],
            )),
      ),
    );
  }
}
