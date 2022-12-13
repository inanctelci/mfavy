class ListMusicModel {
  ListMusicModel({
    required this.success,
    required this.datas,
    required this.message,
  });
  late final int success;
  late final List<Datas> datas;
  late final String message;

  ListMusicModel.fromJson(Map<String, dynamic> json) {
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
    required this.result,
  });
  late final Result result;

  Datas.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.data,
    required this.pagination,
  });
  late final List<Data> data;
  late final Pagination pagination;

  Result.fromJson(Map<String, dynamic> json) {
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
    required this.totalRate,
    required this.songName,
    required this.yMusicID,
    required this.thumbnail,
    required this.viewCount,
    required this.myrate,
  });
  late final int id;
  late final String totalRate;
  late final String songName;
  late final String yMusicID;
  late final String thumbnail;
  late final int viewCount;
  late final int myrate;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalRate = json['total_rate'];
    songName = json['songName'];
    yMusicID = json['yMusicID'];
    thumbnail = json['thumbnail'];
    viewCount = json['viewCount'];
    myrate = json['myrate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['total_rate'] = totalRate;
    _data['songName'] = songName;
    _data['yMusicID'] = yMusicID;
    _data['thumbnail'] = thumbnail;
    _data['viewCount'] = viewCount;
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
