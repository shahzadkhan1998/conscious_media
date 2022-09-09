import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/colors_resources.dart';

class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton(
      {Key? key,
      this.icon,
      this.shape,
      this.margin,
      this.size,
      this.color,
      this.iconColor})
      : super(key: key);

  final IconData? icon;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? margin;
  final double? size;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: color,
      margin: margin ?? EdgeInsets.all(10.r),
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
      child: IconButton(
        color: colorBlack,
        icon: Padding(
          padding: EdgeInsets.only(left: size ?? 4.0.w, bottom: size ?? 5.0.w),
          child: Icon(icon ?? Icons.arrow_back_ios,
              color: iconColor ?? colorBlack),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class BackButton2 extends StatelessWidget {
  const BackButton2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 30.h,
        width: 30.w,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: colorWhite,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.arrow_back_ios_new, color: colorBlack),
      ),
    );
  }
}
