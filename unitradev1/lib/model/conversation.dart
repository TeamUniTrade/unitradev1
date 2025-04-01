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

  Conversation.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    senderId = documentSnapshot['senderId'];
    senderName = documentSnapshot['sendeName'];
    receiverId = documentSnapshot['receiverId'];
    receiverName = documentSnapshot['receiverName'];
    lastmsg = documentSnapshot['lastmsg'];
  }
}


// ChatList Model is to display highlights of conversations with people