import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/utils/global_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/follow_topic/follow_topic_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_btn.dart';
import '../../widgets/my_button.dart';
import '../auth/login.dart';
import '../bottom_nav_bar.dart';
int? tapindex;
class FollowTopicScreen extends StatefulWidget {
  const FollowTopicScreen({Key? key}) : super(key: key);

  @override
  State<FollowTopicScreen> createState() => _FollowTopicScreenState();
}

class _FollowTopicScreenState extends State<FollowTopicScreen> with AutomaticKeepAliveClientMixin {
  var list = [];

  var check;


  final FollowTopic _followTopic = Get.put(FollowTopic());
  final imageList = [
    Images.follow_1,
    Images.follow_2,
    Images.follow_3,
    Images.follow_4,
    Images.follow_5,
    Images.follow_6,
    Images.follow_7,
    Images.follow_8,
    Images.follow_9,
    Images.follow_10,
  ];
  final title_text = [
    "Climate change Sustainability",
    "Social issues & Human Rights",
    "Healthy living",
    "Conscious Fashion & Beauty",
    "Eco Homes",
    "Mental health",
    "Environmental & Animal Protection",
    "Eco tourism",
    "Conscious art & Artists ",
    "Happy news",

  ];
  var topicsList;
  List topiclistconvert = [];
  final List<bool> selected = List.generate(20, (i) => false);


  /// get Topics
  getFollowTopics() async
  {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("users").
    doc(currentuser).collection("users").get().then((
        QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        topicsList = doc["selectedTopics"].toString();
        print("Followed Topics is");
        print(topicsList);
        setState(() {

        });
      }
    });
  }

  var a;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getFollowTopics();


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final FollowTopic _followTopic = Get.put(FollowTopic());
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<FollowTopic>(
          assignId: true,
          init: FollowTopic(),
          builder: (logic) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          child: const BackButton2(),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          "Follow topics",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 0.75.sh,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          var images = imageList[index];
                          var text = title_text[index];
                          return InkWell(
                              onTap: () {

                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10.0.h.w),
                                child: Container(
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.darken),
                                      image: Image
                                          .asset(images)
                                          .image,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.low,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(

                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            // height: 70.h,
                                            alignment: Alignment.topLeft,
                                            width: 200,
                                            child: Text(
                                              title_text[index],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: colorWhite,
                                                  fontSize: 30.sp),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .end,
                                          children: [
                                            Container(
                                              width: 100.w,
                                              height: 40.h,
                                              alignment: Alignment.bottomRight,
                                              child: InkWell(
                                                onTap: () async
                                                {
                                                  bool checkstatus = selected[index];

                                                  setState(() => selected[index] = !selected[index]);
                                                  print("status is ....");
                                                  print(selected[index]);
                                                  tapindex = index;
                                                  print(tapindex);
                                                  if (kDebugMode) {
                                                    print("Button is tapped");
                                                  }
                                                  list.clear();
                                                  list.add(text);
                                                  print(list);

                                                  check = list.contains(title_text[index]);
                                                  if (kDebugMode) {
                                                    print("bool......");
                                                  }
                                                  print(check);


                                                  if(checkstatus)
                                                  {
                                                    // _followTopic.StoreTopicFollow(list);
                                                    final currentuser = FirebaseAuth
                                                        .instance.currentUser!
                                                        .email;
                                                    print(currentuser);
                                                    a = await FirebaseFirestore
                                                        .instance.collection(
                                                        "users").
                                                    doc(currentuser).collection(
                                                        "users").doc(
                                                        _followTopic.data
                                                            .toString())
                                                        .get()
                                                        .then((value) async {
                                                      if (value.exists) {
                                                        CollectionReference follow = FirebaseFirestore
                                                            .instance.collection(
                                                            "users");
                                                        await follow.doc(
                                                            currentuser)
                                                            .collection("users")
                                                            .doc(_followTopic.data
                                                            .toString()).update({
                                                          "selectedTopics": FieldValue
                                                              .arrayRemove(list),
                                                        })
                                                            .then((value) {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "Topic unfollowed")));
                                                        });
                                                      }
                                                    });

                                                  }
                                                  if(!checkstatus)
                                                    {
                                                      final currentuser = FirebaseAuth
                                                          .instance.currentUser!
                                                          .email;
                                                      print(currentuser);
                                                      a = await FirebaseFirestore
                                                          .instance.collection(
                                                          "users").
                                                      doc(currentuser).collection(
                                                          "users").doc(
                                                          _followTopic.data
                                                              .toString())
                                                          .get()
                                                          .then((value) async {
                                                        if (value.exists) {
                                                          CollectionReference follow = FirebaseFirestore
                                                              .instance.collection(
                                                              "users");
                                                          await follow.doc(
                                                              currentuser)
                                                              .collection("users")
                                                              .doc(_followTopic.data
                                                              .toString()).update({
                                                            "selectedTopics": FieldValue
                                                                .arrayUnion(list),
                                                          })
                                                              .then((value) {
                                                            ScaffoldMessenger.of(
                                                                context)
                                                                .showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Topic followed")));
                                                          });
                                                        }
                                                      });
                                                    }
                                                },
                                                child: MudasirButton(
                                                  onPressedbtn: () {

                                                  },
                                                  mergin: EdgeInsets.only(
                                                      right: 10.0.h,
                                                      bottom: 10.0.h),
                                                  height: 25.h,
                                                  text_color: colorBlack,
                                                  colorss: selected[index]
                                                      ? Colors.green
                                                      : Colors.white,
                                                  text: selected[index] ? 'Followed' : 'Follow',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (list.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("One Topic Follow Must")));
                      }
                      else {
                        Get.offAll(BottomNavBar());

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => BottomNavBar()));
                        print("rrrrrrrrrrrrrrrrrrrrr");
                      }
                    },
                    child: Container(
                      width: 378.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: appMainColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 20.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
