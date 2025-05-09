// Model class for Post
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? title;
  String? description;
  List<String>? images;
  double? price;
  String? sellerId;
  List<String>? tags;

  Post({
    this.title,
    this.description,
    this.images,
    this.price,
    this.sellerId,
    this.tags,
  });

  Post.empty();

  Post.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    title = documentSnapshot['title'];
    description = documentSnapshot['description'];
    images = List<String>.from(documentSnapshot['images']);
    price = documentSnapshot['price'];
    sellerId = documentSnapshot['sellerId'];
    tags = List<String>.from(documentSnapshot['tags']);
  }
}
