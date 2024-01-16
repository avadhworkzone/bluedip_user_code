class GetCityListResModel {
  bool? status;
  List<Data>? data;

  GetCityListResModel({this.status, this.data});

  GetCityListResModel.fromJson(Map<String, dynamic> json) {
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
  int? locationId;
  String? cityName;
  String? statecode;

  Data({this.locationId, this.cityName, this.statecode});

  Data.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    cityName = json['city_name'];
    statecode = json['statecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['city_name'] = this.cityName;
    data['statecode'] = this.statecode;
    return data;
  }
}
