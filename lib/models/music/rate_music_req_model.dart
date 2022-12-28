class RateMusicReqModel {
  String? yMusicID;
  int? rate;

  RateMusicReqModel({this.yMusicID, this.rate});

  RateMusicReqModel.fromJson(Map<String, dynamic> json) {
    yMusicID = json['yMusicID'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yMusicID'] = this.yMusicID;
    data['rate'] = this.rate;
    return data;
  }
}
