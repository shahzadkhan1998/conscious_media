import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  // variable Declaration
  // image picker initialization
  File? image;
  var url;


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();




  }
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();

      await getUserLocation();
       await convertToAdress();


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
        storeUserData();;
         print('User is signed in!');
       }
     });
 }
//Store to Cloud Firestore
 storeUserData() async
 {SharedPreferences prefs = await SharedPreferences.getInstance();

   CollectionReference users = FirebaseFirestore.instance.collection('users');
   users.doc(email.text).collection("users").add({
     "name":name.text,
     "email":email.text,
     "location":location.text,
     "password":password.text,
     "confirmPassword":confirmPassword.text,
     "image":url,
     "selectedTopics":"",
      "id":"",
      "FollowedUser":[]
   }).then((value) async
   {
     id = value.id;
     users.doc(email.text).set(
       {
         "email":email.text,
       }
     ).then((value1)
     {
       users.doc(email.text.trim()).collection("users").doc(id).update({
         "id":id
       });
       Get.to(()=>const FollowTopicScreen(),arguments:id);
       print("ids is $id");
     });
     print("Data is Stored");

     prefs.setString("name",name.text.trim());
     prefs.setString("email",email.text.trim());
     prefs.setString("location",location.text.trim());
     prefs.setString("password", password.text.trim()) ;
     prefs.setString("confirmpassword", confirmPassword.text.trim() );
     prefs.setString("image",url);
     print(prefs.getString("name"));
     print(prefs.getString("email"));
     print(prefs.getString("image"));

   });

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
    else if(location.text == "")
    {
      Get.snackbar("Message", "Enter your Location",snackPosition:SnackPosition.BOTTOM,
          backgroundColor: Colors.black,colorText: Colors.white);
    }
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

    else
      {
        Registor();
      }
 }

 // Pick image from gallery

  getImage(context) async
  {
    try {
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera);

      if (pickedFile != null) {
        image = File(pickedFile.path);
        update();
        print("image url is .... $image");
        if(image != null)
          {
            addPhotoTStorage(image!);
          }
      }
      else {
        print('No image selected.');
      }
    }catch(e)
    {
      print(e);
    }

  }

   // Store image to firebase firestore
  Future addPhotoTStorage(File file) async {
    final storage = FirebaseStorage.instance;
    var snapshot = await storage.ref().child(file.path).putFile(file);
     url = await snapshot.ref.getDownloadURL();
    print(url);
    return url;
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


    }
  }

   convertToAdress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!).then((placemarks) {

      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].toString();
        print(output);
      }
      return placemarks;
    });
     
  }
}

