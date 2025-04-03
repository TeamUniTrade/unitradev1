import "package:get/get.dart";
import "package:unitradev1/service/post_service.dart";
import "package:unitradev1/controller/auth_controller.dart";
import "package:unitradev1/model/post.dart";

class PostController extends GetxController {
  final PostService postService;

  PostController({required this.postService});
  Rx<List<Post>> postList = Rx<List<Post>>([Post.empty()]);
  List<Post> get posts => postList.value;

  @override
  void onInit() {
    final authController = Get.find<AuthController>();
    if (authController.user != null) {
      fillPostList();
    }
    super.onInit();
  }

  void fillPostList() {
    postList.bindStream(postService.fetchPosts());
  }

  void clear() {
    postList.value = [Post.empty()];
  }

  void createPost(String title, String description, List<String> images,
      double price, String sellerId, List<String> tags) async {
    Post post = Post(
      title: title,
      description: description,
      images: images,
      price: price,
      sellerId: sellerId,
      tags: [],
    );
    await postService.createPost(post);
  }

  Future <List<Post>> searchPosts(String query){
    return postService.searchPosts(query);
  }
}
