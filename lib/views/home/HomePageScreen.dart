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

  var id;
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
    return GetBuilder<ShowPostController>(
      init: ShowPostController(),
      builder: (value) {
        return SafeArea(
          child: Scaffold(
            //bottomNavigationBar: BottomNavBar();

            drawer: CustomDrawer(),
            body: SingleChildScrollView(
              child: Column(
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
                        .collection("AllPost")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<dynamic>> snapshot1) {
                      if (!snapshot1.hasData) {
                        return const Center(
                          child: Text("No data Found"),
                        );
                      }
                      if (snapshot1.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot1.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          id = snapshot1.data!.docs[index].id;
                          print("Idsssssss" + id);
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('AllPost')
                                    .doc(id)
                                    .collection('AllPost')
                                    .where("topic", whereIn: value.data)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot<dynamic>>
                                        snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: Text("No data Found"),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }

                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var likeuser = [];
                                      var data =
                                          snapshot.data!.docs[index].data();
                                      likeuser.add(data);
                                      print("Like user");
                                     // print(likeuser);

                                      // like
                                      List likes = snapshot.data!.docs[index]
                                          ["like"] as List;

                                      print("likes as:$likes");

                                      List list = [];
                                      for (var key in likes) {
                                        list.add(key);
                                      }
                                      print(list.length);

                                      print(list);

                                      // Map map = {...likes};
                                      // List like = [];
                                      // // print("Likes List");
                                      // // print(map);
                                      // map.forEach((key, value) {
                                      //   if (key == uid) {}
                                      //   like.add(map.keys);
                                      //   print("Likes List");
                                      //   print(like.toString());
                                      // });

                                      // print("LIKES LIST");
                                      //  print(likes);

                                      return Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 10.0.h.w),
                                        child: GestureDetector(
                                          // onTap: (() {
                                          //   Get.to(() => Posted_Posts_Screen());
                                          // }),
                                          onTap: () {},

                                          child: ReadPost(
                                            index: index,
                                            post_title_body: snapshot.data!
                                                .docs[index]["description"]
                                                .toString(),
                                            post_title: snapshot
                                                .data!.docs[index]["name"]
                                                .toString(),
                                            post_image: snapshot
                                                .data!.docs[index]["image"]
                                                .toString(),
                                            post_description: snapshot
                                                .data!.docs[index]["topic"]
                                                .toString(),
                                            list: list,
                                            likeList: likeuser,

                                            // list: [...like],

                                            // click_open_video: () {
                                            //   Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //           builder: (context) => Posted_Posts_Screen()));
                                            // },
                                            // post_like_btn: () {
                                            //   Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //           builder: (context) => Posted_Posts_Screen()));
                                            // },
                                            // post_comments_btn: () {
                                            //   CommentsTextFieldBottomSheet(context);
                                            // },
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
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

void CommentsTextFieldBottomSheet(BuildContext context, index,String currentpostid , String currentUserid  ) {
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
                                  "email1": prefs.getString('email'),
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
                          .doc(value.currentUserid)
                          .collection("AllPost")
                          .doc(value.currentpostid)
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

                        }
                        else if(snapshot.data!.docs.length < 1)
                        {
                          return const Center(
                            child: Text(" No Yet Comments"),
                          );
                        }
                        else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if(snapshot.data!.docs.length < 1)
                                {
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
