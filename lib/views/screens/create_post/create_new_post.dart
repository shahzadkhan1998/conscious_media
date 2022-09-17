import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/follow_topics/follow_one.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/create_post_controller/create_post_controller.dart';
import '../../../controller/showPost_controller/show_post_controller.dart';
import '../../../utils/colors_resources.dart';
import '../../../utils/global_list.dart';
import '../../../utils/images.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_custom_textfield.dart';
import '../../bottom_nav_bar.dart';
List<String> a= ["A","D"];
class CreateNewPostScreen extends StatefulWidget {
  CreateNewPostScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewPostScreen> createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  final CreatePostController _createPostController =
      Get.put(CreatePostController());

  TextEditingController topic = TextEditingController();
// Note pass in calling function
  String? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    ShowPostController _showPostController = Get.put(ShowPostController());
    return GetBuilder<CreatePostController>(
      init: CreatePostController(),
      builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(45),
              left: ScreenUtil().setWidth(12),
              right: ScreenUtil().setWidth(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create New Post",
                      style: TextStyle(fontSize: ScreenUtil().setSp(18)),
                    ),
                    Container(
                      height: 30.h,
                      width: 30.w,
                      child: FloatingActionButton(
                        backgroundColor: colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        onPressed: () {},
                        child: const Icon(Icons.close, color: colorBlack),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
                MyCustomTextField(
                  controller: _createPostController.description,
                  hint: "What's on your mind?",
                  maxLines: 3,
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: ()
                  {

                  },
                  child: InkWell(
                    onTap: ()
                    {
                      _createPostController.getImage(context);
                    },
                    child: Container(
                      height: 120.h,
                      width: double.infinity.w,
                      decoration: BoxDecoration(
                        color: colorGray,
                        // border: Border.all(color: colorBlack),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Add Photo/Video"),
                          ),
                          SizedBox(height: 10.h),
                          _createPostController.image == null ?
                          Align(
                            alignment: Alignment.center,
                              child: Image.asset("assets/icons/icons.png")):
                          Align(
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.file(_createPostController.image!,
                                height: 40,
                                width: Get.width,
                                fit: BoxFit.cover,

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // MyCustomTextField(
                //   hint: "Add a topic",
                //   maxLines: 1,
                // ),
                TextField(
                  controller: _createPostController.topic,
                  decoration: InputDecoration(
                    suffixIcon: DropdownButton(
                      hint: _dropDownValue == null
                          ? const Text('Add Topic')
                          : Text(
                              _dropDownValue!,
                              style: const TextStyle(color: Colors.black),
                            ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: const TextStyle(color: Colors.black),
                      items:  _createPostController.sList.map(
                        ( val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                          () {
                            _dropDownValue = val as String?;
                          },
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                MyCustomTextField(
                  controller: _createPostController.title,
                  hint: "Add a title",
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () async
                  {

                        await _createPostController.validation(_dropDownValue!);


                          await Get.to(()=>BottomNavBar());


                    // _createPostController.getTopicFollow();
                  },
                  child: MudasirButton(
                    height: 52.h,
                    mergin: EdgeInsets.zero,
                    width: double.infinity.w,
                    colorss: appMainColor,
                    child: const Text(
                      'POST NOW',
                      style: TextStyle(color: colorWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
