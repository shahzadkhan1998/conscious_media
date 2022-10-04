import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/follow_topics/follow_one.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


class SignUpController extends GetxController
{
  double? long;
  double? lat;
  String address = "";
  var id;
  var datacheck;


  // variable Declaration
  // image picker initialization
  File? image;
  var url;

  var toggle = true;




  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
   // await getUserLocation();
   // await convertToAdress();
    await configOneSignal();




  }
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    name.dispose();
    email.dispose();
    location.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  ///// one signal
  configOneSignal() async
  {
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("f07e9a40-4f23-4ee8-9006-d1a1c99c726b");
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes)
    async{
      final prefs = await SharedPreferences.getInstance();
      final status = await OneSignal.shared.getDeviceState();
      final String? playerid = await status?.userId;
      print("Player id is ************");
      print(playerid);
      prefs.setString("oneSignalId", playerid!);
      print("Shred pref data saved .....");
      print(prefs.getString("oneSignalId"));
    });

  }

  /// toggle
  boolcheck()
  {
     toggle = !toggle;
     update();
     print(toggle);
  }

  ////// SignUp Function //////////
 Registor() async
 {

     try {
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
           email: email.text.trim(),
           password: password.text.trim(),
       );
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         print('The password provided is too weak.');
       } else if (e.code == 'email-already-in-use') {
         print('The account already exists for that email.');
       }
     } catch (e) {
       print(e);
     }

     FirebaseAuth.instance
         .userChanges()
         .listen((User? user) {
       if (user == null) {
         print('User is currently signed out!');
       } else {
        storeUserData();
         print('User is signed in!');
       }
     });

 }
//Store to Cloud Firestore
 storeUserData() async
 {
   final pref = await SharedPreferences.getInstance();

   CollectionReference users = FirebaseFirestore.instance.collection('users');
  datacheck =  await users.doc(email.text).collection("users").add({
     "name":name.text,
     "email":email.text,
     "location":country ?? "Location not found",
     "password":password.text,
     "confirmPassword":confirmPassword.text,
     "image":url,
     "selectedTopics":[],
      "id":"",
      "FollowedUser":[],
     "playerid":pref.getString("oneSignalId"),
   }).then((value) async
   {
     id = value.id;
     print("id...");
     print(id);
     updateid(id);
     await users.doc(email.text).set(
       {
         "email":email.text,
       }

     );


     print("Data is Stored");

     pref.setString("name",name.text.trim());
     pref.setString("email",email.text.trim());
     pref.setString("location",location.text.trim());
     pref.setString("password", password.text.trim()) ;
     pref.setString("confirmpassword", confirmPassword.text.trim() );
     pref.setString("image",url);
     // print(prefs.getString("name"));
     // print(prefs.getString("email"));
     // print(prefs.getString("image"));


   });

 if(id != "")
 {
   Get.offAll(()=>const FollowTopicScreen(),arguments:id);
   print("ids is $id");
 }


 }
 /// update id
  updateid(ids)
  {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(email.text).collection("users").doc(ids).update({
      "id":id
    });
   print("id is stored");
  }
 ///// Validation
 validation()
 {
    if(name.text == "")
      {
        Get.snackbar("Message", "Enter your Name",snackPosition:SnackPosition.BOTTOM,
        backgroundColor: Colors.black,colorText: Colors.white
        );
      }
    else if(email.text == "")
      {
        Get.snackbar("Message", "Enter your Email",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }
    // else if(location.text == "")
    // {
    //   Get.snackbar("Message", "Enter your Location",snackPosition:SnackPosition.BOTTOM,
    //       backgroundColor: Colors.black,colorText: Colors.white);
    // }
    else if(password.text == "")
      {
        Get.snackbar("Message", "Enter your password",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }
    else if(confirmPassword.text == "")
      {
        Get.snackbar("Message", "Enter your confirmPassword",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }
    else if(url == null)
      {
        Get.snackbar("Message", "wait a bit ",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }

    else if(country == null)
      {
        Get.snackbar("Message", "Location not found",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }
    else if(image == null)
      {
        Get.snackbar("Message", "select image first",snackPosition:SnackPosition.BOTTOM,
            backgroundColor: Colors.black,colorText: Colors.white);
      }
    else if(password.text != confirmPassword.text)
    {
      Get.snackbar("Message", "Password not matched",snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.black,colorText: Colors.white);
    }
   


    else
      {

        Registor();
        boolcheck();
      }
 }

 // Pick image from gallery

  getImage(context) async
  {
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
        print("image url is .... $image");
        if(image != null)
          {
            addPhotoTStorage(image!,context);
            update();
          }
      }
      else {
        print('No image selected.');
      }
    }catch(e)
    {
      print(e);
    }
    update();

  }

   // Store image to firebase firestore
  Future addPhotoTStorage(File file,context) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(DateTime.now().toString()).putFile(file);
     url = await snapshot.ref.getDownloadURL();
    print(url);
    update();
    return url;
    update();
  }

  /// get current Location

  /// Convert lat and lang into full adress
  getUserLocation()async{
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
      }else{
        print("GPS Location service is granted");
      }
    }else{
      print("GPS Location permission granted.");
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

       long = position.longitude;
       lat = position.latitude;
       print(lat);
       print(long);
       update();


    }
    update();
  }
   var country  ;
   convertToAdress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!).then((placemarks) {

      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        country = placemarks[0].country;
        print(output);
        update();
      }
      return placemarks;
    });
     update();
  }


}

