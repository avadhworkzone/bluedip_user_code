class AddPaymentResModel {
  bool? status;
  String? message;
  Data? data;

  AddPaymentResModel({this.status, this.message, this.data});

  AddPaymentResModel.fromJson(Map<String, dynamic> json) {
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
  int? paymentId;
  int? orderId;
  String? rzpOrderId;
  String? rzpKey;

  Data({this.paymentId, this.orderId, this.rzpOrderId, this.rzpKey});

  Data.fromJson(Map<String, dynamic> json) {
    paymentId = json['payment_id'];
    orderId = json['order_id'];
    rzpOrderId = json['rzp_order_id'];
    rzpKey = json['rzp_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_id'] = this.paymentId;
    data['order_id'] = this.orderId;
    data['rzp_order_id'] = this.rzpOrderId;
    data['rzp_key'] = this.rzpKey;
    return data;
  }
}
