class VideoResulstModel {
  VideoResulstModel({
    required this.kind,
    required this.id,
    required this.channelTitle,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.channelId,
    required this.thumbnails,
    required this.channelurl,
    required this.url,
  });
  late final String? kind;
  late final String? id;
  late final String channelTitle;
  late final String title;
  late final String? description;
  late final String? publishedAt;
  late final String? channelId;
  late final String? thumbnails;
  late final String? channelurl;
  late final String url;

  VideoResulstModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    id = json['id'];
    channelTitle = json['channelTitle'];
    title = json['title'];
    description = json['description'];
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    thumbnails = json['thumbnails'];
    channelurl = json['channelurl'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['kind'] = kind;
    data['id'] = id;
    data['channelTitle'] = channelTitle;
    data['title'] = title;
    data['description'] = description;
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['thumbnails'] = thumbnails;
    data['channelurl'] = channelurl;
    data['url'] = url;
    return data;
  }
}
