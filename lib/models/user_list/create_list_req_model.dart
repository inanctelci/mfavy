class CreateListReqModel {
  CreateListReqModel({
    required this.listName,
    required this.thumbnail,
  });
  late final String listName;
  late final String thumbnail;

  CreateListReqModel.fromJson(Map<String, dynamic> json) {
    listName = json['listName'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['listName'] = listName;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}
