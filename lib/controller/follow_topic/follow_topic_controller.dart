import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FollowTopic extends GetxController {
  var data = Get.arguments;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
     // getdoucmentiduser();
    print(data);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }


  StoreTopicFollow(selectedTopic) async {
    print(data);
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    print(currentuser);


  }

var check= true ;
  void toogle()
  {
    check = !check;
    print(check);
    update();

  }
}
