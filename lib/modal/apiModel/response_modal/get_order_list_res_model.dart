class GetOrderListResModel {
  bool? status;
  String? message;
  Data? data;

  GetOrderListResModel({this.status, this.message, this.data});

  GetOrderListResModel.fromJson(Map<String, dynamic> json) {
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
  var orderStatus;
  var time;
  var userFullName;
  var mobileNumber;
  var dateCreated;
  RestaurantData? restaurantData;

  Data(
      {this.orderId,
      this.randomOrderId,
      this.userId,
      this.restaurantId,
      this.orderType,
      this.orderStatus,
      this.time,
      this.userFullName,
      this.mobileNumber,
      this.dateCreated,
      this.restaurantData});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    time = json['time'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    dateCreated = json['date_created'];
    restaurantData = json['restaurant_data'] != null
        ? new RestaurantData.fromJson(json['restaurant_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['order_type'] = this.orderType;
    data['order_status'] = this.orderStatus;
    data['time'] = this.time;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['date_created'] = this.dateCreated;
    if (this.restaurantData != null) {
      data['restaurant_data'] = this.restaurantData!.toJson();
    }
    return data;
  }
}

class RestaurantData {
  var emailId;
  var dateCreated;
  var restaurantId;
  var restaurantImg;
  var restaurantName;
  var restaurantMobileNumber;

  RestaurantData(
      {this.emailId,
      this.dateCreated,
      this.restaurantId,
      this.restaurantImg,
      this.restaurantName,
      this.restaurantMobileNumber});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    emailId = json['email_id'];
    dateCreated = json['date_created'];
    restaurantId = json['restaurant_id'];
    restaurantImg = json['restaurant_img'];
    restaurantName = json['restaurant_name'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_id'] = this.emailId;
    data['date_created'] = this.dateCreated;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_img'] = this.restaurantImg;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    return data;
  }
}
