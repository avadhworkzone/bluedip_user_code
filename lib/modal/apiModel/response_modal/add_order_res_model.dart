class AddOrderResModel {
  bool? status;
  String? message;
  int? otp;
  int? orderId;

  AddOrderResModel({this.status, this.message, this.otp, this.orderId});

  AddOrderResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['otp'] = this.otp;
    data['order_id'] = this.orderId;
    return data;
  }
}
