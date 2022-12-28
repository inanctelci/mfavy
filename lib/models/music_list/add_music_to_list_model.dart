class AddMusicToList {
  AddMusicToList({
    required this.success,
    required this.data,
    required this.message,
  });
  late final int success;
  late final List<Data> data;
  late final String message;

  AddMusicToList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.createdListMusic,
  });
  late final CreatedListMusic createdListMusic;

  Data.fromJson(Map<String, dynamic> json) {
    createdListMusic = CreatedListMusic.fromJson(json['created_listMusic']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['created_listMusic'] = createdListMusic.toJson();
    return _data;
  }
}

class CreatedListMusic {
  CreatedListMusic({
    required this.id,
    required this.listID,
    required this.musicID,
    required this.createdAt,
  });
  late final int id;
  late final int listID;
  late final int musicID;
  late final String createdAt;

  CreatedListMusic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listID = json['listID'];
    musicID = json['musicID'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['listID'] = listID;
    _data['musicID'] = musicID;
    _data['createdAt'] = createdAt;
    return _data;
  }
}
