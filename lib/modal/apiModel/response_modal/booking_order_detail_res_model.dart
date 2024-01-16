class GetBookingOrderDetailResModel {
  bool? status;
  String? message;
  Data? data;

  GetBookingOrderDetailResModel({this.status, this.message, this.data});

  GetBookingOrderDetailResModel.fromJson(Map<String, dynamic> json) {
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
  int? bookingId;
  int? randomBookingId;
  String? orderType;
  String? time;
  int? noOfGuest;
  String? userFullName;
  String? mobileNumber;
  String? specialRequest;
  String? dateCreated;
  String? offerPercentage;
  int? minAmount;
  RestaurantData? restaurantData;

  Data(
      {this.bookingId,
      this.randomBookingId,
      this.orderType,
      this.time,
      this.noOfGuest,
      this.userFullName,
      this.mobileNumber,
      this.specialRequest,
      this.dateCreated,
      this.offerPercentage,
      this.minAmount,
      this.restaurantData});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    randomBookingId = json['random_booking_id'];
    orderType = json['order_type'];
    time = json['time'];
    noOfGuest = json['no_of_guest'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    specialRequest = json['special_request'];
    dateCreated = json['date_created'];
    offerPercentage = json['offer_percentage'];
    minAmount = json['min_amount'];
    restaurantData = json['restaurant_data'] != null
        ? new RestaurantData.fromJson(json['restaurant_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['random_booking_id'] = this.randomBookingId;
    data['order_type'] = this.orderType;
    data['time'] = this.time;
    data['no_of_guest'] = this.noOfGuest;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['special_request'] = this.specialRequest;
    data['date_created'] = this.dateCreated;
    data['offer_percentage'] = this.offerPercentage;
    data['min_amount'] = this.minAmount;
    if (this.restaurantData != null) {
      data['restaurant_data'] = this.restaurantData!.toJson();
    }
    return data;
  }
}

class RestaurantData {
  List<Hours>? hours;
  String? emailId;
  String? dateCreated;
  String? restaurantId;
  Null? restaurantImg;
  String? restaurantName;
  int? restaurantMobileNumber;

  RestaurantData(
      {this.hours,
      this.emailId,
      this.dateCreated,
      this.restaurantId,
      this.restaurantImg,
      this.restaurantName,
      this.restaurantMobileNumber});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(new Hours.fromJson(v));
      });
    }
    emailId = json['email_id'];
    dateCreated = json['date_created'];
    restaurantId = json['restaurant_id'];
    restaurantImg = json['restaurant_img'];
    restaurantName = json['restaurant_name'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    data['email_id'] = this.emailId;
    data['date_created'] = this.dateCreated;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_img'] = this.restaurantImg;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    return data;
  }
}

class Hours {
  Friday? friday;
  Friday? monday;
  Friday? sunday;
  Friday? tuesday;
  Friday? saturday;
  Friday? thursday;
  Friday? wednesday;

  Hours(
      {this.friday,
      this.monday,
      this.sunday,
      this.tuesday,
      this.saturday,
      this.thursday,
      this.wednesday});

  Hours.fromJson(Map<String, dynamic> json) {
    friday =
        json['friday'] != null ? new Friday.fromJson(json['friday']) : null;
    monday =
        json['monday'] != null ? new Friday.fromJson(json['monday']) : null;
    sunday =
        json['sunday'] != null ? new Friday.fromJson(json['sunday']) : null;
    tuesday =
        json['tuesday'] != null ? new Friday.fromJson(json['tuesday']) : null;
    saturday =
        json['saturday'] != null ? new Friday.fromJson(json['saturday']) : null;
    thursday =
        json['thursday'] != null ? new Friday.fromJson(json['thursday']) : null;
    wednesday = json['wednesday'] != null
        ? new Friday.fromJson(json['wednesday'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    return data;
  }
}

class Friday {
  String? to;
  String? from;

  Friday({this.to, this.from});

  Friday.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    from = json['from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    data['from'] = this.from;
    return data;
  }
}
