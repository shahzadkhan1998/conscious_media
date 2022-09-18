import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/search_members/widgets/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/Follow_controller/follow_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import '../../widgets/appbar_back_btn.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_custom_textfield.dart';
import '../bottom_nav_bar.dart';
import '../chat_screen/view/chat_screen.dart';
import '../my_account/my_account.dart';
import 'package:http/http.dart' as http;

//var token = "N2EzYWJjMWUtMGY4ZC00NDcyLWIwMzQtZmM3ZGYyMTBjOTJj";
sentNotification(playerId,heading , content)
{
  Map  body = {
    "app_id":"f07e9a40-4f23-4ee8-9006-d1a1c99c726b",
    "include_player_ids":["$playerId"],
    "contents":{"en":"$content is Followed You"},
    "headings":{"en":"$heading"},
    "data":{"custom_data":"This is Custom Value"}
  };
  Map<String,String> header = {'Content-Type':'application/json','authorization':'Basic N2EzYWJjMWUtMGY4ZC00NDcyLWIwMzQtZmM3ZGYyMTBjOTJj'};
  final response = http.post(Uri.parse("https://onesignal.com/api/v1/notifications?="),headers: header,body:jsonEncode(body)).then((value) {
   print("http response");
    print(value.body);
    print(value.statusCode);

  });



}

class SearchMembersScreen extends StatefulWidget {
  const SearchMembersScreen({Key? key}) : super(key: key);

  @override
  State<SearchMembersScreen> createState() => _SearchMembersScreenState();
}

class _SearchMembersScreenState extends State<SearchMembersScreen> {
  final followcontroller = Get.put(FollowController());

  final imageList = [
    Images.person_one,
    Images.person_two,
    Images.person_three,
    Images.person_three,
  ];
  final title_text = [
    "Adam Smith",
    "Jason Born",
    "John Doe",
    "Alexa Smith",
  ];
  final descrption_text = [
    "Social issues & Human Rights",
    "Jason Born",
    "Healthy living",
    "Eco Homes",
  ];
  @override
  Widget build(BuildContext context) {
    List list  = [];
    final followcontroller = Get.put(FollowController());


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        foregroundColor: colorBlack,
        title: const Text('Search Members'),
        leading: const Padding(
          padding: EdgeInsets.all(13.0),
          child: BackButton2(),
        ),
        actions: [
          InkWell(
            onTap: () {
              _showbottomTabSheet(context);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 12.0.w),
              child: Image.asset(
                Images.appbar_action,
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon:InkWell(
                    onTap: ()
                      {
                        print("Clicked");
                        Get.to(()=>SearchScreen());
                      },
                      child: const Icon(Icons.search)),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "search",
                    fillColor: Colors.white70),
                ),
            ),

            // MyCustomTextField(
            //   color: colorWhite,
            //   border_color: colorWhite,
            //   suffixIcon: const Icon(Icons.search),
            //
            //   hint: "Search...",
            // ),
            SizedBox(height: 10.h),
            Container(
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No Data"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
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
                          child: Text("No user Available"),
                        );
                      }
                      var ids = snapshot.data!.docs[index].id;

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(ids)
                            .collection("users")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<dynamic>> snapshot1) {
                          if (!snapshot1.hasData) {
                            return const Center(
                              child: Text("No data"),
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
                            itemBuilder: (context, index1) {
                              if (snapshot.data!.docs.length < 1) {
                                return const Center(
                                  child: Text("No user Available"),
                                );
                              }
                              var data = snapshot1.data!.docs[index1].data();
                              print("Follow page Data");
                              print(data);

                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data["image"]),
                                ),
                                title: Text(
                                  data["name"],
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                subtitle: Text(
                                  data["location"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                trailing: followcontroller.followedList.contains(data["email"])?
                                MaterialButton(
                                  height: 35.h,
                                  color: appMainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    followcontroller.getTopics();
                                    _showBottomSheet(context, data);
                                  },

                                  child: const Text(
                                    'Followed',
                                    style: TextStyle(color: colorWhite),
                                  ),
                                ):
                                MaterialButton(
                                  height: 35.h,
                                  color: appMainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)),
                                  onPressed: () {
                                    followcontroller.getTopics();
                                    _showBottomSheet(context, data);
                                  },

                                  child: const Text(
                                    'Follow',
                                    style: TextStyle(color: colorWhite),
                                  ),
                                ),


                                onTap: () {
                                  print("object");
                                  setState(
                                    () {
                                      DraggableScrollableSheet(
                                        builder: (BuildContext context,
                                            ScrollController scrollController) {
                                          return Container(
                                            color: Colors.blue[100],
                                            child: ListView.builder(
                                              controller: scrollController,
                                              itemCount: 25,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                    title: Text('Item $index'));
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, data) {
  FollowController _followcontroller = Get.put(FollowController());
  print("status is ..");
  print(_followcontroller.followedList.contains(data["email"]));

  final currentuser = FirebaseAuth.instance.currentUser!.email;
  List list = [];
  var followedList = data["FollowedUser"];
  print("Followed List");
  print(followedList);
  // userinfo
  var name;
  var email;
  var image;
  getCurrentUserInfo()
  {
    final currentuser  = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance.collection("users").doc(currentuser)
        .collection("users").get().then((QuerySnapshot querySnapshot) {
      for(var doc in querySnapshot.docs)
      {
        name = doc["name"];
        email = doc["email"];
        image = doc["image"];
      }
    }).then((value) => print("userInfo retrieved"));
  }
  getCurrentUserInfo();

  print("player id is ......");
  print(data["playerid"]);

  // ad to feed
  feedactivityfollow(ids) async
  {
    CollectionReference feed = FirebaseFirestore.instance.collection("feed");
    feed.doc(ids).collection("feeditem").add({
       "type":"follow",
        "name":name,
        "email":email,
        "image":image,

    });


  }
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
      child: GetBuilder<FollowController>(
          init: FollowController(),
          builder: (controller) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            backgroundColor: colorWhite,
                            child: const Icon(Icons.close, color: colorBlack),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: NetworkImage(
                      data["image"],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data["name"],
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          color: blackColor.withOpacity(0.5)),
                      Text(
                        data["location"],
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: blackColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  controller.followedList.contains(data["email"])
                      ? InkWell(
                          onTap: () {
                            print("status 2");
                            print(_followcontroller.followedList.contains(data["email"]));
                            list = [data["email"]];
                            followedList.add(list);
                            final currentUser =
                                FirebaseAuth.instance.currentUser!.email;
                            print("iam tapped");
                            CollectionReference users = FirebaseFirestore.instance.collection("users");
                            users.doc(currentUser).collection("users").doc(controller.id).update({
                              "FollowedUser":FieldValue.arrayRemove(list),
                            }).then((value) {

                            });
                          },
                          child: MudasirButton(
                            onPressedbtn: () {},
                            width: 258.w,
                            height: 52.h,
                            mergin: EdgeInsets.zero,
                            colorss: appMainColor,
                            child: Text(
                              'Followed',
                              style: TextStyle(
                                color: colorWhite,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            print("status 2");
                            print(_followcontroller.followedList.contains(data["email"]));
                             list.clear();
                            ////
                             list = [data["email"]];
                             print("followed List is...2");
                             print(list);


                             // controller.toogle();
                             final currentUser =
                                 FirebaseAuth.instance.currentUser!.email;
                             print("iam tapped");
                             CollectionReference users = FirebaseFirestore.instance.collection("users");
                             users.doc(currentUser).collection("users").doc(controller.id).update({
                               "FollowedUser":FieldValue.arrayUnion(list),
                             });
                             // add to feed
                             await feedactivityfollow(data["email"]);
                             await sentNotification(data["playerid"],"conscious_media",name);



                          },
                          child: MudasirButton(
                            onPressedbtn: () {},
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
                        ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      Get.to(()=> ChatView(
                        currentId: currentuser,
                        friendId: data["email"],
                        name: data["name"],
                        image: data["image"],

                      ),
                      );
                    },
                    child: MudasirButton(
                      width: 258.w,
                      height: 52.h,
                      mergin: EdgeInsets.zero,
                      colorss: appMainColor,
                      child: Text(
                        'chat',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 25.sp,
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
                    height: 100,
                    child: ListView.builder(
                      itemCount: controller.follow!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 40.h,
                          width: 351.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Color(0xffFAFAFA),
                          ),
                          child: Center(
                            child: Text(
                              controller.follow![index].toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                ]);
          }),
    ),
  );
}

///    bottom Tabsheet
void _showbottomTabSheet(BuildContext context) {
  bool checkedValue = false;
  bool checkedValue1 = false;
  bool checkedValue2 = false;
  bool checkedValue3 = false;
  bool checkedValue4 = false;
  bool checkedValue5 = false;
  bool checkedValue6 = false;
  bool checkedValue7 = false;
  bool checkedValue8 = false;
  bool checkedValue9 = false;

  List<bool> checked = [false, false, true, false, false, true, false, true];
  List<String> TextTiles = [
    "Climate change Sustainability",
    "Social issues & Human Rights",
    "Healthy living",
    "Conscious Fashion & Beauty",
    "Happy news",
    "Eco Homes",
    "Environmental",
    "Mental health",
    "Environmental"
  ];
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
      builder: (context) => StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                padding: EdgeInsetsDirectional.only(
                  start: 12.w,
                  end: 12.w,
                  bottom: 10.h,
                  // top: 8,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '       ',
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
                                backgroundColor: colorWhite,
                                child:
                                    const Icon(Icons.close, color: colorBlack),
                              )),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      DefaultTabController(
                        length: 2,
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: colorGray_notification,
                              borderRadius: BorderRadius.circular(10.0.r)),
                          child: Container(
                            // width: 133.w,
                            height: 35.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.h, vertical: 5.h),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  color: appMainColor,
                                  borderRadius: BorderRadius.circular(10.0.r)),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: const [
                                Tab(text: 'By Topic'),
                                Tab(text: 'By Location'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Climate change Sustainability"),
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),

                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Social issues & Human Rights"),
                            value: checkedValue1,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue1 = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),

                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Healthy living"),
                            value: checkedValue2,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue2 = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),

                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Conscious Fashion & Beauty"),
                            value: checkedValue3,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue3 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Eco Homes"),
                            value: checkedValue4,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue4 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Mental health"),
                            value: checkedValue5,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue5 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Environmental &  Animal Protection"),
                            value: checkedValue6,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue6 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Eco tourism"),
                            value: checkedValue7,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue7 = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Conscious art"),
                            value: checkedValue8,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue8 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                          CheckboxListTile(
                            activeColor: appMainColor,
                            title: Text("Happy news"),
                            value: checkedValue9,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue9 = newValue!;
                              });

                              print(checkedValue);
                              print("dddddddd");
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),

                          // for (var i = 0; i < checked.length; i += 1)
                          //   Row(
                          //     children: [
                          //       Checkbox(
                          //         tristate: true,
                          //         onChanged: i == 4
                          //             ? null
                          //             : (value) {
                          //                 /*setState(() {
                          //             checked[i] = value;
                          //           });*/
                          //               },
                          //         // tristate: i == 1,
                          //         value: checked[i],
                          //       ),
                          //       Text(
                          //         TextTiles[i],
                          //         style: TextStyle(
                          //           fontSize: 16.sp,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                        ],
                      ),
                      MyCustomButton(
                          buttonBackgroungColor: appMainColor,
                          centerText: "APPLY FILTERS",
                          textColor: whiteColor),
                      // MyCustomButton(
                      //   width: double.infinity.w,
                      //   height: 52.h,
                      //   mergin: EdgeInsets.zero,
                      //   colorss: appMainColor,
                      //   onPressedbtn: () {
                      //     Get.to(
                      //       BottomNavBar(),
                      //     );
                      //   },
                      //   child: Text(
                      //     'APPLY FILTERS',
                      //     style: TextStyle(color: colorWhite),
                      //   ),
                      // ),
                    ]),
              );
            },
          ));
}
