class ViewPostDetailResModel {
  bool? status;
  String? message;
  Data? data;

  ViewPostDetailResModel({this.status, this.message, this.data});

  ViewPostDetailResModel.fromJson(Map<String, dynamic> json) {
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
  int? postId;
  String? userId;
  String? postImg;
  String? postTitle;
  String? description;
  String? date;
  String? preferredGender;
  String? preferredFood;
  String? dateCreated;
  Location? location;
  String? userImg;
  String? fullName;
  bool? isChat;

  Data(
      {this.postId,
      this.userId,
      this.postImg,
      this.postTitle,
      this.description,
      this.date,
      this.preferredGender,
      this.preferredFood,
      this.dateCreated,
      this.location,
      this.userImg,
      this.fullName,
      this.isChat});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    postImg = json['post_img'];
    postTitle = json['post_title'];
    description = json['description'];
    date = json['date'];
    preferredGender = json['preferred_gender'];
    preferredFood = json['preferred_food'];
    dateCreated = json['date_created'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    userImg = json['user_img'];
    fullName = json['full_name'];
    isChat = json['is_chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['post_img'] = this.postImg;
    data['post_title'] = this.postTitle;
    data['description'] = this.description;
    data['date'] = this.date;
    data['preferred_gender'] = this.preferredGender;
    data['preferred_food'] = this.preferredFood;
    data['date_created'] = this.dateCreated;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['user_img'] = this.userImg;
    data['full_name'] = this.fullName;
    data['is_chat'] = this.isChat;
    return data;
  }
}

class Location {
  String? country;
  String? countryCode;
  String? cityName;
  String? state;
  String? address;
  String? pincode;
  String? lang;
  String? lat;

  Location(
      {this.country,
      this.countryCode,
      this.cityName,
      this.state,
      this.address,
      this.pincode,
      this.lang,
      this.lat});

  Location.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCode = json['country_code'];
    cityName = json['city_name'];
    state = json['state'];
    address = json['address'];
    pincode = json['pincode'];
    lang = json['lang'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city_name'] = this.cityName;
    data['state'] = this.state;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['lang'] = this.lang;
    data['lat'] = this.lat;
    return data;
  }
}
