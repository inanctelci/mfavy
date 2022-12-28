class UserListsModel {
  int success = 0;
  List<Data> data = [];
  String message = '';

  UserListsModel({required this.success, required this.data, required this.message});

  UserListsModel.fromJson(Map<String, dynamic> json) {
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
  List<Datas>? datas;
  Pagination? pagination;

  Data({this.datas, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
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
  String? listName;
  String? lastListened;
  String? thumbnail;
  String? createdAt;

  Datas({this.id, this.listName, this.lastListened, this.thumbnail, this.createdAt});

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['listName'];
    lastListened = json['lastListened'];
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['listName'] = this.listName;
    data['lastListened'] = this.lastListened;
    data['thumbnail'] = this.thumbnail;
    data['createdAt'] = this.createdAt;
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
