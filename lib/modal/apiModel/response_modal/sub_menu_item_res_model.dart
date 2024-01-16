class SubMenuItemsResModel {
  bool? status;
  String? message;
  List<Data>? data;

  SubMenuItemsResModel({this.status, this.message, this.data});

  SubMenuItemsResModel.fromJson(Map<String, dynamic> json) {
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
  int? menuSubCategoryId;
  String? name;
  int? price;
  String? discountPrice;
  String? description;
  String? type;
  var img;
  String? dateCreated;
  List<AllSubMenuItemData>? allSubMenuItemData;
  List<CheckSubMenuItemData>? checkSubMenuItemData;

  Data(
      {this.menuSubCategoryId,
      this.name,
      this.price,
      this.discountPrice,
      this.description,
      this.type,
      this.img,
      this.dateCreated,
      this.allSubMenuItemData,
      this.checkSubMenuItemData});

  Data.fromJson(Map<String, dynamic> json) {
    menuSubCategoryId = json['menu_sub_category_id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    description = json['description'];
    type = json['type'];
    img = json['img'];
    dateCreated = json['date_created'];
    if (json['all_sub_menu_item_data'] != null) {
      allSubMenuItemData = <AllSubMenuItemData>[];
      json['all_sub_menu_item_data'].forEach((v) {
        allSubMenuItemData!.add(new AllSubMenuItemData.fromJson(v));
      });
    }
    if (json['check_sub_menu_item_data'] != null) {
      checkSubMenuItemData = <CheckSubMenuItemData>[];
      json['check_sub_menu_item_data'].forEach((v) {
        checkSubMenuItemData!.add(new CheckSubMenuItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['description'] = this.description;
    data['type'] = this.type;
    data['img'] = this.img;
    data['date_created'] = this.dateCreated;
    if (this.allSubMenuItemData != null) {
      data['all_sub_menu_item_data'] =
          this.allSubMenuItemData!.map((v) => v.toJson()).toList();
    }
    if (this.checkSubMenuItemData != null) {
      data['check_sub_menu_item_data'] =
          this.checkSubMenuItemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllSubMenuItemData {
  String? name;
  String? type;
  int? price;
  String? dateCreated;
  String? subMenuItemId;
  int? menuSubCategoryId;

  AllSubMenuItemData(
      {this.name,
      this.type,
      this.price,
      this.dateCreated,
      this.subMenuItemId,
      this.menuSubCategoryId});

  AllSubMenuItemData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    price = json['price'];
    dateCreated = json['date_created'];
    subMenuItemId = json['sub_menu_item_id'];
    menuSubCategoryId = json['menu_sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['date_created'] = this.dateCreated;
    data['sub_menu_item_id'] = this.subMenuItemId;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    return data;
  }
}

class CheckSubMenuItemData {
  String? id;
  String? name;
  String? type;
  String? price;

  CheckSubMenuItemData({this.id, this.name, this.type, this.price});

  CheckSubMenuItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    return data;
  }
}
