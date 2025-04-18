import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  String? senderId;
  String? senderName;
  String? receiverId;
  String? receiverName;
  String? lastmsg;

  Conversation(
      {this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.lastmsg,
  });

  Conversation.empty();

  Conversation.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    senderId = documentSnapshot['senderId'];
    senderName = documentSnapshot['senderName'];
    receiverId = documentSnapshot['receiverId'];
    receiverName = documentSnapshot['receiverName'];
    lastmsg = documentSnapshot['lastmsg'];
  }
}


// ChatList Model is to display highlights of conversations with people