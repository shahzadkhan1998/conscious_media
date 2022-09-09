
import 'package:conscious_media/views/screens/widgets/custom_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/my_button.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../widgets/widgets.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, @required this.user}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
  final User? user;
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appMainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0.w),
        child: CustomTabbar(
          image: InkWell(
              onTap: () {
                _showBottomSheet(context);
              },
              child: Image.asset(Images.chats_person_one)),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                // padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: colorWhite,
                    boxShadow: [BoxShadow(spreadRadius: 40, blurRadius: 40)]),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Conversation(user: widget.user!),
                ),
              ),
            ),
            buildChatComposer(
                Text(""),
                Image.asset(Images.message_send,
                    color: colorWhite, height: 20.h, width: 20.w),
                colorGrean),
          ],
        ),
      ),
    );
  }
}

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
              '     ',
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
                width: 30.w,
                height: 30.h,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: colorBlack),
                  backgroundColor: colorWhite,
                )),
          ],
        ),
        SizedBox(height: 20.h),
        CircleAvatar(
          radius: 50.r,
          backgroundImage: AssetImage(Images.person_one),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Kathrin Ava',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: blackColor.withOpacity(0.5)),
            Text(
              '12 ST Down town NY',
              style: TextStyle(
                  fontSize: 16.sp, color: blackColor.withOpacity(0.5)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        MudasirButton(
          width: 258.w,
          height: 52.h,
          mergin: EdgeInsets.zero,
          colorss: appMainColor,
          child: Text(
            'Follow',
            style: TextStyle(
              color: colorWhite,
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
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
              fontSize: 18.sp,
              color: blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 40.h,
          width: 351.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Color(0xffFAFAFA),
          ),
          child: Center(
            child: Text(
              'Climate change Sustainability',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 40.h,
          width: 351.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Color(0xffFAFAFA),
          ),
          child: Center(
            child: Text(
              'Social issues & Human Rights',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 40.h,
          width: 351.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: Color(0xffFAFAFA),
          ),
          child: Center(
            child: Text(
              'Healthy living',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity.w,
          alignment: Alignment.centerLeft,
          child: Text(
            'About me',
            style: TextStyle(
              fontSize: 18.sp,
              color: blackColor.withOpacity(0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.infinity.w,
          alignment: Alignment.centerLeft,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero id blandit. In risus neque, commodo quis luctus a, convallis quis sapien. Aliquam vitae pharetra nibh. Sed mollis interdum ante sit amet mollis. Vivamus efficitur tincidunt iaculis.',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
          ),
        ),
      ]),
    ),
  );
}
