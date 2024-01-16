import 'package:bluedip_user/utils/Utility.dart';

class GetRestaurantListReqModel {
  String? action;
  String? sorting;
  String? status;
  String? lang;
  String? lat;
  String? city_name;
  String? keyword;
  Filter? filter;
  var page;
  var limit;
  bool? liveStatus;

  GetRestaurantListReqModel(
      {this.action,
      this.sorting,
      this.status,
      this.lang,
      this.lat,
      this.keyword,
      this.filter,
      this.page,
      this.limit,
      this.city_name,
      this.liveStatus});

  GetRestaurantListReqModel.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    sorting = json['sorting'];
    status = json['status'];
    lang = json['lang'];
    lat = json['lat'];
    keyword = json['keyword'];
    page = json['page'];
    city_name = json['city_name'];
    limit = json['limit'];
    if (Utility.filter != null) {
      filter =
          json['filter'] != null ? new Filter.fromJson(json['filter']) : null;
    }
    liveStatus = json['live_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['sorting'] = this.sorting;
    data['status'] = this.status;
    data['lang'] = this.lang;
    data['lat'] = this.lat;
    data['keyword'] = this.keyword;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['city_name'] = this.city_name;
    data['live_status'] = this.liveStatus;
    if (Utility.filter != null) {
      if (this.filter != null) {
        data['filter'] = this.filter!.toJson();
      }
    }
    return data;
  }
}

class Filter {
  List<String>? restaurantType;
  List<String>? select;
  String? offerPercentage;
  String? averageCost;
  List<String>? cuisine;

  Filter(
      {this.restaurantType,
      this.select,
      this.offerPercentage,
      this.averageCost,
      this.cuisine});

  Filter.fromJson(Map<String, dynamic> json) {
    restaurantType = json['restaurant_type'].cast<String>();
    select = json['select'].cast<String>();
    offerPercentage = json['offer_percentage'];
    averageCost = json['average_cost'];
    cuisine = json['cuisine'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_type'] = this.restaurantType;
    data['select'] = this.select;
    data['offer_percentage'] = this.offerPercentage;
    data['average_cost'] = this.averageCost;
    data['cuisine'] = this.cuisine;
    return data;
  }
}
