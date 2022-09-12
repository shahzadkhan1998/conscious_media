import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FollowController extends GetxController
{
  var UserFollowedLength = 0;
  var follow;
   var isSelected = false;
  var id;

  toogle() {
    isSelected = !isSelected;
    update();
  }


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getTopicFollow();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  ///// follow Topic ////////
getTopicFollow() async {
  final currentuser = FirebaseAuth.instance.currentUser;
  var email = currentuser!.email;
  await FirebaseFirestore.instance
      .collection('TopicFollow')
      .doc(email)
      .get()
      .then((value) {
    update();
    List alldata = value.data()!["selectedTopics"];
    update();
    //print(alldata);
    update();
    print("Selected Topics");
    follow = List<String>.from(alldata);
    print(follow);

    update();
  });
  update();
}

///<<<<<<<<<<<<<Ends<<<<<<<<<<<<<<<<<<<<<<<//

}