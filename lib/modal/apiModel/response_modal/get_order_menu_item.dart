class GetOrderMenuItemsResModel {
  bool? status;
  String? restaurantName;
  String? offerPercentage;
  List<Data>? data;
  var items;
  var total;
  var saving;

  GetOrderMenuItemsResModel(
      {this.status,
      this.restaurantName,
      this.offerPercentage,
      this.data,
      this.items,
      this.total,
      this.saving});

  GetOrderMenuItemsResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    restaurantName = json['restaurant_name'];
    offerPercentage = json['offer_percentage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    items = json['items'];
    total = json['total'];
    saving = json['saving'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['restaurant_name'] = this.restaurantName;
    data['offer_percentage'] = this.offerPercentage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    } else {
      data['data'] = null;
    }
    data['items'] = this.items;
    data['total'] = this.total;
    data['saving'] = this.saving;
    return data;
  }
}

class Data {
  String? menuCategoryId;
  String? name;
  String? restaurantId;
  String? dateCreated;
  List<MenuSubCategoryData>? menuSubCategoryData;

  Data(
      {this.menuCategoryId,
      this.name,
      this.restaurantId,
      this.dateCreated,
      this.menuSubCategoryData});

  Data.fromJson(Map<String, dynamic> json) {
    menuCategoryId = json['menu_category_id'];
    name = json['name'];
    restaurantId = json['restaurant_id'];
    dateCreated = json['date_created'];
    if (json['menu_sub_category_data'] != null) {
      menuSubCategoryData = <MenuSubCategoryData>[];
      json['menu_sub_category_data'].forEach((v) {
        menuSubCategoryData!.add(new MenuSubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_category_id'] = this.menuCategoryId;
    data['name'] = this.name;
    data['restaurant_id'] = this.restaurantId;
    data['date_created'] = this.dateCreated;
    if (this.menuSubCategoryData != null) {
      data['menu_sub_category_data'] =
          this.menuSubCategoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuSubCategoryData {
  var img;
  String? name;
  String? type;
  int? price;
  CartData? cartData;
  String? description;
  String? dateCreated;
  var savingPrice;
  var discountPrice;
  var menuSubCategoryId;

  MenuSubCategoryData(
      {this.img,
      this.name,
      this.type,
      this.price,
      this.cartData,
      this.description,
      this.dateCreated,
      this.savingPrice,
      this.discountPrice,
      this.menuSubCategoryId});

  MenuSubCategoryData.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    cartData =
        json['cart_data'] != null ? CartData.fromJson(json['cart_data']) : null;
    description = json['description'];
    dateCreated = json['date_created'];
    savingPrice = json['saving_price'];
    discountPrice = json['discount_price'];
    menuSubCategoryId = json['menu_sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    if (this.cartData != null) {
      data['cart_data'] = this.cartData!.toJson();
    } else {
      data['cart_data'] = null;
    }
    data['description'] = this.description;
    data['date_created'] = this.dateCreated;
    data['saving_price'] = this.savingPrice;
    data['discount_price'] = this.discountPrice;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    return data;
  }
}

class CartData {
  var quantity;
  String? cartItemId;
  String? dateCreated;
  List<SubMenuItem>? subMenuItem;
  var menuSubCategoryId;

  CartData(
      {this.quantity,
      this.cartItemId,
      this.dateCreated,
      this.subMenuItem,
      this.menuSubCategoryId});

  CartData.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    cartItemId = json['cart_item_id'];
    dateCreated = json['date_created'];
    if (json['sub_menu_item'] != null) {
      subMenuItem = <SubMenuItem>[];
      json['sub_menu_item'].forEach((v) {
        subMenuItem!.add(new SubMenuItem.fromJson(v));
      });
    }
    menuSubCategoryId = json['menu_sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['cart_item_id'] = this.cartItemId;
    data['date_created'] = this.dateCreated;
    if (this.subMenuItem != null) {
      data['sub_menu_item'] = this.subMenuItem!.map((v) => v.toJson()).toList();
    }
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    return data;
  }
}

class SubMenuItem {
  String? id;
  String? name;
  String? type;
  String? price;

  SubMenuItem({this.id, this.name, this.type, this.price});

  SubMenuItem.fromJson(Map<String, dynamic> json) {
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
