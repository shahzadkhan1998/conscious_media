import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FollowTopic extends GetxController {
  var data = Get.arguments;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getdoucmentiduser();
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

  var id;
  getdoucmentiduser() async {
    print("iam tape");
    final currentuser = await FirebaseAuth.instance.currentUser;
    var email = currentuser!.email;
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        id = doc["id"];
        print("iD is ...... $id");
      }
    });
  }

  StoreTopicFollow(selectedTopic) async {
    final currentuser = await FirebaseAuth.instance.currentUser;
     var email = currentuser!.email;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(email!).collection("users").doc(id).update({
      "selectedTopics":selectedTopic,
    }).then((value)
    {
      print("FollowTopic is Stored");

    });
  }


}
