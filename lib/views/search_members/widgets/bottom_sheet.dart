import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors_resources.dart';
import '../../../utils/images.dart';
import '../../../widgets/appbar_back_btn.dart';

class showBottomShe {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25.r),
          topStart: Radius.circular(25.r),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
          start: 20.w,
          end: 20.w,
          bottom: 30.h,
          // top: 8,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '           ',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                Images.bottom_top_panal,
                width: 40.w,
              ),
              Container(
                width: 40.w,
                height: 40.h,
                child: AppbarBackButton(
                  margin: EdgeInsets.only(right: 5.w, top: 5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.r),
                  ),
                  icon: Icons.close,
                  size: 0.sp,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 40.r,
            backgroundImage: AssetImage(Images.person_one),
          ),
          Text(
            'Kathrin Ava',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: colorBlack,
              ),
              Text(
                '12 ST Down town NY',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity.w,
            child: MaterialButton(
              color: appMainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0.r)),
              onPressed: () {},
              child: Text(
                'Follow',
                style: TextStyle(color: colorWhite),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity.w,
            alignment: Alignment.centerLeft,
            child: Text(
              'Topics',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Climate change Sustainability',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Social issues & Human Rights',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Healthy living',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity.w,
            alignment: Alignment.centerLeft,
            child: Text(
              'About me',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity.w,
            alignment: Alignment.centerLeft,
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero id blandit. In risus neque, commodo quis luctus a, convallis quis sapien. Aliquam vitae pharetra nibh. Sed mollis interdum ante sit amet mollis. Vivamus efficitur tincidunt iaculis.',
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
