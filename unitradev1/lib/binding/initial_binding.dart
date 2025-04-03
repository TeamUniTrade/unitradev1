import "package:get/get.dart";
import "package:unitradev1/controller/auth_controller.dart";
import "package:unitradev1/controller/post_controller.dart";
import "package:unitradev1/controller/user_controller.dart";
import "package:unitradev1/service/auth_service.dart";
import "package:unitradev1/service/post_service.dart";
import "package:unitradev1/service/user_service.dart";

class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<AuthController>(
        () async => AuthController(authService: AuthService()),
        permanent: true);

    Get.put<PostController>(PostController(postService: PostService()), permanent: true);
    Get.put<UserController>(UserController(userService: UserService()), permanent: true);
    }
  }

