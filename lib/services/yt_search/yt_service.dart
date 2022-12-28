import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../export.dart';
import '../../models/yt_search/yt_search_model.dart';
import '../../models/yt_search/yt_search_req_model.dart';

class YtSearchService {
  final storage = const FlutterSecureStorage();

  var userToken;
  Future<YtSearchModel> searchYt({required List<YtSearchReqModel> data}) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/search-yt",
      data: {"array": data},
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    return YtSearchModel.fromJson(response.data);
  }
}
