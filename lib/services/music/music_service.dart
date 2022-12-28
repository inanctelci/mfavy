import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../export.dart';
import '../../models/music/music_listener_model.dart';
import '../../models/music/music_listener_req_model.dart';

class MusicService {
  final storage = FlutterSecureStorage();
  var userToken;

  Future<MusicListenerModel> musicListen(MusicListenerReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/viewCounter",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return MusicListenerModel.fromJson(response.data);
  }
}
