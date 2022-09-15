import 'package:flutter/material.dart';

import '../../../utils/colors_resources.dart';

class SingleMessage extends StatefulWidget {
  final String? message;
  final bool isMe;
  const SingleMessage({Key? key, required this.message, required this.isMe})
      : super(key: key);

  @override
  State<SingleMessage> createState() => _SingleMessageState();
}

class _SingleMessageState extends State<SingleMessage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.isMe ? Colors.grey :colorGrean,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: widget.isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
              bottomRight: widget.isMe
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
            ),
          ),
          child: Text(widget.message.toString(),
            style: TextStyle(
              color: widget.isMe ? Colors.white:Colors.white
            ),
          ),
        ),
      ],
    );
  }
}
