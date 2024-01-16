class DineInOrderHistoryResModel {
  bool? status;
  String? message;
  Data? data;

  DineInOrderHistoryResModel({this.status, this.message, this.data});

  DineInOrderHistoryResModel.fromJson(Map<String, dynamic> json) {
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
  List<ActiveBooking>? activeBooking;
  List<PreviousBooking>? previousBooking;

  Data({this.activeBooking, this.previousBooking});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['activeBooking'] != null) {
      activeBooking = <ActiveBooking>[];
      json['activeBooking'].forEach((v) {
        activeBooking!.add(new ActiveBooking.fromJson(v));
      });
    }
    if (json['previousBooking'] != null) {
      previousBooking = <PreviousBooking>[];
      json['previousBooking'].forEach((v) {
        previousBooking!.add(new PreviousBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeBooking != null) {
      data['activeBooking'] =
          this.activeBooking!.map((v) => v.toJson()).toList();
    }
    if (this.previousBooking != null) {
      data['previousBooking'] =
          this.previousBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveBooking {
  int? orderId;
  int? randomOrderId;
  String? userId;
  String? orderStatus;
  String? dateCreated;
  OfferData? offerData;
  RestaurantData? restaurantData;
  RestaurantLocationData? restaurantLocationData;

  ActiveBooking(
      {this.orderId,
      this.randomOrderId,
      this.userId,
      this.orderStatus,
      this.dateCreated,
      this.offerData,
      this.restaurantData,
      this.restaurantLocationData});

  ActiveBooking.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    userId = json['user_id'];
    orderStatus = json['order_status'];
    dateCreated = json['date_created'];
    offerData = json['offer_data'] != null
        ? new OfferData.fromJson(json['offer_data'])
        : null;
    restaurantData = json['restaurant_data'] != null
        ? new RestaurantData.fromJson(json['restaurant_data'])
        : null;
    restaurantLocationData = json['restaurant_location_data'] != null
        ? new RestaurantLocationData.fromJson(json['restaurant_location_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['user_id'] = this.userId;
    data['order_status'] = this.orderStatus;
    data['date_created'] = this.dateCreated;
    if (this.offerData != null) {
      data['offer_data'] = this.offerData!.toJson();
    }
    if (this.restaurantData != null) {
      data['restaurant_data'] = this.restaurantData!.toJson();
    }
    if (this.restaurantLocationData != null) {
      data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
    }
    return data;
  }
}

class OfferData {
  int? offerId;
  String? timeType;
  OfferValid? offerValid;
  int? randomOfferId;
  String? offerPercentage;

  OfferData(
      {this.offerId,
      this.timeType,
      this.offerValid,
      this.randomOfferId,
      this.offerPercentage});

  OfferData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    timeType = json['time_type'];
    offerValid = json['offer_valid'] != null
        ? new OfferValid.fromJson(json['offer_valid'])
        : null;
    randomOfferId = json['random_offer_id'];
    offerPercentage = json['offer_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['time_type'] = this.timeType;
    if (this.offerValid != null) {
      data['offer_valid'] = this.offerValid!.toJson();
    }
    data['random_offer_id'] = this.randomOfferId;
    data['offer_percentage'] = this.offerPercentage;
    return data;
  }
}

class OfferValid {
  String? end;
  String? start;

  OfferValid({this.end, this.start});

  OfferValid.fromJson(Map<String, dynamic> json) {
    end = json['end'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end'] = this.end;
    data['start'] = this.start;
    return data;
  }
}

class RestaurantData {
  String? restaurantId;
  var restaurantImg;
  String? restaurantName;
  int? restaurantMobileNumber;

  RestaurantData(
      {this.restaurantId,
      this.restaurantImg,
      this.restaurantName,
      this.restaurantMobileNumber});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantImg = json['restaurant_img'];
    restaurantName = json['restaurant_name'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_img'] = this.restaurantImg;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    return data;
  }
}

class RestaurantLocationData {
  double? lat;
  Geom? geom;
  double? lang;
  String? state;
  String? address;
  String? country;
  String? pincode;
  String? cityName;
  String? countryCode;
  int? restoLocationId;

  RestaurantLocationData(
      {this.lat,
      this.geom,
      this.lang,
      this.state,
      this.address,
      this.country,
      this.pincode,
      this.cityName,
      this.countryCode,
      this.restoLocationId});

  RestaurantLocationData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    geom = json['geom'] != null ? new Geom.fromJson(json['geom']) : null;
    lang = json['lang'];
    state = json['state'];
    address = json['address'];
    country = json['country'];
    pincode = json['pincode'];
    cityName = json['city_name'];
    countryCode = json['country_code'];
    restoLocationId = json['resto_location_id'];
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
    data['city_name'] = this.cityName;
    data['country_code'] = this.countryCode;
    data['resto_location_id'] = this.restoLocationId;
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

class PreviousBooking {
  int? orderId;
  int? randomOrderId;
  String? userId;
  String? restaurantId;
  String? orderStatus;
  String? dateCreated;
  double? rating;
  OfferData? offerData;
  RestaurantData? restaurantData;
  RestaurantLocationData? restaurantLocationData;

  PreviousBooking(
      {this.orderId,
      this.randomOrderId,
      this.userId,
      this.restaurantId,
      this.orderStatus,
      this.dateCreated,
      this.rating,
      this.offerData,
      this.restaurantData,
      this.restaurantLocationData});

  PreviousBooking.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    orderStatus = json['order_status'];
    dateCreated = json['date_created'];
    rating = json['rating'];
    offerData = json['offer_data'] != null
        ? new OfferData.fromJson(json['offer_data'])
        : null;
    restaurantData = json['restaurant_data'] != null
        ? new RestaurantData.fromJson(json['restaurant_data'])
        : null;
    restaurantLocationData = json['restaurant_location_data'] != null
        ? new RestaurantLocationData.fromJson(json['restaurant_location_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['order_status'] = this.orderStatus;
    data['date_created'] = this.dateCreated;
    data['rating'] = this.rating;
    if (this.offerData != null) {
      data['offer_data'] = this.offerData!.toJson();
    }
    if (this.restaurantData != null) {
      data['restaurant_data'] = this.restaurantData!.toJson();
    }
    if (this.restaurantLocationData != null) {
      data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
    }
    return data;
  }
}
