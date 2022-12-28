class SendMailModel {
  int success = 0;
  List data = [];
  String message = '';

  SendMailModel({required this.success, required this.data, required this.message});

  SendMailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'].cast();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
