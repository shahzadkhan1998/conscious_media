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
  var followedTopic = [];
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = currentuser!.uid;
    print("current User" + uid);
    //_showpostController.getTopicFollow();
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    print("current user");
    print(currentuser);
    return GetBuilder<ShowPostController>(
      init: ShowPostController(),
      builder: (value) {
        return SafeArea(
          child: Scaffold(
            //bottomNavigationBar: BottomNavBar();
            drawer: CustomDrawer(),
            body: Container(
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  AppbarHome(),
                  SizedBox(
                    height: 10.h,
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("FollowedUser")
                        .doc(currentuser)
                        .collection("FollowedUser")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("No Data"),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data!.docs.length < 1) {
                            return const Center(
                              child: Text("No Data"),
                            );
                          }
                          var followeduser = snapshot.data!.docs[index].data();
                            var Users = snapshot.data!.docs[index]["email"];
                            print("Follow User ids is .....");
                            print(Users);
                            print("....................");
                          print(".............");
                          print("FollowedUser");
                          print(followeduser);
                          print(".............");
                          return Container(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("TopicFollow")
                                  .doc(currentuser)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot1) {
                                if (!snapshot1.hasData) {
                                  return const Center(
                                    child: Text("No Data"),
                                  );
                                }
                                if (snapshot1.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                Map<String, dynamic> data = snapshot1.data!
                                    .data() as Map<String, dynamic>;
                                List<dynamic> followedtopic =
                                    data["selectedTopics"] as List<dynamic>;
                                print("..................");
                                print("Followed Topic");
                                print(followedtopic);
                                print(".......................");
                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("AllPost")
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot<dynamic>>
                                          snapshot2) {
                                    if (!snapshot2.hasData) {
                                      return const Center(
                                        child: Text("No Data"),
                                      );
                                    }
                                    if (snapshot2.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    }
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot2.data!.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index2) {
                                        var ids =
                                            snapshot2.data!.docs[index2].id;
                                        if (snapshot2.data!.docs.length < 1) {
                                          return const Center(
                                            child: Text("No Data"),
                                          );
                                        }

                                        print("....................");
                                        print("The ids is .....");
                                        print(ids);
                                        print("......................");
                                        return Container(
                                          child: StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection("AllPost")
                                                .doc(ids)
                                                .collection("AllPost")
                                                .where("topic",whereIn: followedtopic)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot<dynamic>>
                                                    snapshot3) {
                                              if (!snapshot3.hasData) {
                                                return const Center(
                                                  child: Text("No data"),
                                                );
                                              }
                                              if (snapshot3.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                );
                                              }
                                              return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot3.data!.docs.length,
                                                itemBuilder: (BuildContext context, int index3)
                                                {
                                                  var allPost = snapshot3.data!.docs[index3].data();
                                                  print("...................");
                                                  print("All Post is given below");
                                                  print(allPost);
                                                  print(".......................");
                                                  List topiclist = [];
                                                  var topics  = snapshot3.data!.docs[index3]["topic"];
                                                  topiclist.add(topics);
                                                  print("***********************");
                                                  print("Topics ........");
                                                  print(topiclist);
                                                  print("************************");
                                                  print("\n\n");




                                                  return Container(
                                                    child: StreamBuilder<QuerySnapshot>(
                                                      stream: FirebaseFirestore.instance.collection("AllPost").doc(Users).collection("AllPost").snapshots(),
                                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<dynamic>> snapshot4)
                                                      {
                                                        if(!snapshot4.hasData)
                                                          {
                                                            return const Center(
                                                              child: Text("No Data"),
                                                            );
                                                          }
                                                        if(snapshot4.connectionState == ConnectionState.waiting)
                                                          {
                                                            return const Center(
                                                              child: CircularProgressIndicator.adaptive(),
                                                            );
                                                          }
                                                        return ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: snapshot4.data!.docs.length,
                                                          itemBuilder: (BuildContext context, int index4)
                                                          {
                                                            var FollowedUserData = snapshot4.data!.docs[index4].data();

                                                            print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
                                                            print("FollowedUserData ...........");
                                                            print(FollowedUserData);
                                                            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                                                            return Container();

                                                          },);
                                                      },),
                                                  );
                                                },);
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void CommentsTextFieldBottomSheet(
  BuildContext context,
  index,
  String currentpostid,
  String currentUserid,
) {
  TextEditingController textEditingController = TextEditingController();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<ShowPostController>(
          init: ShowPostController(),
          builder: (value) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, top: 10, bottom: 10),
                    color: Colors.white,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorGray_notification,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 13.0.w),
                              child: CircleAvatar(
                                radius: 18.r,
                                child: Image.asset(Images.person_three),
                              ),
                            ),
                            SizedBox(width: 10.h),
                            Expanded(
                              child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type message ...',
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final currentuser =
                                    FirebaseAuth.instance.currentUser;
                                var email = currentuser!.uid;
                                final prefs =
                                    await SharedPreferences.getInstance();

                                print(index);
                                CollectionReference users = FirebaseFirestore
                                    .instance
                                    .collection('AllPost');

                                await users
                                    .doc(currentUserid)
                                    .collection("AllPost")
                                    .doc(currentpostid)
                                    .collection('comments')
                                    .add({
                                  "commentBy": email,
                                  'comment': textEditingController.text,
                                  "name": prefs.getString('name'),
                                  "image": prefs.getString('image'),
                                  "email1":
                                      FirebaseAuth.instance.currentUser!.email
                                }).then((value) {
                                  var id = value.id;

                                  textEditingController.clear();
                                  print("comment stored");
                                  navigator!.pop(context);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14.0),
                                child: Image.asset(Images.message_send,
                                    color: colorGrean,
                                    height: 20.h,
                                    width: 20.w),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    // child: ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: value.data.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //   return ListTile(
                    //     title: Text(value.comentname),
                    //     leading: CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //         value.commentimage.toString(),
                    //       ),
                    //     ),
                    //     subtitle:Text(value.comment),
                    //   );
                    // },),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("AllPost")
                          .doc(currentUserid)
                          .collection("AllPost")
                          .doc(currentpostid)
                          .collection("comments")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No data"),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (snapshot.data!.docs.length < 1) {
                          return const Center(
                            child: Text(" No Yet Comments"),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, index) {
                              if (snapshot.data!.docs.length < 1) {
                                return const Center(
                                  child: Text(" No Yet Comments"),
                                );
                              }
                              return ListTile(
                                title: Text(snapshot.data!.docs[index]["name"]),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    snapshot.data!.docs[index]["image"],
                                  ),
                                ),
                                subtitle:
                                    Text(snapshot.data!.docs[index]["comment"]),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          });
    },
  );
}
