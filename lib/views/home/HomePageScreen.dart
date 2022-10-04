import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/home/widgets/appbar.dart';
import 'package:conscious_media/views/home/widgets/custom_drawer.dart';
import 'package:conscious_media/views/home/widgets/post_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/showPost_controller/show_post_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/global_list.dart';
import '../../utils/images.dart';
import '../bottom_nav_bar.dart';
import '../posted/psotedscreen.dart';

class HomePageScreen extends StatefulWidget {
  final ShowPostController _showpostController = Get.put(ShowPostController());
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ShowPostController _showpostController = Get.put(ShowPostController());

  var allPostList = [];
  List<dynamic> alldata = [];
  List FollwedUser = [];
  List FollowedUserPost = [];
  List topicsList = [];

  final imageList = [
    Images.follow_1,
    Images.follow_2,
    Images.follow_3,
    Images.follow_4,
  ];

  final title_text = [
    "Lorem ipsum ",
    "John DoeCommented  ",
    "Notification ",
    "New Notification",
  ];
  final person_name = [
    "John Doe",
    "Oliva",
    "Edward Smith ",
    "Kathrin's",
  ];
  final subtitle_name = [
    "Conscious Fashion & Beauty",
    "Eco tourism",
    "Healthy living ",
    "Kathrin's",
  ];
  final currentuser = FirebaseAuth.instance.currentUser;
  var uid;

  bool loading = true;

  /// get topics and follwers
  getTopicAndFollower() async {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentuser)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      print("Hiiiiiiiiii1");
      for (var doc in querySnapshot.docs) {
        print("Hiiiiiiiiii2");
        topicsList = doc["selectedTopics"];
        FollwedUser = doc["FollowedUser"];
        print("Home data is");
        print(topicsList);
        print(FollwedUser);
      }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("Hiiiii");
    await getTopicAndFollower();

    setState(() {
      loading = false;
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    allPostList.clear();
    final currentuser = FirebaseAuth.instance.currentUser!.email;

    return GetBuilder<ShowPostController>(
      init: ShowPostController(),
      builder: (value) {
        return SafeArea(
          child: Scaffold(
            //bottomNavigationBar: BottomNavBar();
            drawer: const CustomDrawer(),
            body: Container(
              height: Get.height * 800,
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          const AppbarHome(),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("AllPost")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot<dynamic>>
                                      snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  physics: const ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (snapshot.data!.docs.length < 1) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    var id = snapshot.data!.docs[index].id;

                                    return Container(
                                      child: StreamBuilder<QuerySnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection("AllPost")
                                            .doc(id)
                                            .collection("AllPost")
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    QuerySnapshot<dynamic>>
                                                snapshot1) {
                                          if (!snapshot1.hasData) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }
                                          if (snapshot1.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator
                                                .adaptive();
                                          }

                                          if (snapshot1.hasError) {
                                            return const Center(
                                              child: Text("Error"),
                                            );
                                          }
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            physics: const ScrollPhysics(),
                                            itemCount:
                                                snapshot1.data!.docs.length,
                                            itemBuilder: (BuildContext context,
                                                int index1) {
                                              if (snapshot1.data!.docs.length <
                                                  1) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                );
                                              }

                                              var allPostList = [];
                                              // var allpost  = snapshot1.data!.docs[index1].data() ;
                                              Map<String, dynamic> data =
                                                  snapshot1.data!.docs[index1]
                                                          .data()!
                                                      as Map<String, dynamic>;

                                              print("Allpost List   ********");
                                              print(allPostList);
                                              var topics = snapshot1
                                                  .data!.docs[index1]["topic"];
                                              print("Topics ********");
                                              print(topics);
                                              var userid = snapshot1
                                                  .data!.docs[index1]["userid"];

                                              // Comments and Comments Length
                                              List comments =
                                                  snapshot1.data!.docs[index1]
                                                      ["comment"] as List;
                                              print("Comments..........");
                                              print(comments);
                                              //  List likes = snapshot1.data!.docs[index1]["like"] as List;

                                              // print("Likes");
                                              // print(likes);
                                              // List list = [];
                                              // for (var key in likes) {
                                              //   list.add(key);
                                              // }
                                              // print("Likes list");
                                              // print(likes);

                                              if (topicsList.contains(topics) ||
                                                  FollwedUser.contains(
                                                      userid)) {
                                                Map<String, dynamic> data1 =
                                                    snapshot1.data!.docs[index1]
                                                            .data()!
                                                        as Map<String, dynamic>;
                                                // print("data 1 is ????????????????????????????");
                                                allPostList.add(data1);
                                                //   // like
                                                //  List likes = snapshot1.data!.docs[index1]["like"] as List;

                                                //  print("Likes");
                                                //  print(likes);
                                                //  List list = [];
                                                //  for (var key in likes) {
                                                //    list.add(key);
                                                //  }
                                                //  print("Likes list");
                                                //  print(likes);

                                                // print(allPostList);
                                                //   print("???????????????????????????????????????");
                                                for (int j = 0;
                                                    j < allPostList.length;
                                                    j++) {
                                                  List likes = allPostList[j]
                                                      ["like"] as List;
                                                  print("Likes");
                                                  print(likes);
                                                  List list = [];
                                                  for (var key in likes) {
                                                    list.add(key);
                                                  }
                                                  print("Likes list");
                                                  print(likes);
                                                  print("J value is ........");
                                                  print(j.toString());

                                                  return Container(
                                                    child: ReadPost(
                                                      index: j,
                                                      post_title_body:
                                                          allPostList[j]["name"]
                                                                  .toString() ??
                                                              "No Get Data",
                                                      post_image: allPostList[j]
                                                                  ["image"]
                                                              .toString() ??
                                                          "No Get Data",
                                                      post_title: allPostList[j]
                                                                  ["name"]
                                                              .toString() ??
                                                          "No Get Data",
                                                      post_description:
                                                          allPostList[j]
                                                                      ["topic"]
                                                                  .toString() ??
                                                              "No Get Data",
                                                      post_user_image:
                                                          allPostList[j][
                                                                      "userimage"]
                                                                  .toString() ??
                                                              "No Get value",
                                                      list: list,
                                                      likeList: allPostList,
                                                      comment: comments,
                                                    ),
                                                  );
                                                }

                                                return Container();
                                              } else {
                                                return Container();
                                              }

                                              // return Container();
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
