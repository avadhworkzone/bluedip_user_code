class VerifyOtpResModel {
  bool? status;
  String? message;
  String? otpCode;
  bool? isRegister;
  String? token;

  VerifyOtpResModel(
      {this.status, this.message, this.otpCode, this.isRegister, this.token});

  VerifyOtpResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otpCode = json['otp_code'];
    isRegister = json['is_register'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp_code'] = this.otpCode;
    data['is_register'] = this.isRegister;
    data['token'] = this.token;
    return data;
  }
}
