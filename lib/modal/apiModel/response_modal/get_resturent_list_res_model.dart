// class GetRestaurantListResModel {
//   bool? status;
//   List<restoData>? data;
//
//   GetRestaurantListResModel({this.status, this.data});
//
//   GetRestaurantListResModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <restoData>[];
//       json['data'].forEach((v) {
//         data!.add(new restoData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class restoData {
//   String? restaurantId;
//   String? emailId;
//   String? restaurantName;
//   MenuItems? menuItems;
//   MenuItems? seatingCapacity;
//   int? monthlyRevenueGoal;
//   int? priceRange;
//   List<String>? restaurantCategory;
//   List<String>? cuisine;
//   int? averageCost;
//   List<String>? subFacility;
//   String? restaurantImg;
//   List<Hours>? hours;
//   List<String>? restaurantType;
//   int? restaurantMobileNumber;
//   String? dateCreated;
//   String? avg;
//   String? ratingCount;
//   String? distanceKm;
//   RestaurantLocationData? restaurantLocationData;
//   bool? isFavourite;
//   List<OfferData>? offerData;
//
//   restoData(
//       {this.restaurantId,
//       this.emailId,
//       this.restaurantName,
//       this.menuItems,
//       this.seatingCapacity,
//       this.monthlyRevenueGoal,
//       this.priceRange,
//       this.restaurantCategory,
//       this.cuisine,
//       this.averageCost,
//       this.subFacility,
//       this.restaurantImg,
//       this.hours,
//       this.restaurantType,
//       this.restaurantMobileNumber,
//       this.dateCreated,
//       this.avg,
//       this.ratingCount,
//       this.distanceKm,
//       this.restaurantLocationData,
//       this.isFavourite,
//       this.offerData});
//
//   restoData.fromJson(Map<String, dynamic> json) {
//     restaurantId = json['restaurant_id'];
//     emailId = json['email_id'];
//     restaurantName = json['restaurant_name'];
//     menuItems = json['menu_items'] != null
//         ? new MenuItems.fromJson(json['menu_items'])
//         : null;
//     seatingCapacity = json['seating_capacity'] != null
//         ? new MenuItems.fromJson(json['seating_capacity'])
//         : null;
//     monthlyRevenueGoal = json['monthly_revenue_goal'];
//     priceRange = json['price_range'];
//     restaurantCategory = json['restaurant_category'] == null
//         ? []
//         : json['restaurant_category'].cast<String>();
//     cuisine = json['cuisine'] == null ? [] : json['cuisine'].cast<String>();
//     averageCost = json['average_cost'];
//     subFacility =
//         json['sub_facility'] == null ? [] : json['sub_facility'].cast<String>();
//     restaurantImg = json['restaurant_img'];
//     if (json['hours'] != null) {
//       hours = <Hours>[];
//       json['hours'].forEach((v) {
//         hours!.add(new Hours.fromJson(v));
//       });
//     }
//     restaurantType = json['restaurant_type'] == null
//         ? []
//         : json['restaurant_type'].cast<String>();
//     restaurantMobileNumber = json['restaurant_mobile_number'];
//     dateCreated = json['date_created'];
//     avg = json['avg'];
//     ratingCount = json['rating_count'];
//     distanceKm = json['distance_km'];
//     restaurantLocationData = json['restaurant_location_data'] != null
//         ? new RestaurantLocationData.fromJson(json['restaurant_location_data'])
//         : null;
//     isFavourite = json['is_favourite'];
//     if (json['offers_data'] != null) {
//       offerData = <OfferData>[];
//       json['offers_data'].forEach((v) {
//         offerData!.add(new OfferData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['restaurant_id'] = this.restaurantId;
//     data['email_id'] = this.emailId;
//     data['restaurant_name'] = this.restaurantName;
//     if (this.menuItems != null) {
//       data['menu_items'] = this.menuItems!.toJson();
//     }
//     if (this.seatingCapacity != null) {
//       data['seating_capacity'] = this.seatingCapacity!.toJson();
//     }
//     data['monthly_revenue_goal'] = this.monthlyRevenueGoal;
//     data['price_range'] = this.priceRange;
//     data['restaurant_category'] = this.restaurantCategory;
//     data['cuisine'] = this.cuisine;
//     data['average_cost'] = this.averageCost;
//     data['sub_facility'] = this.subFacility;
//     data['restaurant_img'] = this.restaurantImg;
//     if (this.hours != null) {
//       data['hours'] = this.hours!.map((v) => v.toJson()).toList();
//     }
//     data['restaurant_type'] = this.restaurantType;
//     data['restaurant_mobile_number'] = this.restaurantMobileNumber;
//     data['date_created'] = this.dateCreated;
//     data['avg'] = this.avg;
//     data['rating_count'] = this.ratingCount;
//     data['distance_km'] = this.distanceKm;
//     if (this.restaurantLocationData != null) {
//       data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
//     }
//     data['is_favourite'] = this.isFavourite;
//     if (this.offerData != null) {
//       data['offers_data'] = this.offerData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class MenuItems {
//   String? min;
//   String? max;
//
//   MenuItems({this.min, this.max});
//
//   MenuItems.fromJson(Map<String, dynamic> json) {
//     min = json['min'];
//     max = json['max'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['min'] = this.min;
//     data['max'] = this.max;
//     return data;
//   }
// }
//
// class Hours {
//   Monday? monday;
//   Monday? thusday;
//   Monday? wednsday;
//   Monday? thursday;
//   Monday? friday;
//   Monday? saturday;
//   Monday? sunday;
//
//   Hours(
//       {this.monday,
//       this.thusday,
//       this.wednsday,
//       this.thursday,
//       this.friday,
//       this.saturday,
//       this.sunday});
//
//   Hours.fromJson(Map<String, dynamic> json) {
//     monday =
//         json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
//     thusday =
//         json['thusday'] != null ? new Monday.fromJson(json['thusday']) : null;
//     wednsday =
//         json['wednsday'] != null ? new Monday.fromJson(json['wednsday']) : null;
//     thursday =
//         json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
//     friday =
//         json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
//     saturday =
//         json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
//     sunday =
//         json['sunday'] != null ? new Monday.fromJson(json['sunday']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.monday != null) {
//       data['monday'] = this.monday!.toJson();
//     }
//     if (this.thusday != null) {
//       data['thusday'] = this.thusday!.toJson();
//     }
//     if (this.wednsday != null) {
//       data['wednsday'] = this.wednsday!.toJson();
//     }
//     if (this.thursday != null) {
//       data['thursday'] = this.thursday!.toJson();
//     }
//     if (this.friday != null) {
//       data['friday'] = this.friday!.toJson();
//     }
//     if (this.saturday != null) {
//       data['saturday'] = this.saturday!.toJson();
//     }
//     if (this.sunday != null) {
//       data['sunday'] = this.sunday!.toJson();
//     }
//     return data;
//   }
// }
//
// class Monday {
//   String? from;
//   String? to;
//
//   Monday({this.from, this.to});
//
//   Monday.fromJson(Map<String, dynamic> json) {
//     from = json['from'];
//     to = json['to'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['from'] = this.from;
//     data['to'] = this.to;
//     return data;
//   }
// }
//
// class RestaurantLocationData {
//   double? lat;
//   double? lang;
//   String? state;
//   String? address;
//   String? country;
//   String? pincode;
//   String? cityName;
//   String? countryCode;
//   String? dateCreated;
//   int? restoLocationId;
//
//   RestaurantLocationData(
//       {this.lat,
//       this.lang,
//       this.state,
//       this.address,
//       this.country,
//       this.pincode,
//       this.cityName,
//       this.countryCode,
//       this.dateCreated,
//       this.restoLocationId});
//
//   RestaurantLocationData.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lang = json['lang'];
//     state = json['state'];
//     address = json['address'];
//     country = json['country'];
//     pincode = json['pincode'];
//     cityName = json['city_name'];
//     countryCode = json['country_code'];
//     dateCreated = json['date_created'];
//     restoLocationId = json['resto_location_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lang'] = this.lang;
//     data['state'] = this.state;
//     data['address'] = this.address;
//     data['country'] = this.country;
//     data['pincode'] = this.pincode;
//     data['city_name'] = this.cityName;
//     data['country_code'] = this.countryCode;
//     data['date_created'] = this.dateCreated;
//     data['resto_location_id'] = this.restoLocationId;
//     return data;
//   }
// }
//
// class OfferData {
//   List<String>? day;
//   int? offerId;
//   String? dealDate;
//   String? dealType;
//   String? timeType;
//   String? offerType;
//   int? totalDeal;
//   TimePeriod? timePeriod;
//   String? dateCreated;
//   int? randomOfferId;
//   String? offerPercentage;
//
//   OfferData(
//       {this.day,
//       this.offerId,
//       this.dealDate,
//       this.dealType,
//       this.timeType,
//       this.offerType,
//       this.totalDeal,
//       this.timePeriod,
//       this.dateCreated,
//       this.randomOfferId,
//       this.offerPercentage});
//
//   OfferData.fromJson(Map<String, dynamic> json) {
//     day = json['day'].cast<String>();
//     offerId = json['offer_id'];
//     dealDate = json['deal_date'];
//     dealType = json['deal_type'];
//     timeType = json['time_type'];
//     offerType = json['offer_type'];
//     totalDeal = json['total_deal'];
//     timePeriod = json['time_period'] != null
//         ? new TimePeriod.fromJson(json['time_period'])
//         : null;
//     dateCreated = json['date_created'];
//     randomOfferId = json['random_offer_id'];
//     offerPercentage = json['offer_percentage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['day'] = this.day;
//     data['offer_id'] = this.offerId;
//     data['deal_date'] = this.dealDate;
//     data['deal_type'] = this.dealType;
//     data['time_type'] = this.timeType;
//     data['offer_type'] = this.offerType;
//     data['total_deal'] = this.totalDeal;
//     if (this.timePeriod != null) {
//       data['time_period'] = this.timePeriod!.toJson();
//     }
//     data['date_created'] = this.dateCreated;
//     data['random_offer_id'] = this.randomOfferId;
//     data['offer_percentage'] = this.offerPercentage;
//     return data;
//   }
// }
//
// class TimePeriod {
//   String? end;
//   String? start;
//
//   TimePeriod({this.end, this.start});
//
//   TimePeriod.fromJson(Map<String, dynamic> json) {
//     end = json['end'];
//     start = json['start'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['end'] = this.end;
//     data['start'] = this.start;
//     return data;
//   }
// }

/// new
class GetRestaurantListResModel {
  bool? status;
  String? message;
  Data? data;

  GetRestaurantListResModel({this.status, this.message, this.data});

  GetRestaurantListResModel.fromJson(Map<String, dynamic> json) {
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
  UserLocation? userLocation;
  List<restoData>? restaurantList;

  Data({this.userLocation, this.restaurantList});

  Data.fromJson(Map<String, dynamic> json) {
    userLocation = json['userLocation'] != null
        ? UserLocation.fromJson(json['userLocation'])
        : null;
    if (json['restaurantList'] != null) {
      restaurantList = <restoData>[];
      json['restaurantList'].forEach((v) {
        restaurantList!.add(new restoData.fromJson(v));
      });
    } else if (json['restaurantList'] == null) {
      restaurantList = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userLocation != null) {
      data['userLocation'] = this.userLocation!.toJson();
    }
    if (this.restaurantList != null) {
      data['restaurantList'] =
          this.restaurantList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserLocation {
  var userId;
  var userLocationId;
  var country;
  var countryCode;
  var cityName;
  var state;
  var address;
  var pincode;
  var lang;
  var lat;
  var dateCreated;

  UserLocation(
      {this.userId,
      this.userLocationId,
      this.country,
      this.countryCode,
      this.cityName,
      this.state,
      this.address,
      this.pincode,
      this.lang,
      this.lat,
      this.dateCreated});

  UserLocation.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userLocationId = json['user_location_id'];
    country = json['country'];
    countryCode = json['country_code'];
    cityName = json['city_name'];
    state = json['state'];
    address = json['address'];
    pincode = json['pincode'];
    lang = json['lang'];
    lat = json['lat'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_location_id'] = this.userLocationId;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city_name'] = this.cityName;
    data['state'] = this.state;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['lang'] = this.lang;
    data['lat'] = this.lat;
    data['date_created'] = this.dateCreated;
    return data;
  }
}

class restoData {
  var restaurantId;
  var emailId;
  var restaurantName;
  MenuItems? menuItems;
  MenuItems? seatingCapacity;
  var monthlyRevenueGoal;
  var priceRange;
  List<String>? restaurantCategory;
  List<String>? cuisine;
  var averageCost;
  List<String>? subFacility;
  var restaurantImg;
  List<Hours>? hours;
  List<String>? restaurantType;
  var restaurantMobileNumber;
  var dateCreated;
  var avg;
  var ratingCount;
  var distanceKm;
  RestaurantLocationData? restaurantLocationData;
  bool? isFavourite;
  List<OffersData>? offersData;

  restoData(
      {this.restaurantId,
      this.emailId,
      this.restaurantName,
      this.menuItems,
      this.seatingCapacity,
      this.monthlyRevenueGoal,
      this.priceRange,
      this.restaurantCategory,
      this.cuisine,
      this.averageCost,
      this.subFacility,
      this.restaurantImg,
      this.hours,
      this.restaurantType,
      this.restaurantMobileNumber,
      this.dateCreated,
      this.avg,
      this.ratingCount,
      this.distanceKm,
      this.restaurantLocationData,
      this.isFavourite,
      this.offersData});

  restoData.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    emailId = json['email_id'];
    restaurantName = json['restaurant_name'];
    menuItems = json['menu_items'] != null
        ? MenuItems.fromJson(json['menu_items'])
        : null;
    seatingCapacity = json['seating_capacity'] != null
        ? MenuItems.fromJson(json['seating_capacity'])
        : null;
    monthlyRevenueGoal = json['monthly_revenue_goal'];
    priceRange = json['price_range'];
    restaurantCategory = json['restaurant_category'] == null
        ? []
        : json['restaurant_category'].cast<String>();
    cuisine = json['cuisine'] == null ? [] : json['cuisine'].cast<String>();
    averageCost = json['average_cost'];
    subFacility =
        json['sub_facility'] == null ? [] : json['sub_facility'].cast<String>();
    restaurantImg = json['restaurant_img'];
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(new Hours.fromJson(v));
      });
    }
    restaurantType = json['restaurant_type'] == null
        ? []
        : json['restaurant_type'].cast<String>();
    restaurantMobileNumber = json['restaurant_mobile_number'];
    dateCreated = json['date_created'];
    avg = json['avg'];
    ratingCount = json['rating_count'];
    distanceKm = json['distance_km'];
    restaurantLocationData = json['restaurant_location_data'] != null
        ? RestaurantLocationData.fromJson(json['restaurant_location_data'])
        : null;
    isFavourite = json['is_favourite'];
    if (json['offers_data'] != null) {
      offersData = <OffersData>[];
      json['offers_data'].forEach((v) {
        offersData!.add(new OffersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['email_id'] = this.emailId;
    data['restaurant_name'] = this.restaurantName;
    if (this.menuItems != null) {
      data['menu_items'] = this.menuItems!.toJson();
    }
    if (this.seatingCapacity != null) {
      data['seating_capacity'] = this.seatingCapacity!.toJson();
    }
    data['monthly_revenue_goal'] = this.monthlyRevenueGoal;
    data['price_range'] = this.priceRange;
    data['restaurant_category'] = this.restaurantCategory;
    data['cuisine'] = this.cuisine;
    data['average_cost'] = this.averageCost;
    data['sub_facility'] = this.subFacility;
    data['restaurant_img'] = this.restaurantImg;
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    data['restaurant_type'] = this.restaurantType;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    data['date_created'] = this.dateCreated;
    data['avg'] = this.avg;
    data['rating_count'] = this.ratingCount;
    data['distance_km'] = this.distanceKm;
    if (this.restaurantLocationData != null) {
      data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
    }
    data['is_favourite'] = this.isFavourite;
    if (this.offersData != null) {
      data['offers_data'] = this.offersData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuItems {
  var min;
  var max;

  MenuItems({this.min, this.max});

  MenuItems.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

class Hours {
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  Monday? sunday;

  Hours(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Hours.fromJson(Map<String, dynamic> json) {
    monday =
        json['monday'] != null ? new Monday.fromJson(json['monday']) : null;
    tuesday =
        json['tuesday'] != null ? new Monday.fromJson(json['tuesday']) : null;
    wednesday = json['wednesday'] != null
        ? new Monday.fromJson(json['wednesday'])
        : null;
    thursday =
        json['thursday'] != null ? new Monday.fromJson(json['thursday']) : null;
    friday =
        json['friday'] != null ? new Monday.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? new Monday.fromJson(json['saturday']) : null;
    sunday =
        json['sunday'] != null ? new Monday.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    return data;
  }
}

class Monday {
  var from;
  var to;

  Monday({this.from, this.to});

  Monday.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class RestaurantLocationData {
  double? lat;
  double? lang;
  var state;
  var address;
  var area;
  var country;
  var pincode;
  var cityName;
  var countryCode;
  var dateCreated;
  var restoLocationId;

  RestaurantLocationData(
      {this.lat,
      this.lang,
      this.area,
      this.state,
      this.address,
      this.country,
      this.pincode,
      this.cityName,
      this.countryCode,
      this.dateCreated,
      this.restoLocationId});

  RestaurantLocationData.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lang = json['lang'];
    area = json['area'];
    state = json['state'];
    address = json['address'];
    country = json['country'];
    pincode = json['pincode'];
    cityName = json['city_name'];
    countryCode = json['country_code'];
    dateCreated = json['date_created'];
    restoLocationId = json['resto_location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['area'] = this.area;
    data['state'] = this.state;
    data['address'] = this.address;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['city_name'] = this.cityName;
    data['country_code'] = this.countryCode;
    data['date_created'] = this.dateCreated;
    data['resto_location_id'] = this.restoLocationId;
    return data;
  }
}

class OffersData {
  List<String>? day;
  var offerId;
  var dealDate;
  var dealType;
  var timeType;
  var minAmount;
  var offerType;
  var totalDeal;
  TimePeriod? timePeriod;
  var dateCreated;
  var randomOfferId;
  var offerPercentage;

  OffersData(
      {this.day,
      this.offerId,
      this.dealDate,
      this.dealType,
      this.timeType,
      this.minAmount,
      this.offerType,
      this.totalDeal,
      this.timePeriod,
      this.dateCreated,
      this.randomOfferId,
      this.offerPercentage});

  OffersData.fromJson(Map<String, dynamic> json) {
    day = json['day'].cast<String>();
    offerId = json['offer_id'];
    dealDate = json['deal_date'];
    dealType = json['deal_type'];
    timeType = json['time_type'];
    minAmount = json['min_amount'];
    offerType = json['offer_type'];
    totalDeal = json['total_deal'];
    timePeriod = json['time_period'] != null
        ? new TimePeriod.fromJson(json['time_period'])
        : null;
    dateCreated = json['date_created'];
    randomOfferId = json['random_offer_id'];
    offerPercentage = json['offer_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['offer_id'] = this.offerId;
    data['deal_date'] = this.dealDate;
    data['deal_type'] = this.dealType;
    data['time_type'] = this.timeType;
    data['min_amount'] = this.minAmount;
    data['offer_type'] = this.offerType;
    data['total_deal'] = this.totalDeal;
    if (this.timePeriod != null) {
      data['time_period'] = this.timePeriod!.toJson();
    }
    data['date_created'] = this.dateCreated;
    data['random_offer_id'] = this.randomOfferId;
    data['offer_percentage'] = this.offerPercentage;
    return data;
  }
}

class TimePeriod {
  var end;
  var start;

  TimePeriod({this.end, this.start});

  TimePeriod.fromJson(Map<String, dynamic> json) {
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
