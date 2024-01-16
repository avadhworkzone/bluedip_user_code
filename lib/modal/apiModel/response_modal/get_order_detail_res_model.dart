class GetOrderDetailsResModel {
  bool? status;
  String? message;
  Data? data;

  GetOrderDetailsResModel({this.status, this.message, this.data});

  GetOrderDetailsResModel.fromJson(Map<String, dynamic> json) {
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
  List<SubItem>? subItem;
  var subTotal;
  var gstAmount;
  var packingCharges;
  var gst;
  var cgst;
  var sgst;
  var grandTotal;
  var netPayable;
  var total;
  var saving;
  var items;
  OrderData? orderData;

  Data(
      {this.subItem,
      this.subTotal,
      this.gstAmount,
      this.packingCharges,
      this.gst,
      this.cgst,
      this.sgst,
      this.grandTotal,
      this.netPayable,
      this.total,
      this.saving,
      this.items,
      this.orderData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subItem'] != null) {
      subItem = <SubItem>[];
      json['subItem'].forEach((v) {
        subItem!.add(new SubItem.fromJson(v));
      });
    }
    subTotal = json['subTotal'];
    gstAmount = json['gstAmount'];
    packingCharges = json['packingCharges'];
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    grandTotal = json['grandTotal'];
    netPayable = json['netPayable'];
    total = json['total'];
    saving = json['saving'];
    items = json['items'];
    orderData = json['orderData'] != null
        ? new OrderData.fromJson(json['orderData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subItem != null) {
      data['subItem'] = this.subItem!.map((v) => v.toJson()).toList();
    }
    data['subTotal'] = this.subTotal;
    data['gstAmount'] = this.gstAmount;
    data['packingCharges'] = this.packingCharges;
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['grandTotal'] = this.grandTotal;
    data['netPayable'] = this.netPayable;
    data['total'] = this.total;
    data['saving'] = this.saving;
    data['items'] = this.items;
    if (this.orderData != null) {
      data['orderData'] = this.orderData!.toJson();
    }
    return data;
  }
}

class SubItem {
  var cartItemId;
  var userId;
  var menuSubCategoryId;
  List<CheckSubMenuItem>? checkSubMenuItem;
  var quantity;
  var dateCreated;
  var addition;
  var totalPrice;
  List<MenuSubCategoryData>? menuSubCategoryData;

  SubItem(
      {this.cartItemId,
      this.userId,
      this.menuSubCategoryId,
      this.checkSubMenuItem,
      this.quantity,
      this.dateCreated,
      this.addition,
      this.totalPrice,
      this.menuSubCategoryData});

  SubItem.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    userId = json['user_id'];
    menuSubCategoryId = json['menu_sub_category_id'];
    if (json['check_sub_menu_item'] != null) {
      checkSubMenuItem = <CheckSubMenuItem>[];
      json['check_sub_menu_item'].forEach((v) {
        checkSubMenuItem!.add(new CheckSubMenuItem.fromJson(v));
      });
    }
    quantity = json['quantity'];
    dateCreated = json['date_created'];
    addition = json['addition'];
    totalPrice = json['total_price'];
    if (json['menu_sub_category_data'] != null) {
      menuSubCategoryData = <MenuSubCategoryData>[];
      json['menu_sub_category_data'].forEach((v) {
        menuSubCategoryData!.add(new MenuSubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_id'] = this.cartItemId;
    data['user_id'] = this.userId;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    if (this.checkSubMenuItem != null) {
      data['check_sub_menu_item'] =
          this.checkSubMenuItem!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['date_created'] = this.dateCreated;
    data['addition'] = this.addition;
    data['total_price'] = this.totalPrice;
    if (this.menuSubCategoryData != null) {
      data['menu_sub_category_data'] =
          this.menuSubCategoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckSubMenuItem {
  var id;
  var type;
  var name;
  var price;

  CheckSubMenuItem({this.id, this.type, this.name, this.price});

  CheckSubMenuItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}

class MenuSubCategoryData {
  var img;
  var name;
  var type;
  var price;
  var dateCreated;
  var savingPrice;
  var discountPrice;
  var menuCategoryId;
  var menuSubCategoryId;

  MenuSubCategoryData(
      {this.img,
      this.name,
      this.type,
      this.price,
      this.dateCreated,
      this.savingPrice,
      this.discountPrice,
      this.menuCategoryId,
      this.menuSubCategoryId});

  MenuSubCategoryData.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    name = json['name'];
    type = json['type'];
    price = json['price'];
    dateCreated = json['date_created'];
    savingPrice = json['saving_price'];
    discountPrice = json['discount_price'];
    menuCategoryId = json['menu_category_id'];
    menuSubCategoryId = json['menu_sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['date_created'] = this.dateCreated;
    data['saving_price'] = this.savingPrice;
    data['discount_price'] = this.discountPrice;
    data['menu_category_id'] = this.menuCategoryId;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    return data;
  }
}

class OrderData {
  var orderId;
  var randomOrderId;
  var restaurantId;
  var offerId;
  var orderType;
  var specialRequest;
  var time;
  var dateCreated;

  OrderData(
      {this.orderId,
      this.randomOrderId,
      this.restaurantId,
      this.offerId,
      this.orderType,
      this.specialRequest,
      this.time,
      this.dateCreated});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    restaurantId = json['restaurant_id'];
    offerId = json['offer_id'];
    orderType = json['order_type'];
    specialRequest = json['special_request'];
    time = json['time'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['restaurant_id'] = this.restaurantId;
    data['offer_id'] = this.offerId;
    data['order_type'] = this.orderType;
    data['special_request'] = this.specialRequest;
    data['time'] = this.time;
    data['date_created'] = this.dateCreated;
    return data;
  }
}
