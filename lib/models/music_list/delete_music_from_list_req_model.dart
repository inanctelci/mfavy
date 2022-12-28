class DeleteMusicReqModel {
  int listID = 0;
  String yMusicID = '';

  DeleteMusicReqModel({required this.listID, required this.yMusicID});

  DeleteMusicReqModel.fromJson(Map<String, dynamic> json) {
    listID = json['listID'];
    yMusicID = json['yMusicID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['listID'] = listID;
    data['yMusicID'] = yMusicID;
    return data;
  }
}
