import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowPostController extends GetxController {
  /// list to save Follow Topics
  var data = Get.arguments;
  //// Ends ////////
  ////// List For To save Full Post ///
  var postlist = [];
  ////// Ends ////////////////
  /////// declare Variable for data manipulation //////
  var id = "";
  var name;
  var currentUserid;
  var title;
  var time;
  var like;
  var image;
  var followers;
  var followTopics;
  var description;
  var comment;
  var topic;
  DateTime? myDateTime;
  /////// End /////////////
  var likecount;
  ////////// Current postid, and id whoes post ///////
  var currentpostid;
  var postuserid;
  //////////////// End /////////

  ////////////// Check current user like or not ///////
  var likechecklist = [];
  //////////// Ends ///////////////
  final currentuser = FirebaseAuth.instance.currentUser;

  /////////////// like counts ///////

  /// save those ids which like post ////////
  var likelist = [];
  //////// Ends/////////////
  /// bool to check if current user already like show heartfill///
  bool likechecking = false;
/////////////// Ends //////////////////
  var prefs;
  ////////// User Info /////////////////

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getFetchIds();
    //await handleLikeStatus();
    await SharedPreferences.getInstance();
    print(currentuser!.email);
    // await handleLikeStatus();
    print(data);
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    // await handleLikeStatus();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  /// Get all Topics which user Followed
  // getTopicFollow() async {
  //   final currentuser = FirebaseAuth.instance.currentUser;
  //   var email = currentuser!.email;
  //   await FirebaseFirestore.instance
  //       .collection('TopicFollow')
  //       .doc(email)
  //       .get()
  //       .then((value) {
  //     update();
  //     List alldata = value.data()!["selectedTopics"];
  //     update();
  //     print(alldata);
  //     update();
  //     sList = List<String>.from(alldata);
  //     update();
  //   });
  //   update();
  // }

  ///<<<<<<<<<<<<<Ends<<<<<<<<<<<<<<<<<<<<<<<//

  // Get all ids  before we fetch post to user
  getFetchIds() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    currentUserid = currentuser!.email;

    await FirebaseFirestore.instance
        .collection('AllPost')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.id);
        id = doc.id;

        update();
      });
      viewPostToUser();
      update();
    });
    update();
  }

  ///<<<<<<<<<<<<<<<<<< Ends ////////////////////

  /// get all Post which user want to show which is followed by user
  viewPostToUser() async {
    await FirebaseFirestore.instance
        .collection('AllPost')
        .doc(id)
        .collection('AllPost')
        .where("followTopics", arrayContainsAny: data)
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          print(doc.id);
          // print(doc.data());
          postlist.add(doc.data());
          update();
          print("controller");
          print(postlist.length);
          name = doc["name"];
          // currentUserid = doc["userid"];
          title = doc["title"];
          time = doc["time"];
          like = doc["like"];
          topic = doc["topic"];
          image = doc["image"];
          followers = doc["followers"];
          followTopics = doc["followTopics"];
          description = doc["description"];
          comment = doc["comment"];
          myDateTime = DateTime.parse(time.toDate().toString());
          currentpostid = doc["postid"].toString();
          postuserid = doc["userid"].toString();
          print("The user id is " + postuserid);
          print("The current post id is " + currentpostid);
          update();
        }
        update();
      },
    );
    update();
  }

  //<<<<<<<<<<<<<< Ends <<<<<<<<<<<<<<<<<<<<<///

  //<<<<<<<<<<<<<<<<<<< codding for like status <<<<<<<<<<<<<<<<<<////

  // handleLikeStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final currentuser = FirebaseAuth.instance.currentUser;
  //   var uid = currentuser!.uid;
  //   FirebaseFirestore.instance
  //       .collection("AllPost")
  //       .doc(currentUserid)
  //       .collection("AllPost")
  //       .doc(currentpostid)
  //       .get()
  //       .then((value) {
  //     var status = value["like"];
  //     Map map = {...status};
  //     print(map.keys);
  //     print(map.values);
  //     var check;
  //     map.forEach((key, value) {
  //       if (key == uid) {
  //         check = value;
  //         likechecklist.add(value);
  //         print(likechecklist);
  //       }
  //     });
  //     print(uid);
  //     print(check);

  //     // var check = map.map((key, value) {
  //     //   if (key == uid) {
  //     //     return value;
  //     //   } else {
  //     //     return ;
  //     //   }
  //     // });

  //     // for (int i = 0; i < key.length; i++) {
  //     //   if (key[i] == uid) {

  //     //   }
  //     // }
  //   });
  // }
}
