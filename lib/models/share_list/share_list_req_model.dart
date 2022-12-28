class ShareListReqModel {
  String? thumbnail;
  String? listName;

  ShareListReqModel({this.thumbnail, this.listName});

  ShareListReqModel.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    listName = json['listName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['listName'] = this.listName;
    return data;
  }
}
