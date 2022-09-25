
import 'package:conscious_media/views/recent_chat/recent_chat.dart';
import 'package:conscious_media/views/screens/create_post/create_new_post.dart';
import 'package:conscious_media/views/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/Follow_controller/follow_controller.dart';
import '../controller/create_post_controller/create_post_controller.dart';
import '../controller/follow_topic/follow_topic_controller.dart';
import '../controller/profile_controller/profile_controller.dart';
import '../controller/showPost_controller/show_post_controller.dart';
import '../utils/colors_resources.dart';

import 'home/HomePageScreen.dart';
import 'my_account/my_account.dart';
import 'notification/notification.dart';

int pageIndex = 0;
Widget showPage = HomePageScreen();

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final HomePageScreen cm_one = HomePageScreen();
  final RecentChat message_two = RecentChat();
  // final EditProfileScreen add_three = EditProfileScreen();
  final CreateNewPostScreen add_three = CreateNewPostScreen();
  final NotificationScreen notification_four = NotificationScreen();
  final EditProfileScreen setting_five = EditProfileScreen();

  // Widget showPage = new Home_Screen();

  Widget pageChooser(int page) {
    switch (page) {
      case 0:
        return cm_one;
        break;
      case 1:
        return message_two;
        break;
      case 2:
        return add_three;
        break;
      case 3:
        return notification_four;
        break;
      case 4:
        return setting_five;
        break;
      default:
        return Container(
          child: Text('No page found'),
        );
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final home = Get.put(ShowPostController());
    final follow = Get.put(FollowTopic());
    final memeber  = Get.put(FollowController());
    final post = Get.put(CreatePostController());
    final account = Get.put(ProfileController());
    
    return SafeArea(
      child: Scaffold(
          // drawer: CustomDrawer(),
          bottomNavigationBar: CurvedNavigationBar(
            index: pageIndex,
            height: 55,
            items: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.asset(
                    "assets/icons/app.png",
                    width: 32.w,
                    height: 16.h,
                  ),
                ),
              ),
              Icon(Icons.chat_sharp, size: 30, color: colorWhite),
              Icon(Icons.add, size: 30, color: colorWhite),
              Icon(Icons.notifications, size: 30, color: colorWhite),
              Icon(Icons.settings, size: 30, color: colorWhite),
            ],
            color: colorBottomNav,
            buttonBackgroundColor: colorBottomNav,
            backgroundColor: Colors.white,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (int tappedIndex) {
              setState(() {
                showPage = pageChooser(tappedIndex);
              });
            },
          ),
          body: Container(
            child: Center(
              child: showPage,
            ),
          )),
    );
  }
}
