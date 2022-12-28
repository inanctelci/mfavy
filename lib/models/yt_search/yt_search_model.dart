class YtSearchModel {
  YtSearchModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final int success;
  late final List<Data> data;
  late final String message;

  YtSearchModel.fromJson(Map<String, dynamic> json) {
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
    required this.arr,
  });
  late final List<Arr> arr;

  Data.fromJson(Map<String, dynamic> json) {
    arr = List.from(json['arr']).map((e) => Arr.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['arr'] = arr.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Arr {
  Arr({
    required this.id,
    required this.title,
    required this.thumbnails,
    required this.myrate,
    required this.totalRate,
    required this.viewCount,
  });
  late final String id;
  late final String title;
  late final String thumbnails;
  late final int myrate;
  late final int totalRate;
  late final int viewCount;

  Arr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnails = json['thumbnails'];
    myrate = json['myrate'];
    totalRate = json['total_rate'];
    viewCount = json['viewCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['thumbnails'] = thumbnails;
    _data['myrate'] = myrate;
    _data['total_rate'] = totalRate;
    _data['viewCount'] = viewCount;
    return _data;
  }
}
