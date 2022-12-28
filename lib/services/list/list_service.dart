import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mfavymusic/models/share_list/share_list_model.dart';
import 'package:mfavymusic/models/share_list/share_list_req_model.dart';

import '../../export.dart';
import '../../models/user_list/change_listName_model.dart';
import '../../models/user_list/change_listName_req_model.dart';
import '../../models/user_list/create_list_model.dart';
import '../../models/user_list/create_list_req_model.dart';
import '../../models/user_list/delete_list_model.dart';
import '../../models/user_list/user_lists_model.dart';

class ListService {
  final storage = const FlutterSecureStorage();

  var _userToken;

  get userToken => _userToken;

  set userToken(userToken) {
    _userToken = userToken;
  }

  Future<UserListsModel> getList(BuildContext context, int sortOpt) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().get(
      "https://mfavy.com/list/userlist/$sortOpt",
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return UserListsModel.fromJson(response.data);
    } else {
      return UserListsModel.fromJson(response.data);
    }
  }

  Future<CreateListModel> createList(CreateListReqModel reqData) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().post(
      "https://mfavy.com/list/list-create",
      data: reqData,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );
    return CreateListModel.fromJson(response.data);
  }

  Future<ChangeListNameModel> changeListName(ChangeListNameReqModel data) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );
    final response = await Dio().patch(
      "https://mfavy.com/list/list-update",
      data: data,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    return ChangeListNameModel.fromJson(response.data);
  }

  Future<DeleteListModel> deleteList(int id) async {
    userToken = await storage.read(key: "accessToken").then(
      (value) async {
        userToken = value!;
        return value;
      },
    );

    final response = await Dio().delete(
      "https://mfavy.com/list/list-delete",
      data: {"id": id},
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      ),
    );

    return DeleteListModel.fromJson(response.data);
  }
}
