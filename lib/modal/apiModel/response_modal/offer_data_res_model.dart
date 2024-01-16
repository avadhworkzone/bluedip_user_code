class OfferDataResModel {
  bool? status;
  List<Data>? data;

  OfferDataResModel({this.status, this.data});

  OfferDataResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  String? dateCreated;

  Data(
      {this.offerId,
      this.randomOfferId,
      this.restaurantId,
      this.offerPercentage,
      this.timeType,
      this.timePeriod,
      this.deals,
      this.offerType,
      this.dateCreated});

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
    dateCreated = json['date_created'];
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
    data['date_created'] = this.dateCreated;
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
