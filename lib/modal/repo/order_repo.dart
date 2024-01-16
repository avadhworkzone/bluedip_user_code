import 'dart:convert';
import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/add_order_req_model.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_sub_menu_item_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_order_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_sub_menu_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_to_cart_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_status_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_info_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_menu_item.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/order_resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/sub_menu_item_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/tack_order_history_res.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';
import '../apiModel/response_modal/dinein_order_history_res_model.dart';
import '../apiModel/response_modal/get_booking_order_detail_res.dart';

class OrderRepo extends BaseService {
  /// add order
  Future<dynamic> addOrderRepo({required AddOrderReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addOrder,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    AddOrderResModel addOrderResModel = AddOrderResModel.fromJson(response);
    return addOrderResModel;
  }

  /// order verify otp
  Future<dynamic> orderVerifyOtpRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderResendOtp,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    CommonResModel orderVerifyResModel = CommonResModel.fromJson(response);
    return orderVerifyResModel;
  }

  /// order resend otp
  Future<dynamic> orderResendOtpRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderResendOtp,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    OrderResendOtpResModel orderResendOtpResModel =
        OrderResendOtpResModel.fromJson(response);
    return orderResendOtpResModel;
  }

  /// get order menu items
  Future<dynamic> getOrderMenuRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: menuItems,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    GetOrderMenuItemsResModel getOrderMenuItemsResModel =
        GetOrderMenuItemsResModel.fromJson(response);
    return getOrderMenuItemsResModel;
  }

  /// add to cart
  Future<dynamic> addCartRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addToCart,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    AddToCartResModel addToCartResModel = AddToCartResModel.fromJson(response);
    return addToCartResModel;
  }

  /// get sub menu items
  Future<dynamic> getSubMenuRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: menuItems,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    SubMenuItemsResModel subMenuItemsResModel =
        SubMenuItemsResModel.fromJson(response);
    return subMenuItemsResModel;
  }

  /// add sub menu items
  Future<dynamic> addSubMenuItemsRepo(
      {required AddSubMenuItemsReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addToCart,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    AddSubMenuItemsResModel addSubMenuItemsResModel =
        AddSubMenuItemsResModel.fromJson(response);
    return addSubMenuItemsResModel;
  }

  /// order detail
  Future<dynamic> getOrderDetailRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    GetOrderDetailsResModel getOrderDetailsResModel =
        GetOrderDetailsResModel.fromJson(response);
    return getOrderDetailsResModel;
  }

  /// get order list
  Future<dynamic> getOrderListRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderList,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    GetOrderListResModel getOrderListResModel =
        GetOrderListResModel.fromJson(response);
    return getOrderListResModel;
  }

  /// get order detail with status
  Future<dynamic> getOrderDetailStatusRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderList,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    GetOrderDetailStatusResModel getOrderDetailStatusResModel =
        GetOrderDetailStatusResModel.fromJson(response);
    return getOrderDetailStatusResModel;
  }

  /// dine in booking order detail
  Future<dynamic> getBookingOrderDetailRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: bookingOrderDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    GetBookingOrderDetailResModel getBookingOrderDetailResModel =
        GetBookingOrderDetailResModel.fromJson(response);
    return getBookingOrderDetailResModel;
  }

  /// cancel booking
  Future<dynamic> cancelBookingRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: bookingOrderDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    CommonResModel commonResModel = CommonResModel.fromJson(response);
    return commonResModel;
  }

  /// tack away order history
  Future<dynamic> tackAwayOrderHistoryRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderHistory,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    TackAwayOrderHistoryResModel historyRes =
        TackAwayOrderHistoryResModel.fromJson(response);
    return historyRes;
  }

  /// dine in order history
  Future<dynamic> dineInOrderHistoryRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: orderHistory,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    DineInOrderHistoryResModel historyRes =
        DineInOrderHistoryResModel.fromJson(response);
    return historyRes;
  }

  /// GUEST DID NOT COME STATUS CHANGE
  Future<dynamic> guestAttendStatusRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: bookingOrderDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    CommonResModel guestAttendStatusRes = CommonResModel.fromJson(response);
    return guestAttendStatusRes;
  }

  /// getOtp repo
  Future<dynamic> getOtpForOrderRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addOrder,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    OrderResendOtpResModel otpForOrderRes =
        OrderResendOtpResModel.fromJson(response);
    return otpForOrderRes;
  }

  /// get order info for edit
  Future<dynamic> getOrderInfoRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addOrder,
      body: body,
      withToken: true,
    );
    log("=============RES:=========${jsonEncode(response)}");

    if (response == null) {
      return null;
    }

    GetOrderInfoResModel getOrderInfoResModel =
        GetOrderInfoResModel.fromJson(response);
    return getOrderInfoResModel;
  }
}
