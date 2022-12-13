class MusicListModel {
  MusicListModel({
    required this.success,
    required this.datas,
    required this.message,
  });
  late final int success;
  late final List<Datas> datas;
  late final String message;

  MusicListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    datas = List.from(json['datas']).map((e) => Datas.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['datas'] = datas.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Datas {
  Datas({
    required this.data,
    required this.pagination,
  });
  late final List<Data> data;
  late final Pagination pagination;

  Datas.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    pagination = Pagination.fromJson(json['pagination']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['pagination'] = pagination.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.listName,
    required this.lastListened,
    required this.thumbnail,
    required this.createdAt,
    required this.musics,
  });
  late final int id;
  late final String listName;
  late final String lastListened;
  late final String thumbnail;
  late final String createdAt;
  late final List<Musics> musics;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['listName'];
    lastListened = json['lastListened'];
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
    musics = List.from(json['musics']).map((e) => Musics.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['listName'] = listName;
    _data['lastListened'] = lastListened;
    _data['thumbnail'] = thumbnail;
    _data['createdAt'] = createdAt;
    _data['musics'] = musics.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Musics {
  Musics({
    required this.createdAt,
    required this.music,
  });
  late final String createdAt;
  late final Music music;

  Musics.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    music = Music.fromJson(json['music']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['music'] = music.toJson();
    return _data;
  }
}

class Music {
  Music({
    required this.id,
    required this.songName,
    required this.yMusicID,
    required this.thumbnail,
    required this.viewCount,
    required this.totalRate,
    required this.myrate,
  });
  late final int id;
  late final String songName;
  late final String yMusicID;
  late final String thumbnail;
  late final int viewCount;
  late final String totalRate;
  late final int myrate;

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    songName = json['songName'];
    yMusicID = json['yMusicID'];
    thumbnail = json['thumbnail'];
    viewCount = json['viewCount'];
    totalRate = json['total_rate'];
    myrate = json['myrate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['songName'] = songName;
    _data['yMusicID'] = yMusicID;
    _data['thumbnail'] = thumbnail;
    _data['viewCount'] = viewCount;
    _data['total_rate'] = totalRate;
    _data['myrate'] = myrate;
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.totalRecords,
    required this.totalPerpage,
    required this.totalPage,
    required this.currentPage,
    this.nextPage,
    this.previousPage,
  });
  late final int totalRecords;
  late final int totalPerpage;
  late final int totalPage;
  late final int currentPage;
  late final Null nextPage;
  late final Null previousPage;

  Pagination.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPerpage = json['total_perpage'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    nextPage = null;
    previousPage = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_records'] = totalRecords;
    _data['total_perpage'] = totalPerpage;
    _data['total_page'] = totalPage;
    _data['current_page'] = currentPage;
    _data['next_page'] = nextPage;
    _data['previous_page'] = previousPage;
    return _data;
  }
}
