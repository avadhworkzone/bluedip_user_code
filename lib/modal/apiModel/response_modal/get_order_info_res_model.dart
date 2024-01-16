class GetOrderInfoResModel {
  bool? status;
  String? message;
  Data? data;

  GetOrderInfoResModel({this.status, this.message, this.data});

  GetOrderInfoResModel.fromJson(Map<String, dynamic> json) {
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
  var orderId;
  var randomOrderId;
  var userId;
  var restaurantId;
  var orderType;
  var offerId;
  var userFullName;
  var mobileNumber;
  var time;
  var specialRequest;
  var noOfGuest;
  var dateCreated;

  Data(
      {this.orderId,
      this.randomOrderId,
      this.userId,
      this.restaurantId,
      this.orderType,
      this.offerId,
      this.userFullName,
      this.mobileNumber,
      this.time,
      this.specialRequest,
      this.noOfGuest,
      this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    orderType = json['order_type'];
    offerId = json['offer_id'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    time = json['time'];
    specialRequest = json['special_request'];
    noOfGuest = json['no_of_guest'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['order_type'] = this.orderType;
    data['offer_id'] = this.offerId;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['time'] = this.time;
    data['special_request'] = this.specialRequest;
    data['no_of_guest'] = this.noOfGuest;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
