class UserLoginModel {
  UserLoginModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final int success;
  late final List<Data> data;
  late final String message;

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.tokens,
  });
  late final Tokens tokens;

  Data.fromJson(Map<String, dynamic> json) {
    tokens = Tokens.fromJson(json['tokens']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tokens'] = tokens.toJson();
    return _data;
  }
}

class Tokens {
  Tokens({
    required this.accessToken,
  });
  late final String accessToken;

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = accessToken;
    return _data;
  }
}
