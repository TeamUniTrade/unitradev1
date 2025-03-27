// User Model
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? school;
  String? username;

  User({this.id, this.name, this.email, this.school, this.username});

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    email = documentSnapshot['email'];
    school = documentSnapshot['school'];
    username = documentSnapshot['username'];
  }
}
