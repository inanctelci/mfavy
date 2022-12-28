class UserRegisterReqModel {
  UserRegisterReqModel({
    required this.device,
  });
  late final String device;

  UserRegisterReqModel.fromJson(Map<String, dynamic> json) {
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['device'] = device;
    return _data;
  }
}
