class EditMobileVerifyOtpResModel {
  bool? status;
  String? message;
  String? otpCode;

  EditMobileVerifyOtpResModel({this.status, this.message, this.otpCode});

  EditMobileVerifyOtpResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otpCode = json['otp_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp_code'] = this.otpCode;
    return data;
  }
}
