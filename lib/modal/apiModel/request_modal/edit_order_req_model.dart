class EditOrderReqModel {
  String? action;
  String? orderId;
  String? userFullName;
  String? mobileNumber;
  String? noOfGuest;
  String? specialRequest;
  String? time;

  EditOrderReqModel(
      {this.action,
      this.orderId,
      this.userFullName,
      this.mobileNumber,
      this.noOfGuest,
      this.specialRequest,
      this.time});

  EditOrderReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    orderId = json['order_id'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    noOfGuest = json['no_of_guest'];
    specialRequest = json['special_request'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['order_id'] = this.orderId;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['no_of_guest'] = this.noOfGuest;
    data['special_request'] = this.specialRequest;
    data['time'] = this.time;
    return data;
  }
}
