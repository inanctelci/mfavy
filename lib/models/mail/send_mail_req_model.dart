class SendMailReqModel {
  String category = '';
  String mailBody = '';
  String eMail = '';
  String userName = '';

  SendMailReqModel({required this.category, required this.mailBody, required this.eMail, required this.userName});

  SendMailReqModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    mailBody = json['mailBody'];
    eMail = json['eMail'];
    userName = json['UserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = category;
    data['mailBody'] = mailBody;
    data['eMail'] = eMail;
    data['UserName'] = userName;
    return data;
  }
}
