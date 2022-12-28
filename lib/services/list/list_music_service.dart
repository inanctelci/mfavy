import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mfavymusic/models/share_list/share_list_model.dart';

import '../../export.dart';
import '../../models/music_list/add_music_to_list_model.dart';
import '../../models/music_list/add_music_to_list_req_model.dart';
import '../../models/music_list/delete_music_from_list_model.dart';
import '../../models/music_list/delete_music_from_list_req_model.dart';
import '../../models/music_list/list_music_model.dart';

class ListMusicService {
  final storage = const FlutterSecureStorage();
  var userToken;

  Future<ListMusicModel> getList(int listId) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/musiclist",
      data: {'listID': listId},
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    // final data = await json.decode(response.data);

    // print(data);

    if (response.statusCode == 200) {
      return ListMusicModel.fromJson(response.data);
    } else {
      return ListMusicModel.fromJson(response.data);
    }
  }

  Future<AddMusicToList> addMusicToList(AddMusicToListReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/listMusic-create",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return AddMusicToList.fromJson(response.data);
  }

  Future<DeleteMusicModel> deleteMusicFromList(DeleteMusicReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().delete(
      "https://mfavy.com/list/listMusic-delete",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return DeleteMusicModel.fromJson(response.data);
  }

  Future<ShareListModel> getSharedList(int listID) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().get(
      "https://mfavy.com/list/share-list/$listID",
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return ShareListModel.fromJson(response.data);
  }
}
