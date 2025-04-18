import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? uid;
  String? message;
  String? time;

  Message({this.uid, this.message, this.time});

  Message.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    uid = documentSnapshot['uid'];
    message = documentSnapshot['message'];
    time = documentSnapshot['time'];
  }
}


// Message refers to individual texts a user has sent and received from/to any other user 
// Conversation are interactions in pairs (between 2 users - current user and 1 more user)