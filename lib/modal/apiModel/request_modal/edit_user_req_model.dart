class EditUserReqModel {
  String? action;
  String? fullName;
  String? emailId;
  String? userImg;

  EditUserReqModel({this.action, this.fullName, this.emailId, this.userImg});

  EditUserReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    fullName = json['full_name'];
    emailId = json['email_id'];
    userImg = json['user_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['full_name'] = this.fullName;
    data['email_id'] = this.emailId;
    data['user_img'] = this.userImg;
    return data;
  }
}
