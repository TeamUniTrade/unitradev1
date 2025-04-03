import "package:get/get.dart";
import "package:unitradev1/service/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;
import "package:unitradev1/model/user.dart";
import "package:unitradev1/controller/user_controller.dart";
import "package:unitradev1/controller/post_controller.dart";

class AuthController extends GetxController {
  final AuthService authService;

  AuthController({required this.authService});

  final Rx<auth.User?> _user =
      Rx<auth.User?>(auth.FirebaseAuth.instance.currentUser);
  auth.User? get user => _user.value;

  @override
  onInit() {
    _user.bindStream(authService.authStateChanges());
    super.onInit();
  }

  void clear() {
    _user.value = null;
  }

  Future<void> createUser(String name, String email, String password,
      String school, String username) async {
    try {
      auth.UserCredential authResult =
          await authService.signUp(name, email, password);
      if (authResult.user == null) {
        throw Exception("User is null");
      }
      _user.value = authResult.user;
      User user = User(
        id: authResult.user!.uid,
        name: name,
        email: email,
        school: school,
        username: username,
      );
      final userController = Get.find<UserController>();
      if (await userController.createNewUser(user)) {
        userController.user = user;
        final postController = Get.find<PostController>();
        postController.fillPostList();
        // TO-DO: message controller, route to home page
      } else {
        throw Exception("Failed to create user in database");
      }
    } catch (e) {
      Get.snackbar(
        "Error creating account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      e.printError();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      auth.UserCredential authResult = await authService.login(email, password);
      _user.value = authResult.user;

      final userController = Get.find<UserController>();
      userController.user =
          await userController.getCurrentUser(authResult.user!.uid);
      final postController = Get.find<PostController>();
      postController.fillPostList();
      // TODO: message controller, route to home page
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await authService.logout();
      clear();
      Get.find<UserController>().clear();
      Get.find<PostController>().clear();
      // TO-DO: route to login page
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    }
  }
}
