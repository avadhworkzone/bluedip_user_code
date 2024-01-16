class GetUserDetailResModel {
  bool? status;
  String? message;
  Data? data;

  GetUserDetailResModel({this.status, this.message, this.data});

  GetUserDetailResModel.fromJson(Map<String, dynamic> json) {
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
  var userId;
  var userImg;
  var fullName;
  var emailId;
  var mobileNumber;
  var dateCreated;
  RestaurantLocationData? restaurantLocationData;

  Data(
      {this.userId,
      this.userImg,
      this.fullName,
      this.emailId,
      this.mobileNumber,
      this.dateCreated,
      this.restaurantLocationData});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userImg = json['user_img'];
    fullName = json['full_name'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
    dateCreated = json['date_created'];
    restaurantLocationData = json['restaurant_location_data'] != null
        ? new RestaurantLocationData.fromJson(json['restaurant_location_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_img'] = this.userImg;
    data['full_name'] = this.fullName;
    data['email_id'] = this.emailId;
    data['mobile_number'] = this.mobileNumber;
    data['date_created'] = this.dateCreated;
    if (this.restaurantLocationData != null) {
      data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
    }
    return data;
  }
}

class RestaurantLocationData {
  String? lat;
  Geom? geom;
  String? lang;
  String? state;
  String? address;
  String? country;
  String? pincode;
  String? userId;
  String? cityName;
  String? countryCode;
  int? userLocationId;

  RestaurantLocationData(
      {this.lat,
      this.geom,
      this.lang,
      this.state,
      this.address,
      this.country,
      this.pincode,
      this.userId,
      this.cityName,
      this.countryCode,
      this.userLocationId});

  RestaurantLocationData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    geom = json['geom'] != null ? new Geom.fromJson(json['geom']) : null;
    lang = json['lang'];
    state = json['state'];
    address = json['address'];
    country = json['country'];
    pincode = json['pincode'];
    userId = json['user_id'];
    cityName = json['city_name'];
    countryCode = json['country_code'];
    userLocationId = json['user_location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    if (this.geom != null) {
      data['geom'] = this.geom!.toJson();
    }
    data['lang'] = this.lang;
    data['state'] = this.state;
    data['address'] = this.address;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['user_id'] = this.userId;
    data['city_name'] = this.cityName;
    data['country_code'] = this.countryCode;
    data['user_location_id'] = this.userLocationId;
    return data;
  }
}

class Geom {
  String? type;
  List<double>? coordinates;

  Geom({this.type, this.coordinates});

  Geom.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
