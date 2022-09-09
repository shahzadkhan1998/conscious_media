import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FollowTopic extends GetxController
{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  StoreTopicFollow( selectedTopic) async
  {


    final currentuser = await FirebaseAuth.instance.currentUser;
     var email = currentuser!.email;
    CollectionReference users = FirebaseFirestore.instance.collection('TopicFollow');
    users.doc(email!).set({
      "selectedTopics":selectedTopic,
    }).then((value)
    {
      print("FollowTopic is Stored");

    });

  }

}