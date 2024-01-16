class AddPostReqModel {
  String? action;
  String? postImg;
  String? postId;
  String? postTitle;
  String? description;
  String? date;
  String? preferredGender;
  String? preferredFood;
  Location? location;

  AddPostReqModel(
      {this.action,
      this.postImg,
      this.postId,
      this.postTitle,
      this.description,
      this.date,
      this.preferredGender,
      this.preferredFood,
      this.location});

  AddPostReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    postImg = json['post_img'];
    postId = json['post_id'];
    postTitle = json['post_title'];
    description = json['description'];
    date = json['date'];
    preferredGender = json['preferred_gender'];
    preferredFood = json['preferred_food'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['post_img'] = this.postImg;
    data['post_id'] = this.postId;
    data['post_title'] = this.postTitle;
    data['description'] = this.description;
    data['date'] = this.date;
    data['preferred_gender'] = this.preferredGender;
    data['preferred_food'] = this.preferredFood;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
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
