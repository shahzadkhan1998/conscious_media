import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/home/HomePageScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/bottom_nav_bar.dart';

class CreatePostController extends GetxController {
  var list = [];
  var sList = [];
  var likes = [];
  var userimage;
  var postid;
  var postidu;
  var comments = [];

  File? image;
  var url;
  var name;
  var id;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController topic = TextEditingController();
  var user;

  @override
  void onInit() async {
    // TODO: implement onInit
    user = FirebaseAuth.instance.currentUser!.email;
    if (kDebugMode) {
      print(user);
    }

    super.onInit();

    await getCurrentUser();
    await getTopic();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getCurrentUser();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  /// Toggle
  bool checkstatus = false;

  void toggle() {
    checkstatus = !checkstatus;
    update();
  }

  /// Get Name of the Current user /// Current user name ////
  /// its need because Who do a post
  getCurrentUser() async {
    final currentuser = await FirebaseAuth.instance.currentUser;
    var email = currentuser!.email;
    FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        name = doc["name"];
        userimage = doc["image"];
        id = doc["id"];
        print(id);
      });
    });
  }

  /// Get all topic which current
  //user followed
  /// which topic he Followed///
  getTopic() async {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentuser)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List topicsList = doc["selectedTopics"];
        sList = List<String>.from(topicsList);
        update();
      }
    });
  }

  /// Store all Post to firebase
  storeAllPost(topic) async {
    final prefs = await SharedPreferences.getInstance();
    final currentuser = await FirebaseAuth.instance.currentUser;
    var email = currentuser!.email;
    CollectionReference users =
        FirebaseFirestore.instance.collection('AllPost');
    users.doc(email).collection("AllPost").add({
      "title": title.text,
      "description": description.text,
      "image": url,
      "topic": topic,
      "followTopics": sList,
      "time": DateTime.now(),
      "comment": comments,
      "like": likes,
      "likeCount": "",
      "followers": "",
      "name": name,
      "userimage": userimage,
      "userid": email,
      "postid": postid,
    }).then((value) {
      postid = value.id;
      users.doc(email).set({
        "email": email.toString(),
      }).then((value) {});
      updateAllPostId();
    }).then((value) {
      print("Post is stored");
      checkstatus = false;
      Get.to(() => BottomNavBar());
      title.clear();
      description.clear();
    });
  }

  /////// update post id ////////
  updateAllPostId() async {
    final currentuser = await FirebaseAuth.instance.currentUser;
    var email = currentuser!.email;
    CollectionReference users =
        FirebaseFirestore.instance.collection('AllPost');
    users.doc(email).collection("AllPost").doc(postid).update({
      "postid": postid,
    });
    print("$postid");
    update();
  }

  /// store Curent user Post to firestore
  storeCurrentUserPost(topic) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserPost');
    users.doc(user).collection("UserPost").add({
      "title": title.text,
      "description": description.text,
      "image": url,
      "topic": topic,
      "time": DateTime.now(),
      "comment": comments,
      "like": likes,
      "likeCount": "",
      "followers": "",
      "name": name,
      "userid": user,
      "userimage": userimage,
      "postid": "",
    }).then((value) async {
      users.doc(user).set({
        "email": user.toString(),
      });
      postidu = value.id;
      await updateUserPostId();
    });

    print("Post is stored");
  }

  ////// update  postid for user//
  updateUserPostId() async {
    final currentuser = await FirebaseAuth.instance.currentUser!.email;

    CollectionReference users =
        FirebaseFirestore.instance.collection('UserPost');
    users.doc(currentuser).collection("UserPost").doc(postidu).update({
      "postid": postidu,
    }).then((value) {
      print("$postidu");
      print("post Success");
    }).then((value) {
      users.doc(currentuser).set({
        "email": currentuser,
      });
    });

    update();
  }

  ///////////Ends//////////////

  /// Get image from gallery

  getImage(context) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
        print("image url is .... $image");
        addPhotoTStorage(image!);
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print(e);
    }
  }

  /// add Image to Firebase Storage
  // Store image to firebase firestore
  Future addPhotoTStorage(File file) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(file.path).putFile(file);
    url = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print(url);
    }
    return url;
  }
///// validation of Create post

  validation(String topic) async {
    if (title.text == "") {
      Get.snackbar("message", "Name is missing");
    } else if (description.text == "") {
      Get.snackbar("message", "Note is missing");
    } else if (topic == "") {
      Get.snackbar("message", "topic is missing");
    } else if (image == null) {
      Get.snackbar("message", "image is missing ");
    } else {
      await storeAllPost(topic);
      await storeCurrentUserPost(topic);
      toggle();
    }
  }
}
