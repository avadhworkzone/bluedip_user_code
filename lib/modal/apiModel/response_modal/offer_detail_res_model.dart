class OfferDetailsResModel {
  bool? status;
  String? message;
  Data? data;

  OfferDetailsResModel({this.status, this.message, this.data});

  OfferDetailsResModel.fromJson(Map<String, dynamic> json) {
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
  int? offerId;
  int? randomOfferId;
  String? restaurantId;
  String? offerPercentage;
  String? timeType;
  TimePeriod? timePeriod;
  int? deals;
  String? offerType;
  List<String>? day;
  int? minAmount;
  String? dateCreated;
  List<RestaurantData>? restaurantData;

  Data(
      {this.offerId,
      this.randomOfferId,
      this.restaurantId,
      this.offerPercentage,
      this.timeType,
      this.timePeriod,
      this.deals,
      this.offerType,
      this.day,
      this.minAmount,
      this.dateCreated,
      this.restaurantData});

  Data.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    randomOfferId = json['random_offer_id'];
    restaurantId = json['restaurant_id'];
    offerPercentage = json['offer_percentage'];
    timeType = json['time_type'];
    timePeriod = json['time_period'] != null
        ? new TimePeriod.fromJson(json['time_period'])
        : null;
    deals = json['deals'];
    offerType = json['offer_type'];
    day = json['day'].cast<String>();
    minAmount = json['min_amount'];
    dateCreated = json['date_created'];
    if (json['restaurant_data'] != null) {
      restaurantData = <RestaurantData>[];
      json['restaurant_data'].forEach((v) {
        restaurantData!.add(new RestaurantData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['random_offer_id'] = this.randomOfferId;
    data['restaurant_id'] = this.restaurantId;
    data['offer_percentage'] = this.offerPercentage;
    data['time_type'] = this.timeType;
    if (this.timePeriod != null) {
      data['time_period'] = this.timePeriod!.toJson();
    }
    data['deals'] = this.deals;
    data['offer_type'] = this.offerType;
    data['day'] = this.day;
    data['min_amount'] = this.minAmount;
    data['date_created'] = this.dateCreated;
    if (this.restaurantData != null) {
      data['restaurant_data'] =
          this.restaurantData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimePeriod {
  String? start;
  String? end;

  TimePeriod({this.start, this.end});

  TimePeriod.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}

class RestaurantData {
  String? dateCreated;
  String? restaurantId;
  String? restaurantName;
  int? restaurantMobileNumber;

  RestaurantData(
      {this.dateCreated,
      this.restaurantId,
      this.restaurantName,
      this.restaurantMobileNumber});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    dateCreated = json['date_created'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    return data;
  }
}
