import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../export.dart';
import '../models/music/rate_music_model.dart';
import '../models/music/rate_music_req_model.dart';

class RateMusicService {
  final storage = const FlutterSecureStorage();
  var userToken;

  Future<RateMusicModel> rateMusic(RateMusicReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/userMusic-create",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    return RateMusicModel.fromJson(response.data);
  }
}
