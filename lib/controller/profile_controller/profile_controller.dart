import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
{
  var name;
  var image;
  List following = [];
  List topicfollowed = [];
  var location;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getUserinfo();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  /// Get User Info
 getUserinfo()
 {
   final currentuser  = FirebaseAuth.instance.currentUser!.email;
   FirebaseFirestore.instance.collection("users").doc(currentuser).collection("users").get().then((QuerySnapshot querySnapshot) {
     for(var doc in querySnapshot.docs)
       {
         name = doc["name"];
         image = doc["image"];
         following = doc["FollowedUser"];
         topicfollowed = doc["selectedTopics"];
         location = doc["location"];


         print(doc);

         update();


       }
     update();
   });
   update();
 }
}