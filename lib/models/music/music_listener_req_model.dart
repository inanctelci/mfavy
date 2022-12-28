class MusicListenerReqModel {
  MusicListenerReqModel({
    required this.listID,
    required this.id,
    required this.title,
    required this.thumbnails,
  });
  late final int listID;
  late final String id;
  late final String title;
  late final String thumbnails;

  MusicListenerReqModel.fromJson(Map<String, dynamic> json) {
    listID = json['listID'];
    id = json['id'];
    title = json['title'];
    thumbnails = json['thumbnails'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['listID'] = listID;
    _data['id'] = id;
    _data['title'] = title;
    _data['thumbnails'] = thumbnails;
    return _data;
  }
}
