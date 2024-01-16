class ViewPostResModel {
  bool? status;
  String? message;
  List<Data>? data;

  ViewPostResModel({this.status, this.message, this.data});

  ViewPostResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? postId;
  String? postImg;
  String? postTitle;
  String? description;
  String? date;
  String? preferredGender;
  String? preferredFood;
  String? dateCreated;
  String? cityName;
  String? userImg;
  String? fullName;

  Data(
      {this.postId,
      this.postImg,
      this.postTitle,
      this.description,
      this.date,
      this.preferredGender,
      this.preferredFood,
      this.dateCreated,
      this.cityName,
      this.userImg,
      this.fullName});

  Data.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    postImg = json['post_img'];
    postTitle = json['post_title'];
    description = json['description'];
    date = json['date'];
    preferredGender = json['preferred_gender'];
    preferredFood = json['preferred_food'];
    dateCreated = json['date_created'];
    cityName = json['city_name'];
    userImg = json['user_img'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['post_img'] = this.postImg;
    data['post_title'] = this.postTitle;
    data['description'] = this.description;
    data['date'] = this.date;
    data['preferred_gender'] = this.preferredGender;
    data['preferred_food'] = this.preferredFood;
    data['date_created'] = this.dateCreated;
    data['city_name'] = this.cityName;
    data['user_img'] = this.userImg;
    data['full_name'] = this.fullName;
    return data;
  }
}
