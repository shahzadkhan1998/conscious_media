import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors_resources.dart';
import '../../../utils/colors_resources.dart';
import '../widget/message_textfield.dart';
import '../widget/single_message.dart';

class ChatView extends StatefulWidget {
  final currentId;
  final friendId;
  final String name;
  final String image;
   ChatView(
      {Key? key,
        required this.currentId,
        required this.friendId,
        required this.image,
        required this.name})
      : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(widget.currentId);
    print(widget.friendId);
    print(widget.name);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPurple,
        leading: BlendMa(
          child: IconButton(icon:Icon(Icons.arrow_back_ios_new_outlined), onPressed: () {
            Get.back();
          }, ),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image.network(
                widget.image,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
             Text(
              widget.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        children:  [
           Expanded(
              child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .orderBy("date", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> doc =
                        snapshot.data!.docs[index].data();
                        bool isMe = doc["senderId"] == widget.currentId;
                        var messages = doc["message"];
                        return SingleMessage(
                          isMe: isMe,
                          message: messages,
                        );
                      },
                    );
                  }),


           ),

          MessageTextField(currentId: widget.currentId,
            friendName: widget.name,
            friendId: widget.friendId,
            image: widget.image,
          )
        ],
      ),
    );
  }
}
