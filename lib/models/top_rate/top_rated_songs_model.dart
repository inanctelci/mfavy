class TopRatedSongsModel {
  int success = 0;
  List<Data> data = [];
  String message = '';

  TopRatedSongsModel({required this.success, required this.data, required this.message});

  TopRatedSongsModel.fromJson(Map<String, dynamic> json) {
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
  Result? result;

  Data({this.result});

  Data.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Datas>? datas;
  Pagination? pagination;

  Result({this.datas, this.pagination});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['datas'] != null) {
      datas = <Datas>[];
      json['datas'].forEach((v) {
        datas!.add(new Datas.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? new Pagination.fromJson(json['pagination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datas != null) {
      data['datas'] = this.datas!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Datas {
  int? id;
  String? totalRate;
  String? songName;
  String? yMusicID;
  String? thumbnail;
  int? viewCount;
  int? myrate;

  Datas({this.id, this.totalRate, this.songName, this.yMusicID, this.thumbnail, this.viewCount, this.myrate});

  Datas.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? totalRecords;
  int? totalPerpage;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  int? previousPage;

  Pagination({this.totalRecords, this.totalPerpage, this.totalPage, this.currentPage, this.nextPage, this.previousPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalRecords = json['total_records'];
    totalPerpage = json['total_perpage'];
    totalPage = json['total_page'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_records'] = this.totalRecords;
    data['total_perpage'] = this.totalPerpage;
    data['total_page'] = this.totalPage;
    data['current_page'] = this.currentPage;
    data['next_page'] = this.nextPage;
    data['previous_page'] = this.previousPage;
    return data;
  }
}
