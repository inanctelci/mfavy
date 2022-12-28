class YtSearchReqModel {
  YtSearchReqModel({
    required this.id,
    required this.title,
    required this.thumbnails,
  });
  late final String id;
  late final String title;
  late final String thumbnails;

  YtSearchReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnails = json['thumbnails'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['thumbnails'] = thumbnails;
    return _data;
  }
}
