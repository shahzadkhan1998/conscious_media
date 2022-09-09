import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors_resources.dart';
import '../../../utils/images.dart';
import '../../search_members/search_member.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({Key? key, this.onPressed}) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Image.asset("assets/images/menu.png"),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        Container(
          child: Image.asset(
            height: 50.h,
            Images.splash_logo,
            width: 60.w,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(SearchMembersScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.search, color: colorGrean),
          ),
        ),
      ],
    );
  }
}
