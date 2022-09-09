
import '../../utils/images.dart';
import 'user_model.dart';

class Message {
  final User? sender;
  final String? avatar;
  final String? time;
  final int? unreadCount;
  final bool? isRead;
  final String? text;

  Message({
    this.sender,
    this.avatar,
    this.time,
    this.unreadCount,
    this.text,
    this.isRead,
  });
}

final List<Message> recentChats = [
  Message(
    sender: addison,
    avatar: Images.chats_person_one,
    time: '01:25',
    text: "typing...",
    unreadCount: 1,
  ),
  Message(
    sender: addison,
    avatar: Images.chats_person_two,
    time: '01:25',
    text: "typing...",
    unreadCount: 2,
  ),
  Message(
    sender: jason,
    avatar: Images.chats_person_three,
    time: '12:46',
    text: "Will I be in it?",
    unreadCount: 0,
  ),
  Message(
    sender: deanna,
    avatar: Images.chats_person_four,
    time: '05:26',
    text: "That's so cute.",
    unreadCount: 0,
  ),
  Message(
      sender: nathan,
      avatar: Images.chats_person_five,
      time: '12:45',
      text: "Let me see what I can do.",
      unreadCount: 0),
  Message(
      sender: nathan,
      avatar: Images.chats_person_one,
      time: '12:45',
      text: "Let me see what I can do.",
      unreadCount: 2),
];

final List<Message> allChats = [
  Message(
    sender: virgil,
    avatar: Images.person_two,
    time: '12:59',
    text: "No! I just wanted",
    unreadCount: 0,
    isRead: true,
  ),
  Message(
    sender: stanley,
    avatar: Images.person_two,
    time: '10:41',
    text: "You did what?",
    unreadCount: 1,
    isRead: false,
  ),
  Message(
    sender: leslie,
    avatar: Images.person_two,
    time: '05:51',
    unreadCount: 0,
    isRead: true,
    text: "just signed up for a tutor",
  ),
  Message(
    sender: judd,
    avatar: Images.person_two,
    time: '10:16',
    text: "May I ask you something?",
    unreadCount: 2,
    isRead: false,
  ),
];

final List<Message> messages = [
  Message(
    sender: addison,
    time: '11:30 PM',
    avatar: addison.avatar,
    text: "Lorem ipsum dolor sit",
  ),
  Message(
    sender: addison,
    time: '11:30 PM',
    avatar: addison.avatar,
    text: "Cras gravida risus sed efficit",
  ),
  Message(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text: "Amet, consectetur adipiscing elit. Nam dapibus ac libero",
  ),
  Message(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text: "Lorem ipsum dolor sit",
  ),
  Message(
    sender: currentUser,
    time: '11:45 PM',
    isRead: true,
    text: "Amet, consectetur adipiscing elit. Nam dapibus ac libero",
  ),
  Message(
    sender: addison,
    time: '11:58 PM',
    avatar: addison.avatar,
    text: "Cras gravida risus sed efficit",
  ),
];
