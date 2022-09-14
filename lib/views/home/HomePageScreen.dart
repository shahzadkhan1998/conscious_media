import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/home/widgets/appbar.dart';
import 'package:conscious_media/views/home/widgets/custom_drawer.dart';
import 'package:conscious_media/views/home/widgets/post_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/showPost_controller/show_post_controller.dart';
import '../../utils/colors_resources.dart';
import '../../utils/global_list.dart';
import '../../utils/images.dart';
import '../bottom_nav_bar.dart';
import '../posted/psotedscreen.dart';

class HomePageScreen extends StatefulWidget {
  final ShowPostController _showpostController = Get.put(ShowPostController());
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final ShowPostController _showpostController = Get.put(ShowPostController());

  var allPostList = [];
  List<dynamic> alldata = [];
  List FollwedUser = [];
  List FollowedUserPost = [];

  final imageList = [
    Images.follow_1,
    Images.follow_2,
    Images.follow_3,
    Images.follow_4,
  ];

  final title_text = [
    "Lorem ipsum ",
    "John DoeCommented  ",
    "Notification ",
    "New Notification",
  ];
  final person_name = [
    "John Doe",
    "Oliva",
    "Edward Smith ",
    "Kathrin's",
  ];
  final subtitle_name = [
    "Conscious Fashion & Beauty",
    "Eco tourism",
    "Healthy living ",
    "Kathrin's",
  ];
  final currentuser = FirebaseAuth.instance.currentUser;
  var uid;



  bool loading =true;


  /// get topics and follwers
  getTopicAndFollower()
  async {
    final currentuser  = FirebaseAuth.instance.currentUser!.email;
   await FirebaseFirestore.instance.collection("users").doc(currentuser).collection("users").get().then((QuerySnapshot querySnapshot)
    {
      for(var doc in querySnapshot.docs)
        {
         topicsList = doc["selectedTopics"].toString();
           followedList = doc["FollowedUser"].toString();

        }
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await getTopicAndFollower();

    setState(() {
      loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    allPostList.clear();
    final currentuser = FirebaseAuth.instance.currentUser!.email;

    return GetBuilder<ShowPostController>(
      init: ShowPostController(),
      builder: (value) {
        return SafeArea(
          child: Scaffold(
            //bottomNavigationBar: BottomNavBar();
            drawer: CustomDrawer(),
            body: Container(
              height: double.infinity,
              child:loading?Center(child: CircularProgressIndicator(color: Colors.grey,)): Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  AppbarHome(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("AllPost").snapshots(),

                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
                        if(!snapshot.hasData)
                          {
                            return const Center(
                              child: Text("No Data"),
                            );
                          }
                        if(snapshot.connectionState == ConnectionState.waiting)
                          {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }

                         return ListView.builder(
                           shrinkWrap: true,
                           itemCount: snapshot.data!.docs.length,
                           itemBuilder: (BuildContext context, int index) {
                             var id = snapshot.data!.docs[index].id;


                             return Container(
                               child: StreamBuilder<QuerySnapshot>(
                                 stream: FirebaseFirestore.instance.collection("AllPost").doc(id).collection("AllPost").snapshots(),
                                 builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<dynamic>> snapshot1) {
                                   if(!snapshot1.hasData)
                                     {
                                       return const Center(
                                         child: Text("No Data"),
                                       );
                                     }
                                   if(snapshot1.connectionState == ConnectionState.waiting)
                                     {
                                       return CircularProgressIndicator.adaptive();
                                     }
                                   return ListView.builder(
                                     shrinkWrap: true,
                                     itemCount: snapshot1.data!.docs.length,
                                     itemBuilder: (BuildContext context, int index1)
                                     {
                                       var allPostList = [];
                                       var allpost  = snapshot1.data!.docs[index1].data() ;
                                       allPostList.add(allpost);
                                       var topics = snapshot1.data!.docs[index1]["topic"];

                                       print("Topics ********");
                                       print(topics);

                                       var userid = snapshot1.data!.docs[index1]["userid"];
                                       print("TopicsList ");
                                       print(topicsList);
                                       print("FollowedList ");
                                       print(followedList);
                                       List likes = snapshot1.data!.docs[index1]["like"] as List;

                                       print("Likes");
                                       print(likes);
                                       List list = [];
                                        for (var key in likes) {
                                        list.add(key);
                                       }
                                       print("Likes list");
                                       print(likes);


                                       if(topicsList.contains(topics) || followedList.contains(userid))
                                         {
                                           return Container(
                                             child: ReadPost(
                                               index: index1,
                                               post_title_body: allpost["description"],
                                               post_image: allpost["image"],
                                               post_title: allpost["name"],
                                               post_description: allpost["topic"],
                                               list: list,
                                               likeList: allPostList,
                                             ),

                                           );
                                           return Container();
                                         }
                                       else{
                                         return Container();

                                       }

                                      // return Container();
                                     },

                                   );

                                 },),
                             );
                           },);




                      },),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
