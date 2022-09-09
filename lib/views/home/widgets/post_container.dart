import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/controller/showPost_controller/show_post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/showPost_controller/show_post_controller.dart';
import '../../../utils/colors_resources.dart';
import '../../../utils/images.dart';
import '../HomePageScreen.dart';

class ReadPost extends StatefulWidget {
  ReadPost({
    Key? key,
    this.post_title,
    this.post_description,
    this.post_user_image,
    this.post_image,
    this.post_time,
    this.index,
    this.list,
    this.likeList,

    // this.post_icon_button,
    // this.post_like_btn,
    // this.post_comments_btn,
    this.post_comment_count,
    this.post_like_count,
    this.post_title_body,
    // this.click_open_video
  }) : super(key: key);
  final int? index;
  List? list = [];
  final String? post_title;
  final String? post_description;
  final String? post_title_body;
  final Image? post_user_image;
  final String? post_image;
  final String? post_time;
  List? likeList = [];
  // final Function()? post_icon_button;
  // final Function()? post_like_btn;
  // final Function()? post_comments_btn;
  final String? post_comment_count;
  final String? post_like_count;

  @override
  State<ReadPost> createState() => _ReadPostState();
}

class _ReadPostState extends State<ReadPost> {
  // final Function()? click_open_video;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.email;
     print('current user id:');
     print(user.toString());
    // print("---------------------");
    // print(widget.likeList);
    // print("---------------------");
    // print(widget.list!.length);

    // final currentuser = FirebaseAuth.instance.currentUser;
    // var uid = currentuser!.uid;
    // print(uid);
    print("like status is ...");
    print(widget.list!.contains(user));

    return GetBuilder<ShowPostController>(
        init: ShowPostController(),
        builder: (value) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.w,
                        backgroundImage: AssetImage(Images.person_one),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.post_title ?? 'John Doe',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "1 h",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.post_description ?? 'Healthy living',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.more_vert)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: double.infinity.w,
                child: Text(
                    widget.post_title_body ??
                        "Healthy living (Lorem ipsum dolor set amet)",
                    style: TextStyle(fontSize: 14.sp),
                    textAlign: TextAlign.start),
              ),
              SizedBox(
                height: 10.h,
              ),
              widget.post_image != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Image.network(
                        height: 158.h,
                        widget.post_image.toString(),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: const Center(child: Text("No Image"))),
              SizedBox(height: 10.h),
              Row(
                children: [
                  widget.list!.contains(user) ?
                  InkWell(
                    onTap: () async {
                      final currentuser = FirebaseAuth.instance.currentUser;
                      var email = currentuser!.email;
                      print(widget.index);
                      var currentpostid =
                          widget.likeList![widget.index!]["postid"];
                      var currentUserid =
                          widget.likeList![widget.index!]["userid"];
                      print("My Current User who did this post : " +
                          currentUserid);
                      print("My Current Post id is : " + currentpostid);
                      print(widget.list);
                      print(user);
                      widget.list!.remove(user);
                      CollectionReference users = FirebaseFirestore
                          .instance
                          .collection('AllPost');
                      users
                          .doc(currentUserid)
                          .collection("AllPost")
                          .doc(currentpostid).update({
                        "like":FieldValue.arrayRemove([email]),
                      });
                      setState(() {

                      });

                    },
                    child:Icon(Icons.favorite),
                  ):InkWell(
                    onTap: () async {
                      final currentuser = FirebaseAuth.instance.currentUser;
                      var email = currentuser!.email;
                      print(widget.index);
                      var currentpostid =
                      widget.likeList![widget.index!]["postid"];
                      var currentUserid =
                      widget.likeList![widget.index!]["userid"];
                      print("My Current User who did this post : " +
                          currentUserid);
                      print("My Current Post id is : " + currentpostid);

                      print(widget.list);
                      print(user);
                      widget.list!.add(user);
                      CollectionReference users = FirebaseFirestore
                          .instance
                          .collection('AllPost');
                      users
                          .doc(currentUserid)
                          .collection("AllPost")
                          .doc(currentpostid).update({
                            "like":widget.list!,
                      });
                      setState(() {

                      });


                    },
                    child:Icon(Icons.favorite_border),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  InkWell(
                      onTap: () {
                        //// Getting Current postid and postuserid /////
                        // value.currentpostid = widget.likeList![widget.index!]
                        //         ["postid"]
                        //     .toString();
                        // value.currentUserid = widget.likeList![widget.index!]
                        //         ["userid"]
                        //     .toString();
                        // print("My Current User who did this post : " +
                        //     value.currentUserid);
                        // print("My Current Post id is : " + value.currentpostid);
                        // value.handleLikeStatus();
                        // value.handleLikeStatus();
                      },
                      child: const Text("Likes  ")),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(value.likechecklist.length.toString(),
                      style: const TextStyle(color: colorTextGray)),
                  SizedBox(
                    width: 40.w,
                  ),
                  Image.asset(
                    Images.chats,
                    height: 20.h,
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  InkWell(
                      onTap: () {
                        print("Tapped");
                        var currentpostid =
                        widget.likeList![widget.index!]["postid"];
                        var currentUserid =
                        widget.likeList![widget.index!]["userid"];
                        print("My Current User who did this post : " +
                            currentUserid);
                        print("My Current Post id is : " + currentpostid,);
                        CommentsTextFieldBottomSheet(context, widget.index,currentpostid,currentUserid);
                      },
                      child: const Text("Comment  ")),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    widget.post_comment_count ?? "43",
                    style: TextStyle(color: colorTextGray),
                  ),
                ],
              ),
              Divider()
            ],
          );
        });
  }
}
