import 'package:flutterframework/export.dart';

class UserModel extends IBaseModel {
  UserModel({
    this.message,
  });

  String? message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json['message'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'message': message,
      };

  @override
  fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }
}
