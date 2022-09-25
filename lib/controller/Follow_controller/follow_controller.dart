import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/utils/global_list.dart';
import 'package:conscious_media/views/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FollowController extends GetxController
{
  var UserFollowedLength = 0;
  var follow = [];
  var id;
  List followedList = [];

  bool isSelected = false;
  toggle()
  {
      isSelected = !isSelected;
      update();
  }


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getUserId();
    await getTopics();
    //await getTopicFollow();
  }
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    getUserId();

  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  // get user id
  getUserId() async {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentuser)
        .collection("users")

        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        id = doc["id"];
        followedList.clear();
        followedList = doc["FollowedUser"];
        update();
        print("iD is ...... $id");
        print("Followed List is ...");
        print(followedList);
        update();

      }
      update();
    });
  }

getTopics() async
{
  final currentUser = FirebaseAuth.instance.currentUser!.email;
  FirebaseFirestore.instance.collection("users").doc(currentUser).collection("users").get().then((QuerySnapshot querySnapshot)
  {
        for(var doc in querySnapshot.docs)
          {
            var alldata = doc["selectedTopics"];
            follow = List<String>.from(alldata);
            print("allTOpcs");
            print(alldata);}
        update();
  });
  update();
}

///<<<<<<<<<<<<<Ends<<<<<<<<<<<<<<<<<<<<<<<//

}