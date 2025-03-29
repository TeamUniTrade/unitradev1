import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitradev1/model/post.dart';

class PostService {
  static PostService? _instance;
  PostService._();
  factory PostService() => _instance ??= PostService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost(Post post) async {
    try {
      await _firestore.collection("posts").add({
        "title": post.title,
        "description": post.description,
        "images": post.images,
        "price": post.price,
        "sellerId": post.sellerId,
        "tags": post.tags,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<Post>> fetchPosts() {
    return _firestore.collection("posts").snapshots().map((snapshot) {
      List<Post> postVal = [];
      for (var doc in snapshot.docs) {
        postVal.add(Post.fromDocumentSnapshot(documentSnapshot: doc));
      }
      return postVal;
    });
  }

  Future<List<Post>> searchPosts(String query) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection("posts")
          .where("title", isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: '$query\uf8ff')
          .get();

      List<Post> postVal = [];
      for (var doc in snapshot.docs) {
        postVal.add(Post.fromDocumentSnapshot(documentSnapshot: doc));
      }
      return postVal;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
