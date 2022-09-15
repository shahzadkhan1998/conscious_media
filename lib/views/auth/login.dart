
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/signin_controller/signin_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/global_list.dart';
import '../../utils/images.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_custom_password.dart';
import '../../widgets/my_custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  SignInController _signInController = Get.put(SignInController());
  getTopicAndFollower()
  async {
    final currentuser  = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance.collection("users").doc(currentuser).collection("users").get().then((QuerySnapshot querySnapshot)
    {
      for(var doc in querySnapshot.docs)
      {
        topicsList = doc["selectedTopics"] as List;
        followedList = doc["FollowedUser"] as List;

      }
    });
  }
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //await getTopicAndFollower();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
        height: 1.sh,
        child: Column(
            // crossAxisAlignment: CrossAxisAlignment.spaceBetween,

            children: [
              SizedBox(
                height: 25.h,
              ),
              Image.asset(
                height: 100.h,
                Images.splash_logo,
                width: double.infinity.w,
              ),
              Spacer(),
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.member_ship_background),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
                      Row(
                        children: [
                          Text(
                            "Sign in",
                            style: TextStyle(
                              color: colorWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 25.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            "Enter your Login credential",
                            style: TextStyle(color: colorWhite, fontSize: 18.h),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      MyCustomTextField(
                        controller: _signInController.email,
                        hint: "Email",
                        prefixIcon: Icon(Icons.email, color: appMainColor),
                      ),
                      SizedBox(height: 15.h),
                      MyCustomPassword(
                        controller: _signInController.password,
                        hint: "Password",
                        prefixIcon: Icon(Icons.lock_rounded, color: appMainColor),
                      ),
                      SizedBox(height: 8.h),
                      InkWell(
                        onTap: ()
                        {
                          _signInController.resetPassword(_signInController.email.text);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: colorWhite, fontSize: 15.sp),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SignUpScreen()));

                              _signInController.signInWithEmailAndPassword(context);


                        },
                        child: MyCustomButton(
                          buttonBackgroungColor: appMainColor,
                          centerText: "LOGIN",
                          textColor: whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.h,
                        color: Color(0xffE8F0E7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Haven't an account?",
                              style: TextStyle(
                                color: colorBlack,
                                fontSize: ScreenUtil().setSp(14),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: appMainColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
      ),
          )),
    );
  }
}
