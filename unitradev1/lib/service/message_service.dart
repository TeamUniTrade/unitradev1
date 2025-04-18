import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unitradev1/model/conversation.dart';
import 'package:unitradev1/model/message.dart';
import 'package:unitradev1/service/user_service.dart';
import 'package:unitradev1/model/user.dart';

class MessagingService {
    static MessagingService? _instance;
    MessagingService._();
    factory MessagingService() => _instance ??= MessagingService._();

    final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
    final UserService _userService = UserService();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    String getConversationId(String senderId, String receiverId){
      List<String> ids = [senderId, receiverId];
      ids.sort();
      String conversationId = ids.join("_");
      return conversationId;
    }

    Future<void> createConversation(String receiverId) async{
      try{

        String senderId = _auth.currentUser!.uid;
        String conversationId = getConversationId(senderId, receiverId);

        User sender = await _userService.getCurrentUser(senderId);
        User receiver = await _userService.getCurrentUser(receiverId);

        await _firestore.collection("conversations").doc(conversationId).set(
          {
            "senderId": senderId,
            "receiverId": receiverId,
            "lastmsg": "",
            "senderName": sender.username,
            "receiverName": receiver.username,
          }
        );
      }catch(e){
        debugPrint("Error creating conversation: $e");
        rethrow;
      }
    }

    Future<void> sendMessage(String receiverId, String message) async{
      try{
        String senderId = _auth.currentUser!.uid;
        String conversationId = getConversationId(senderId, receiverId);

        DocumentSnapshot conversationDoc = await _firestore.collection("conversations").doc(conversationId).get();

        if(!conversationDoc.exists){
          await createConversation(receiverId);
        }

        await _firestore.collection("conversations").doc(conversationId).collection("messages").add({
          "uid": senderId,
          "message": message,
          "times": DateTime.now()
        });

        await _firestore.collection("conversations").doc(conversationId).update({
          "lastmsg": message
        });

      }catch(e){
        debugPrint("Error sending message: $e");
        rethrow;
      }
    }

  Stream<List<Message>> getMessages(String receiverId) {
    try {
      String senderId = _auth.currentUser!.uid;
      List<String> ids = [senderId, receiverId];
      ids.sort();
      String conversationId = ids.join("_");

      return _firestore
          .collection("conversations")
          .doc(conversationId)
          .collection("messages")
          .orderBy("times", descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Message.fromDocumentSnapshot(documentSnapshot: doc))
              .toList());
    } catch (e) {
      debugPrint("Error getting messages: $e");
      rethrow;
    }
  }

  Stream<List<Conversation>> getConversations(){
    try{
      String currentId = _auth.currentUser!.uid;
      return _firestore.collection("conversations").where(
        Filter.or(
          Filter("senderId", isEqualTo: currentId), Filter("receiverId", isEqualTo: currentId))
      ).snapshots().map((snapshot) => snapshot.docs.map((doc) => Conversation.fromDocumentSnapshot(documentSnapshot: doc)).toList());
    }catch(e){
      debugPrint("Error getting conversations: $e");
      rethrow;
    }
  }

}
