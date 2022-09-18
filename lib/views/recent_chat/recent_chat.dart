import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/utils/global_list.dart';
import 'package:conscious_media/views/chat_screen/view/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/colors_resources.dart';

class RecentChat extends StatefulWidget {
  const RecentChat({Key? key}) : super(key: key);

  @override
  State<RecentChat> createState() => _RecentChatState();
}

class _RecentChatState extends State<RecentChat> {
  DateTime now = DateTime.now();
  String? formattedTime;
  List Followeduser = [];
  var image;
  var name;
  var email;
  var allUserdata;
  var alluserdataList = [];
  var currentuser;
  var lastMessage;
  var lastMessageList = [];

  getFollowedUser() async {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentuser)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        var Followeduser = doc["FollowedUser"];
        // followedList = List<String>.from(data.toString());

        print("FOllowed User");

        print(Followeduser.runtimeType);
        getFollowedUserid(Followeduser);
      }
      setState(() {});
    });
  }

  getFollowedUserid(ids) {
    print("iam called");
    for (int i = 0; i < ids.length; i++) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(ids[i].toString())
          .collection("users")
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          allUserdata = doc.data();
          alluserdataList.add(allUserdata);

          name = doc["name"];
          email = doc["email"];
          image = doc["image"];

          print("Followed user Data");
          print(alluserdataList.length);
          setState(() {});
          //  print(name);
          //  print(email);
          //  print(image);

        }
      });
    }
  }


  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // await getFollowedUser();
    // formattedTime = DateFormat.jm().format(now);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentuser = FirebaseAuth.instance.currentUser!.email;
    getFollowedUser();
    formattedTime = DateFormat.jm().format(now);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        titleSpacing: 0,
        leading: Center(
          child: Text(
            "chat",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 30.sp,
            ),
          ),
        ),
      ),
      body: alluserdataList.isEmpty ? Center(child: CircularProgressIndicator.adaptive(),):Container(
        height: Get.height,
        child: Column(

          children: [
            Container(
            ),
            Container(
              height: Get.height * 0.80,
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: alluserdataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    alluserdataList[index]["name"],
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  subtitle:Text("waiting"),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                        alluserdataList[index]["image"]),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(formattedTime!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                          height: 20.h,
                                          width: 20.w,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorGrean),
                                          child: const Center(
                                              child: Text(
                                            "1",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                    ],
                                  ),
                                  onTap: () {
                                    print("iam tapped $index");
                                    Get.to(() => ChatView(
                                        currentId: currentuser,
                                        friendId: alluserdataList[index]["email"],
                                        image: alluserdataList[index]["image"],
                                        name: alluserdataList[index]["name"]));
                                  },
                                ),
                                const Divider(),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
