class GetUserLocationResModel {
  bool? status;
  Data? data;

  GetUserLocationResModel({this.status, this.data});

  GetUserLocationResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  var userLocationId;
  var userId;
  var geom;
  var country;
  var countryCode;
  var cityName;
  var state;
  var address;
  var pincode;
  var lang;
  var lat;
  var dateCreated;
  var dateModified;
  var status;
  var isDeleted;

  Data(
      {this.userLocationId,
      this.userId,
      this.geom,
      this.country,
      this.countryCode,
      this.cityName,
      this.state,
      this.address,
      this.pincode,
      this.lang,
      this.lat,
      this.dateCreated,
      this.dateModified,
      this.status,
      this.isDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    userLocationId = json['user_location_id'];
    userId = json['user_id'];
    geom = json['geom'];
    country = json['country'];
    countryCode = json['country_code'];
    cityName = json['city_name'];
    state = json['state'];
    address = json['address'];
    pincode = json['pincode'];
    lang = json['lang'];
    lat = json['lat'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    status = json['status'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_location_id'] = this.userLocationId;
    data['user_id'] = this.userId;
    data['geom'] = this.geom;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city_name'] = this.cityName;
    data['state'] = this.state;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['lang'] = this.lang;
    data['lat'] = this.lat;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['status'] = this.status;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
