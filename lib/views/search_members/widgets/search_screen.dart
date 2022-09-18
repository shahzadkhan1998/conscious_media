import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conscious_media/views/chat_screen/view/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors_resources.dart';

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
           ids = doc["email"];
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
        .where("name", isEqualTo: searchController.text.trim())
        .get()
        .then((value) {
        print(value.docs.length);
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No User Found")));
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
          }, icon:Icon(Icons.arrow_back_ios,color: Colors.black,)),
        ),
        backgroundColor: halfscreen,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller:searchController ,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {

                          // onSearch(ids);
                          print("Clicked");
                          getIds();
                           print(searchResult.length);
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
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(searchResult[index]['image']),
                          ),
                          title: Text(searchResult[index]['name']),
                          subtitle: Text(searchResult[index]['email']),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchController.text = "";
                                });
                                Get.to(
                                  ChatView(
                                    currentId: email,
                                    friendId: searchResult[index]['email'],
                                    name: searchResult[index]['name'],
                                    image:searchResult[index]["image"],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.message)),
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
