import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors_resources.dart';

class MudasirButton extends StatelessWidget {
  MudasirButton(
      {Key? key,
      this.text,
      this.onPressedbtn,
      this.colorss,
      this.child,
      this.text_color,
      this.decoration,
      this.mergin,
      this.height,
      this.width})
      : super(key: key);
  final String? text;
  final Function()? onPressedbtn;
  final Color? colorss;
  final Color? text_color;
  final EdgeInsetsGeometry? mergin;
  final Widget? child;
  final Decoration? decoration;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: colorss ?? colorWhite,
          ),
      height: 52.h,
      margin: mergin ?? EdgeInsets.all(20),
      width: 350.w,
      child: Center(child: child ?? Text(text!)),
    );
  }
}

//////////
///////////////////////////// subhan
///////
class MyCustomButton extends StatelessWidget {
  final String centerText;
  final Color buttonBackgroungColor;
  final Color textColor;
  final IconData? icon;
  Widget? routeTo;

  MyCustomButton({
    required this.buttonBackgroungColor,
    required this.centerText,
    required this.textColor,
    this.icon,
    this.routeTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 369.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: buttonBackgroungColor),
        color: buttonBackgroungColor,
      ),
      child: Center(
        child: Row(
          children: [
            Spacer(),
            icon == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
                    child: Icon(
                      icon,
                      size: 28,
                      color: whiteColor,
                    ),
                  ),
            SizedBox(
              width: 10.h,
            ),
            Text(
              centerText,
              style: TextStyle(
                color: textColor,
                fontSize: 26.sp,
                letterSpacing: 1,
                fontWeight: FontWeight.w300,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class MyCustomButton2 extends StatelessWidget {
  MyCustomButton2(
      {Key? key,
      this.text,
      this.onPressedbtn,
      this.colorss,
      this.child,
      this.text_color,
      this.decoration,
      this.mergin,
      this.height,
      this.width,
      this.icon,
      this.icon_child})
      : super(key: key);
  final String? text;
  final Function()? onPressedbtn;
  final Color? colorss;
  final Color? text_color;
  final EdgeInsetsGeometry? mergin;
  final Widget? child;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final Icon? icon;
  final Widget? icon_child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: height ?? 45.h,
      margin: mergin ?? EdgeInsets.all(20),
      width: width ?? double.infinity,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.w,
              child: icon_child ??
                  Icon(
                    icon!.icon,
                  ),
            ),
            SizedBox(width: 10.w),
            child ?? Text(text!),
          ],
        ),
        onPressed: onPressedbtn!,
        color: colorss ?? Theme.of(context).primaryColor,
        textColor: text_color ?? colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }
}

class MyCustomTabbarButton3 extends StatelessWidget {
  MyCustomTabbarButton3(
      {Key? key,
      this.text,
      this.onPressedbtn,
      this.colorss,
      this.child,
      this.text_color,
      this.decoration,
      this.mergin,
      this.height,
      this.width,
      this.icon,
      this.icon_child})
      : super(key: key);
  final String? text;
  final Function()? onPressedbtn;
  final Color? colorss;
  final Color? text_color;
  final EdgeInsetsGeometry? mergin;
  final Widget? child;
  final Decoration? decoration;
  final double? height;
  final double? width;
  final Icon? icon;
  final Widget? icon_child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: height ?? 45.h,
      margin: mergin ?? EdgeInsets.all(20),
      width: width ?? double.infinity,
      child: FlatButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40.w,
              child: icon_child ??
                  Icon(
                    icon!.icon,
                  ),
            ),
            SizedBox(width: 10.w),
            child ?? Text(text!),
          ],
        ),
        onPressed: onPressedbtn!,
        color: colorss ?? Theme.of(context).primaryColor,
        textColor: text_color ?? colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }
}
