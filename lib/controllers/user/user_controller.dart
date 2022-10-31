import 'package:flutterframework/export.dart';
class UserController extends GetxController {
  var user = UserModel().obs;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  Future getUsers() async {
    user.value = await UserService.instance!.getUsers();
  }
}
