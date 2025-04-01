import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitradev1/model/message.dart';

class Conversation {
  String? senderId;
  String? senderName;
  String? receiverId;
  String? receiverName;
  String? lastmsg;
  List<Message>? messages;

  Conversation(
      {this.senderId,
      this.senderName,
      this.receiverId,
      this.receiverName,
      this.lastmsg,
      this.messages});

  Conversation.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot, List<Message>? messages}) {
    senderId = documentSnapshot['senderId'];
    senderName = documentSnapshot['sendeName'];
    receiverId = documentSnapshot['receiverId'];
    receiverName = documentSnapshot['receiverName'];
    lastmsg = documentSnapshot['lastmsg'];
    messages = messages;
  }
}
