class DeleteMusicModel {
  int success = 0;
  List<String>? data;
  String message = "";

  DeleteMusicModel({required this.success, this.data, required this.message});

  DeleteMusicModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['data'] = this.data;
    data['message'] = message;
    return data;
  }
}
