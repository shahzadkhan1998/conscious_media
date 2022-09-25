import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/follow_topics/follow_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/bottom_nav_bar.dart';

class SignInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  var sList = [];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    email.dispose();
    password.dispose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    //getTopicFollow();

  }
  bool select = false;
  void toggle()
  {
    select = !select;
    update();
  }

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
      print(alldata);
      update();
      sList = List<String>.from(alldata);
      print(sList);
      update();
    });
    update();
  }

  ///Sign in with email and password
  Future signInWithEmailAndPassword(context) async {
    print("Tapped");
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      update();
      User? user = result.user;
      update();
      if (user != null) {
        if (kDebugMode) {
          print("Current user is available");
          Get.offAll(() => BottomNavBar(),arguments:sList);
          toggle();
        }
      }
      return (user!);
    } catch (e) {
      print(e.toString());
      update();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$e"),
        ),
      );
    }
  }

  /// Validation of Login
  validation(context) {
    if (email.text.isEmpty && password.text.isEmpty) {
      Get.snackbar("Message", "Please check your email and password ",
          backgroundColor: Colors.green);
    }
    else
      {
        signInWithEmailAndPassword(context);
        toggle();
      }
  }


  Future<void> resetPassword(String email) async {
    final  _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
