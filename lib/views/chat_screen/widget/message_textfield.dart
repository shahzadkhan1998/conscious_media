import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors_resources.dart';
class MessageTextField extends StatefulWidget {
  String? currentId;
  String? friendId;
  String? friendName;
  String? image;
  MessageTextField({Key? key, required this.currentId, required this.friendId,required this.friendName,required image})
      : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {


  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorGray,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.send,color: colorGrean,),
              onPressed: () async {
                String messages = _controller.text;
                _controller.clear();
                await FirebaseFirestore.instance
                    .collection('chats')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .add({
                  'message': messages,
                  'senderId': widget.currentId,
                  'receiverId': widget.friendId,
                  "Type": "text",
                  'name': widget.friendName,
                  'date': DateTime.now(),
                  'image':widget.image,
                });



                await FirebaseFirestore.instance
                    .collection("chats")
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .collection('chats')
                    .add({
                  'message': messages,
                  'senderId': widget.currentId,
                  'receiverId': widget.friendId,
                  'name': widget.friendName,
                  "Type": "text",
                  'date': DateTime.now(),
                  "image":widget.image,
                },
                );

              },
          ),
        ],
      ),
    );
  }
}
