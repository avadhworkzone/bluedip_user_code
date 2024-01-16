class AddOrderReqModel {
  String? action;
  String? restaurantId;
  String? offerId;
  String? orderType;
  String? userFullName;
  String? mobileNumber;
  String? time;
  String? specialRequest;
  String? noOfGuest;
  String? orderId;

  AddOrderReqModel(
      {this.action,
      this.restaurantId,
      this.offerId,
      this.orderType,
      this.userFullName,
      this.mobileNumber,
      this.time,
      this.specialRequest,
      this.noOfGuest,
      this.orderId});

  AddOrderReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    restaurantId = json['restaurant_id'];
    offerId = json['offer_id'];
    orderType = json['order_type'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    time = json['time'];
    specialRequest = json['special_request'];
    noOfGuest = json['no_of_guest'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['restaurant_id'] = this.restaurantId;
    data['offer_id'] = this.offerId;
    data['order_type'] = this.orderType;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['time'] = this.time;
    data['special_request'] = this.specialRequest;
    data['no_of_guest'] = this.noOfGuest;
    data['order_id'] = this.orderId;
    return data;
  }
}
