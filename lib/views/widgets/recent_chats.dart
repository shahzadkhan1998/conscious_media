import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/colors_resources.dart';
import '../models/message_model.dart';
import '../../helper/screen.dart';

import '../app_theme.dart';

class RecentChats extends StatefulWidget {
  const RecentChats({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentChats> createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backwardsCompatibility: false,
          backgroundColor: colorWhite,
          foregroundColor: colorBlack,
          title: Text('Chat'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: recentChats.length,
                  itemBuilder: (context, int index) {
                    final recentChat = recentChats[index];
                    return Container(
                        // margin: const EdgeInsets.only(top: 20),
                        child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatRoom(
                                user: recentChat.sender,
                              );
                            }));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 60.h,
                                width: 60.w,
                                child: Image.asset(recentChat.avatar!),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    recentChat.sender!.name!,
                                    style: MyTheme.heading2.copyWith(
                                      fontSize: 16.sp,
                                    ),
                                  ),

                        Text(
                          recentChat.text!,
                          style: MyTheme.bodyText1,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),

                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    recentChat.time!,
                                    style: MyTheme.bodyTextTime,
                                  ),
                                  if (recentChat.unreadCount!.toString() == "3" ||
                                      recentChat.unreadCount!.toString() ==
                                          "2" ||
                                      recentChat.unreadCount!.toString() == "1")
                                    CircleAvatar(
                                      radius: 14.r,
                                      backgroundColor: colorGrean,
                                      child: Text(
                                        recentChat.unreadCount!.toString(),
                                        style: TextStyle(color: colorWhite),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
