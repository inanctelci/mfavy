class AddMusicToListReqModel {
  AddMusicToListReqModel({
    required this.listID,
    required this.yMusicID,
  });
  late final int listID;
  late final String yMusicID;

  AddMusicToListReqModel.fromJson(Map<String, dynamic> json) {
    listID = json['listID'];
    yMusicID = json['yMusicID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['listID'] = this.listID;
    _data['yMusicID'] = this.yMusicID;
    return _data;
  }
}
