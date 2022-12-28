import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mfavymusic/models/mail/send_mail_model.dart';
import 'package:mfavymusic/models/mail/send_mail_req_model.dart';

class ContactService {
  final storage = const FlutterSecureStorage();

  var _userToken;

  get userToken => _userToken;

  set userToken(userToken) {
    _userToken = userToken;
  }

  Future<SendMailModel> sendMail(SendMailReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/sentMail",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return SendMailModel.fromJson(response.data);
    } else {
      return SendMailModel.fromJson(response.data);
    }
  }
}
