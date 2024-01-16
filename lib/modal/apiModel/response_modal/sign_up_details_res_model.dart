class GetSignUpDetailsResModel {
  bool? status;
  String? message;
  Data? data;

  GetSignUpDetailsResModel({this.status, this.message, this.data});

  GetSignUpDetailsResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? fullName;
  String? emailId;
  String? dateModified;

  Data({this.fullName, this.emailId, this.dateModified});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    emailId = json['email_id'];
    dateModified = json['date_modified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email_id'] = this.emailId;
    data['date_modified'] = this.dateModified;
    return data;
  }
}
