class ShareListModel {
  int success = 0;
  List<Data> data = [];
  String message = '';

  ShareListModel({required this.success, required this.data, required this.message});

  ShareListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Arra>? arra;
  Listinfo? listinfo;

  Data({this.arra, this.listinfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['arra'] != null) {
      arra = <Arra>[];
      json['arra'].forEach((v) {
        arra!.add(new Arra.fromJson(v));
      });
    }
    listinfo = json['listinfo'] != null ? new Listinfo.fromJson(json['listinfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arra != null) {
      data['arra'] = this.arra!.map((v) => v.toJson()).toList();
    }
    if (this.listinfo != null) {
      data['listinfo'] = this.listinfo!.toJson();
    }
    return data;
  }
}

class Arra {
  String? createdAt;
  int? id;
  Music? music;

  Arra({this.createdAt, this.id, this.music});

  Arra.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    music = json['music'] != null ? new Music.fromJson(json['music']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    if (this.music != null) {
      data['music'] = this.music!.toJson();
    }
    return data;
  }
}

class Music {
  int? id;
  String? totalRate;
  String? songName;
  String? yMusicID;
  String? thumbnail;
  int? viewCount;
  int? myrate;

  Music({this.id, this.totalRate, this.songName, this.yMusicID, this.thumbnail, this.viewCount, this.myrate});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalRate = json['total_rate'];
    songName = json['songName'];
    yMusicID = json['yMusicID'];
    thumbnail = json['thumbnail'];
    viewCount = json['viewCount'];
    myrate = json['myrate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_rate'] = this.totalRate;
    data['songName'] = this.songName;
    data['yMusicID'] = this.yMusicID;
    data['thumbnail'] = this.thumbnail;
    data['viewCount'] = this.viewCount;
    data['myrate'] = this.myrate;
    return data;
  }
}

class Listinfo {
  String? listName;
  String? thumbnail;

  Listinfo({this.listName, this.thumbnail});

  Listinfo.fromJson(Map<String, dynamic> json) {
    listName = json['listName'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listName'] = this.listName;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
