import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserFollowController extends GetxController {
  var id;
  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getUserId();
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

  ///// User Followed /////////
  getUserId() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc()
        .collection("users")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        id = doc["id"];
        print("iD is ...... $id");
      }
    });
  }
}
