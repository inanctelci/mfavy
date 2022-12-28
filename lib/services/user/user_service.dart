import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../export.dart';
import '../../models/user/user_login_model.dart';
import '../../models/user/user_register_req_model.dart';

class UserService {
  final storage = const FlutterSecureStorage();
  Future<UserRegisterModel> registerUser(UserRegisterReqModel data) async {
    final response = await Dio().post(
      "https://mfavy.com/list/register",
      data: data,
    );
    return UserRegisterModel.fromJson(response.data);
  }

  Future<UserLoginModel> loginUser(UserRegisterReqModel data) async {
    final response = await Dio().post(
      "https://mfavy.com/list/login",
      data: data,
    );

    await storage.write(key: "accessToken", value: UserLoginModel.fromJson(response.data).data[0].tokens.accessToken);
    return UserLoginModel.fromJson(response.data);
  }
}
