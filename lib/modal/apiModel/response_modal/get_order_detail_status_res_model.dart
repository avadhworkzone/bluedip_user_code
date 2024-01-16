class GetOrderDetailStatusResModel {
  bool? status;
  String? message;
  Data? data;

  GetOrderDetailStatusResModel({this.status, this.message, this.data});

  GetOrderDetailStatusResModel.fromJson(Map<String, dynamic> json) {
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
  var orderId;
  var randomOrderId;
  var userId;
  var restaurantId;
  var offerId;
  var orderType;
  var orderStatus;
  var specialRequest;
  var time;
  var userFullName;
  var mobileNumber;
  var orderPreparationTime;
  var orderAcceptedTime;
  var orderRejectedTime;
  var orderReadyTime;
  var orderPickupTime;
  String? dateCreated;
  RestaurantData? restaurantData;
  PaymentData? paymentData;
  List<CartData>? cartData;
  var totalItems;

  Data(
      {this.orderId,
      this.randomOrderId,
      this.userId,
      this.restaurantId,
      this.offerId,
      this.orderType,
      this.orderStatus,
      this.specialRequest,
      this.time,
      this.userFullName,
      this.mobileNumber,
      this.orderPreparationTime,
      this.orderAcceptedTime,
      this.orderRejectedTime,
      this.orderReadyTime,
      this.orderPickupTime,
      this.dateCreated,
      this.restaurantData,
      this.paymentData,
      this.cartData,
      this.totalItems});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    randomOrderId = json['random_order_id'];
    userId = json['user_id'];
    restaurantId = json['restaurant_id'];
    offerId = json['offer_id'];
    orderType = json['order_type'];
    orderStatus = json['order_status'];
    specialRequest = json['special_request'];
    time = json['time'];
    userFullName = json['user_full_name'];
    mobileNumber = json['mobile_number'];
    orderPreparationTime = json['order_preparation_time'];
    orderAcceptedTime = json['order_accepted_time'];
    orderRejectedTime = json['order_rejected_time'];
    orderReadyTime = json['order_ready_time'];
    orderPickupTime = json['order_pickup_time'];
    dateCreated = json['date_created'];
    restaurantData = json['restaurant_data'] != null
        ? new RestaurantData.fromJson(json['restaurant_data'])
        : null;
    paymentData = json['payment_data'] != null
        ? new PaymentData.fromJson(json['payment_data'])
        : null;
    if (json['cart_data'] != null) {
      cartData = <CartData>[];
      json['cart_data'].forEach((v) {
        cartData!.add(new CartData.fromJson(v));
      });
    }
    totalItems = json['total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['random_order_id'] = this.randomOrderId;
    data['user_id'] = this.userId;
    data['restaurant_id'] = this.restaurantId;
    data['offer_id'] = this.offerId;
    data['order_type'] = this.orderType;
    data['order_status'] = this.orderStatus;
    data['special_request'] = this.specialRequest;
    data['time'] = this.time;
    data['user_full_name'] = this.userFullName;
    data['mobile_number'] = this.mobileNumber;
    data['order_preparation_time'] = this.orderPreparationTime;
    data['order_accepted_time'] = this.orderAcceptedTime;
    data['order_rejected_time'] = this.orderRejectedTime;
    data['order_ready_time'] = this.orderReadyTime;
    data['order_pickup_time'] = this.orderPickupTime;
    data['date_created'] = this.dateCreated;
    if (this.restaurantData != null) {
      data['restaurant_data'] = this.restaurantData!.toJson();
    }
    if (this.paymentData != null) {
      data['payment_data'] = this.paymentData!.toJson();
    }
    if (this.cartData != null) {
      data['cart_data'] = this.cartData!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = this.totalItems;
    return data;
  }
}

class RestaurantData {
  var emailId;
  var dateCreated;
  var restaurantId;
  var restaurantImg;
  var restaurantName;
  var restaurantMobileNumber;

  RestaurantData(
      {this.emailId,
      this.dateCreated,
      this.restaurantId,
      this.restaurantImg,
      this.restaurantName,
      this.restaurantMobileNumber});

  RestaurantData.fromJson(Map<String, dynamic> json) {
    emailId = json['email_id'];
    dateCreated = json['date_created'];
    restaurantId = json['restaurant_id'];
    restaurantImg = json['restaurant_img'];
    restaurantName = json['restaurant_name'];
    restaurantMobileNumber = json['restaurant_mobile_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_id'] = this.emailId;
    data['date_created'] = this.dateCreated;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_img'] = this.restaurantImg;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_mobile_number'] = this.restaurantMobileNumber;
    return data;
  }
}

class PaymentData {
  var gst;
  var cgst;
  var sgst;
  var items;
  var savings;
  var userId;
  var orderId;
  var subTotal;
  var gstAmount;
  var paymentId;
  var grandTotal;
  var netPayable;
  var dateCreated;
  var paymentType;
  var packingCharges;
  var randomPaymentId;

  PaymentData(
      {this.gst,
      this.cgst,
      this.sgst,
      this.items,
      this.savings,
      this.userId,
      this.orderId,
      this.subTotal,
      this.gstAmount,
      this.paymentId,
      this.grandTotal,
      this.netPayable,
      this.dateCreated,
      this.paymentType,
      this.packingCharges,
      this.randomPaymentId});

  PaymentData.fromJson(Map<String, dynamic> json) {
    gst = json['gst'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    items = json['items'];
    savings = json['savings'];
    userId = json['user_id'];
    orderId = json['order_id'];
    subTotal = json['sub_total'];
    gstAmount = json['gst_amount'];
    paymentId = json['payment_id'];
    grandTotal = json['grand_total'];
    netPayable = json['net_payable'];
    dateCreated = json['date_created'];
    paymentType = json['payment_type'];
    packingCharges = json['packing_charges'];
    randomPaymentId = json['random_payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gst'] = this.gst;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['items'] = this.items;
    data['savings'] = this.savings;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['sub_total'] = this.subTotal;
    data['gst_amount'] = this.gstAmount;
    data['payment_id'] = this.paymentId;
    data['grand_total'] = this.grandTotal;
    data['net_payable'] = this.netPayable;
    data['date_created'] = this.dateCreated;
    data['payment_type'] = this.paymentType;
    data['packing_charges'] = this.packingCharges;
    data['random_payment_id'] = this.randomPaymentId;
    return data;
  }
}

class CartData {
  var orderId;
  var quantity;
  var cartItemId;
  var dateCreated;
  var savingPrice;
  var totalAmount;
  List<SubMenuItem>? subMenuItem;
  var discountPrice;
  MenuItemName? menuItemName;
  var totalDiscountPrice;

  CartData(
      {this.orderId,
      this.quantity,
      this.cartItemId,
      this.dateCreated,
      this.savingPrice,
      this.totalAmount,
      this.subMenuItem,
      this.discountPrice,
      this.menuItemName,
      this.totalDiscountPrice});

  CartData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    quantity = json['quantity'];
    cartItemId = json['cart_item_id'];
    dateCreated = json['date_created'];
    savingPrice = json['saving_price'];
    totalAmount = json['total_amount'];
    if (json['sub_menu_item'] != null) {
      subMenuItem = <SubMenuItem>[];
      json['sub_menu_item'].forEach((v) {
        subMenuItem!.add(new SubMenuItem.fromJson(v));
      });
    }
    discountPrice = json['discount_price'];
    menuItemName = json['menu_item_name'] != null
        ? new MenuItemName.fromJson(json['menu_item_name'])
        : null;
    totalDiscountPrice = json['total_discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['quantity'] = this.quantity;
    data['cart_item_id'] = this.cartItemId;
    data['date_created'] = this.dateCreated;
    data['saving_price'] = this.savingPrice;
    data['total_amount'] = this.totalAmount;
    if (this.subMenuItem != null) {
      data['sub_menu_item'] = this.subMenuItem!.map((v) => v.toJson()).toList();
    }
    data['discount_price'] = this.discountPrice;
    if (this.menuItemName != null) {
      data['menu_item_name'] = this.menuItemName!.toJson();
    }
    data['total_discount_price'] = this.totalDiscountPrice;
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

class MenuItemName {
  var name;
  var type;
  var price;
  var dateCreated;
  var menuSubCategoryId;

  MenuItemName(
      {this.name,
      this.type,
      this.price,
      this.dateCreated,
      this.menuSubCategoryId});

  MenuItemName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    price = json['price'];
    dateCreated = json['date_created'];
    menuSubCategoryId = json['menu_sub_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['price'] = this.price;
    data['date_created'] = this.dateCreated;
    data['menu_sub_category_id'] = this.menuSubCategoryId;
    return data;
  }
}
