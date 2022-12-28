class CreateListModel {
  CreateListModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final int success;
  late final List<Data> data;
  late final String message;

  CreateListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.createdList,
  });
  late final CreatedList createdList;

  Data.fromJson(Map<String, dynamic> json) {
    createdList = CreatedList.fromJson(json['created_list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['created_list'] = createdList.toJson();
    return _data;
  }
}

class CreatedList {
  CreatedList({
    required this.id,
    required this.listName,
    required this.thumbnail,
    required this.userID,
    required this.updatedAt,
    required this.createdAt,
    this.lastListened,
  });
  late final int id;
  late final String listName;
  late final String thumbnail;
  late final int userID;
  late final String updatedAt;
  late final String createdAt;
  String? lastListened;

  CreatedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['listName'];
    thumbnail = json['thumbnail'];
    userID = json['userID'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    lastListened = json['lastListened'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['listName'] = listName;
    _data['thumbnail'] = thumbnail;
    _data['userID'] = userID;
    _data['updatedAt'] = updatedAt;
    _data['createdAt'] = createdAt;
    _data['lastListened'] = lastListened;
    return _data;
  }
}
