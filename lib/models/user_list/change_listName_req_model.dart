class ChangeListNameReqModel {
  ChangeListNameReqModel({
    required this.id,
    required this.listName,
    required this.thumbnail,
  });
  late final int id;
  late final String listName;
  late final String thumbnail;

  ChangeListNameReqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    listName = json['listName'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['listName'] = listName;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}
