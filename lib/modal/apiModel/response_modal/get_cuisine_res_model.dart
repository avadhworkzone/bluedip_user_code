class GetCuisineResModel {
  bool? status;
  List<Data>? data;

  GetCuisineResModel({this.status, this.data});

  GetCuisineResModel.fromJson(Map<String, dynamic> json) {
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
  int? cuisineId;
  String? cuisineName;
  String? dateCreated;
  Null? dateModified;
  String? status;
  int? isDeleted;

  Data(
      {this.cuisineId,
      this.cuisineName,
      this.dateCreated,
      this.dateModified,
      this.status,
      this.isDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    cuisineId = json['cuisine_id'];
    cuisineName = json['cuisine_name'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    status = json['status'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuisine_id'] = this.cuisineId;
    data['cuisine_name'] = this.cuisineName;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['status'] = this.status;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
