import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors_resources.dart';
import '../../utils/images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


var feedList = [];
  getFeeds() async
  {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance.collection("feed").doc(currentuser).
    collection("feeditem").get().then((QuerySnapshot snapshot)
    {
      for(var doc in snapshot.docs)
        {
          var alldata = doc.data();
          feedList.add(alldata);
          print("Feed is ...");
          print(feedList);
          setState(() {
            
          });
        }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeeds();
  }
  final imageList = [
    Images.notification_one,
    Images.notification_chats,
    Images.notification_one,
    Images.notification_chats,
  ];
  final title_text = [
    "Lorem ipsum dolor sit amet",
    "John DoeCommented on your post",
    "Notification Title here",
    "New Notification",
  ];
  final descrption_text = [
    "Lorem ipsum dolor sit amet, consectetur...",
    "Comment: ''Awesome and superb''",
    "Lorem ipsum dolor sit amet, consectetur...",
    "Lorem ipsum dolor sit amet",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorWhite,
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        foregroundColor: colorBlack,
        title: Text("Notifications"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Center(
                child: Image.asset(
              Images.notification,
              height: 200,
            )),
            Text("No notifications so far"),*/
           ///code//
            Container(
            child: ListView.builder(
            shrinkWrap: true,
            itemCount: feedList.length ,
           itemBuilder: (BuildContext context, int index)
           {
             return ListTile(
               leading: ClipRRect(
                 borderRadius: BorderRadius.circular(15),
                 child: Image.network(feedList[index]["image"]),
               ),
               title: Text("${feedList[index]["name"]} is Like your Post"),
               subtitle:Text(feedList[index]["email"]),
               trailing: const Icon((Icons.notifications_active)),
             );
           },),
        ),
          ],
        ),
      ),
    );
  }
}
