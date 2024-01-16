class RestaurantDetailsResModel {
  bool? status;
  Data? data;

  RestaurantDetailsResModel({this.status, this.data});

  RestaurantDetailsResModel.fromJson(Map<String, dynamic> json) {
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
  var restaurantId;
  var restaurantName;
  var restaurantImg;
  var restaurantMobileNumber;
  MenuItems? menuItems;
  List<String>? restaurantCategory;
  List<String>? cuisine;
  List<String>? subFacility;
  List<Hours>? hours;
  int? averageCost;
  List<String>? restaurantType;
  var dateCreated;
  DineInRating? dineInRating;
  var avg;
  var ratingCount;
  var distanceKm;
  RestaurantLocationData? restaurantLocationData;
  bool? isFavourite;

  Data(
      {this.restaurantId,
      this.restaurantName,
      this.restaurantImg,
      this.restaurantMobileNumber,
      this.menuItems,
      this.restaurantCategory,
      this.cuisine,
      this.subFacility,
      this.hours,
      this.averageCost,
      this.restaurantType,
      this.dateCreated,
      this.dineInRating,
      this.avg,
      this.ratingCount,
      this.distanceKm,
      this.restaurantLocationData,
      this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    restaurantImg = json['restaurant_img'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
    menuItems = json['menu_items'] != null
        ? new MenuItems.fromJson(json['menu_items'])
        : null;
    restaurantCategory = json['restaurant_category'] == null
        ? []
        : json['restaurant_category'].cast<String>();
    cuisine = json['cuisine'] == null ? [] : json['cuisine'].cast<String>();
    subFacility =
        json['sub_facility'] == null ? [] : json['sub_facility'].cast<String>();
    if (json['hours'] != null) {
      hours = <Hours>[];
      json['hours'].forEach((v) {
        hours!.add(new Hours.fromJson(v));
      });
    }
    averageCost = json['average_cost'];
    restaurantType = json['restaurant_type'].cast<String>();
    dateCreated = json['date_created'];
    dineInRating = json['dine_in_rating'] != null
        ? new DineInRating.fromJson(json['dine_in_rating'])
        : null;
    avg = json['avg'];
    ratingCount = json['rating_count'];
    distanceKm = json['distance_km'];
    restaurantLocationData = json['restaurant_location_data'] != null
        ? new RestaurantLocationData.fromJson(json['restaurant_location_data'])
        : null;
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_img'] = this.restaurantImg;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    if (this.menuItems != null) {
      data['menu_items'] = this.menuItems!.toJson();
    }
    data['restaurant_category'] = this.restaurantCategory;
    data['cuisine'] = this.cuisine;
    data['sub_facility'] = this.subFacility;
    if (this.hours != null) {
      data['hours'] = this.hours!.map((v) => v.toJson()).toList();
    }
    data['average_cost'] = this.averageCost;
    data['restaurant_type'] = this.restaurantType;
    data['date_created'] = this.dateCreated;
    if (this.dineInRating != null) {
      data['dine_in_rating'] = this.dineInRating!.toJson();
    }
    data['avg'] = this.avg;
    data['rating_count'] = this.ratingCount;
    data['distance_km'] = this.distanceKm;
    if (this.restaurantLocationData != null) {
      data['restaurant_location_data'] = this.restaurantLocationData!.toJson();
    }
    data['is_favourite'] = this.isFavourite;
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

class DineInRating {
  var rating;
  var count;

  DineInRating({this.rating, this.count});

  DineInRating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['count'] = this.count;
    return data;
  }
}

class RestaurantLocationData {
  double? lat;
  Geom? geom;
  var lang;
  var state;
  var address;
  var country;
  var pincode;
  var cityName;
  var countryCode;
  var dateCreated;
  var restoLocationId;

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
      this.dateCreated,
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
    dateCreated = json['date_created'];
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
    data['date_created'] = this.dateCreated;
    data['resto_location_id'] = this.restoLocationId;
    return data;
  }
}

class Geom {
  var type;
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
