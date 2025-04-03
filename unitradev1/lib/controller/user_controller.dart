import "package:get/get.dart";
import "package:unitradev1/model/user.dart";
import "package:unitradev1/service/user_service.dart";
import "package:unitradev1/controller/auth_controller.dart";

class UserController extends GetxController {
  final UserService userService;

  UserController({required this.userService});
  final Rx<User> _user = User().obs;

  User get user => _user.value;
  set user(User value) => _user.value = value;

  @override
  void onInit() {
    final authController = Get.find<AuthController>();
    if(authController.user != null){
      getCurrentUser(authController.user!.uid).then((value)=> user =value);
      }
    super.onInit();
    }

    void clear() {
    _user.value = User();
    }

    Future<bool> createNewUser(User user) async {
      return await userService.createNewUser(user);
    }

    Future<User> getCurrentUser(String uid) async{
      return await userService.getCurrentUser(uid);
    }
}

