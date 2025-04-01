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