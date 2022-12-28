import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../export.dart';
import '../models/top_rate/top_rated_songs_model.dart';

class TopService {
  final storage = const FlutterSecureStorage();

  var userToken;

  Future<TopRatedSongsModel> getDailyTopList(bool sortOpt, int page) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().get(
      "https://mfavy.com/list/homemusic/1",
      queryParameters: {
        'page': page,
      },
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return TopRatedSongsModel.fromJson(response.data);
  }

  Future<TopRatedSongsModel> getWeeklyTopList(int sortOpt, int page) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().get(
      "https://mfavy.com/list/homemusic/2",
      queryParameters: {
        'page': page,
      },
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return TopRatedSongsModel.fromJson(response.data);
  }

  Future<TopRatedSongsModel> getMonthlyTopList(int sortOpt, int page) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().get(
      "https://mfavy.com/list/homemusic/3",
      queryParameters: {
        'page': page,
      },
      options: Options(
        headers: <String, dynamic>{
          'Authorization': 'Bearer $userToken',
        },
      ),
    );
    return TopRatedSongsModel.fromJson(response.data);
  }
}
