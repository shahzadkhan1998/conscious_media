import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors_resources.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../app_theme.dart';
import 'package:flutter/material.dart';

import '../screens/chat_room.dart';

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    @required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, int index) {
                  final message = messages[index];
                  bool isMe = message.sender!.id == currentUser.id;
                  return Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: isMe
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.6),
                                decoration: BoxDecoration(
                                    color: isMe
                                        ? colorGrean
                                        : colorGray_notification,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(isMe ? 12.r : 0),
                                      topRight: Radius.circular(16.r),
                                      bottomLeft: Radius.circular(16.r),
                                      bottomRight:
                                          Radius.circular(isMe ? 0 : 12.r),
                                    )),
                                child: Text(
                                  messages[index].text!,
                                  style: TextStyle(
                                      color:
                                          isMe ? colorWhite : Colors.grey[800],
                                      fontSize: isMe ? 16.sp : 16.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
