import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/chat_screen/view/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/Follow_controller/follow_controller.dart';
import '../../../utils/colors_resources.dart';
import '../../../utils/images.dart';
import '../../../widgets/my_button.dart';
import '../search_member.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;
  var currentUser;
  var email;
  var ids;
  // gert ids
  getIds() {
    FirebaseFirestore.instance.collection("users")
      .get().then((QuerySnapshot snapshot) {
        for (var doc in snapshot.docs) {
           ids = doc.id;
           print(ids);
            onSearch(ids);
        }
      });
  }

  // search Function
   onSearch(id) async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
     await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection("users")
        .where("name", isGreaterThanOrEqualTo: searchController.text.trim())
        .get()
        .then((value) {
        print(value.docs.length);
      if (value.docs.length < 1) {

        setState(() {
          isLoading = false;
        });
        return;
      }
      if (value.docs.length > 0) {
        for (var user in value.docs) {
          searchResult.add(
            user.data(),
          );

          print("This is result  ${searchResult}");
        }
        setState(() {
          isLoading = false;
        });
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    email = FirebaseAuth.instance.currentUser!.email;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: halfscreen,
          leading: IconButton(onPressed: (){
             Get.back();
          }, icon:const Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
        backgroundColor: halfscreen,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller:searchController,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          // onSearch(ids);
                          if (kDebugMode) {
                            print("Clicked");
                          }
                          getIds();
                           if (kDebugMode) {
                             print(searchResult.length);
                           }
                        },
                        child: const Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Search here",
                    fillColor: Colors.grey[200]),
              ),
            ),
            if (searchResult.length > 0)
              Expanded(
                  child: ListView.builder(
                      itemCount: searchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var alldata = searchResult[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(searchResult[index]['image'] ?? "Not get"),
                          ),
                          title: Text(searchResult[index]['name'] ?? "Not get"),
                          subtitle: Text(searchResult[index]['email'] ?? "Not get"),
                          trailing: MaterialButton(
                            height: 35.h,
                            color: appMainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(30.0)),
                            onPressed: () {


                              _showBottomSheet(context, alldata,index);
                            },

                            child:   const Text(
                              'Follow',
                              style: TextStyle(color: colorWhite),
                            )
                          ),
                        );
                      }))
            else if (isLoading == true)
              const Center(
                child: CircularProgressIndicator(),
              ),

          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, data,index) {

  FollowController _followcontroller = Get.put(FollowController());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  List list = [];
  var followedList = data["FollowedUser"];

  print("Followed List");
  print(followedList);

  /// data email
  print(data["email"]);

  // folow check
  print("status 2");
  print(followedList.contains(data["email"]));
  // userinfo
  var name;
  var email;
  var image;
  getCurrentUserInfo()
  {
    final currentuser  = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance.collection("users").doc(currentuser)
        .collection("users").get().then((QuerySnapshot querySnapshot) {
      for(var doc in querySnapshot.docs)
      {
        name = doc["name"];
        email = doc["email"];
        image = doc["image"];
      }
    }).then((value) => print("userInfo retrieved"));
  }
  getCurrentUserInfo();

  print("player id is ......");
  print(data["playerid"]);

  // ad to feed
  feedactivityfollow(ids) async
  {
    CollectionReference feed = FirebaseFirestore.instance.collection("feed");
    await feed.doc(ids).collection("feeditem").add({
      "type":"follow",
      "name":name,
      "email":email,
      "image":image,

    });


  }

  final List<bool> selected = List.generate(20, (i) => false);
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topEnd: Radius.circular(25.r),
        topStart: Radius.circular(25.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        bottom: 30.h,
        // top: 8,
      ),
      child: GetBuilder<FollowController>(
          init: FollowController(),
          builder: (controller) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '     ',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        Images.bottom_top_panal,
                        width: 40.w,
                      ),
                      Container(
                          width: 30.w,
                          height: 30.h,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: colorWhite,
                            child: const Icon(Icons.close, color: colorBlack),
                          )),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CircleAvatar(
                    radius: 50.r,
                    backgroundImage: NetworkImage(
                      data["image"] ?? "not Get",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data["name"] ?? "No Get",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          color: blackColor.withOpacity(0.5)),
                      Text(
                        data["location"] ?? "Not Get",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: blackColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  followedList.contains(data["email"]) ?
                  InkWell(
                    onTap: () {
                      controller.toggle();
                      print("${controller.isSelected}");
                      print("status 2");
                      print(_followcontroller.followedList.contains(data["email"]));
                      list = [data["email"]];
                      followedList.add(list);
                      final currentUser =
                          FirebaseAuth.instance.currentUser!.email;
                      print("iam tapped");
                      CollectionReference users = FirebaseFirestore.instance.collection("users");
                      users.doc(currentUser).collection("users").doc(controller.id).update({
                        "FollowedUser":FieldValue.arrayRemove(list),
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data["email"]} is unFollowed")));
                      });
                    },
                    child: MudasirButton(
                      onPressedbtn: () {},
                      width: 258.w,
                      height: 52.h,
                      mergin: EdgeInsets.zero,
                      colorss: appMainColor,
                      child: Text(
                        'Followed',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                      : InkWell(
                    onTap: () async {

                      list.clear();
                      ////
                      list = [data["email"]];
                      print("followed List is...2");
                      print(list);


                      // controller.toogle();
                      final currentUser =
                          FirebaseAuth.instance.currentUser!.email;
                      print("iam tapped");
                      CollectionReference users = FirebaseFirestore.instance.collection("users");
                      users.doc(currentUser).collection("users").doc(controller.id).update({
                        "FollowedUser":FieldValue.arrayUnion(list),
                      }).then((value) async {
                        await feedactivityfollow(data["email"]);
                        await sentNotification(data["playerid"],"conscious_media",name);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data["email"]} is Followed")));
                      });
                      // add to feed

                    },
                    child: MudasirButton(
                      onPressedbtn: () {},
                      width: 258.w,
                      height: 52.h,
                      mergin: EdgeInsets.zero,
                      colorss: appMainColor,
                      child: Text(
                        'Follow',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () {
                      Get.to(()=> ChatView(
                        currentId: currentuser,
                        friendId: data["email"],
                        name: data["name"],
                        image: data["image"],

                      ),
                      );
                    },
                    child: MudasirButton(
                      width: 258.w,
                      height: 52.h,
                      mergin: EdgeInsets.zero,
                      colorss: appMainColor,
                      child: Text(
                        'chat',
                        style: TextStyle(
                          color: colorWhite,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Topics',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: blackColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      itemCount: controller.follow!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return controller.follow.length == 0 ?const Text("No Get Topics") :
                        Container(
                          height: 40.h,
                          width: 351.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Color(0xffFAFAFA),
                          ),
                          child: Center(
                            child: Text(
                              controller.follow![index].toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'About me',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: blackColor.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: double.infinity.w,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam dapibus ac libero id blandit. In risus neque, commodo quis luctus a, convallis quis sapien. Aliquam vitae pharetra nibh. Sed mollis interdum ante sit amet mollis. Vivamus efficitur tincidunt iaculis.',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w300),
                    ),
                  ),
                ]);
          }),
    ),
  );
}
