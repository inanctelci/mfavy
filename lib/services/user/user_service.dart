import 'package:flutterframework/export.dart';
class UserService {
  static UserService? _instace;
  static UserService? get instance {
    _instace ??= UserService._init();
    return _instace;
  }

  UserService._init();

  Future<UserModel> getUsers() async {
    return await NetworkService.instance.http<UserModel>(
      '/api/breeds/image/random',
      UserModel(),
      Methods.get,
    );
  }
}
