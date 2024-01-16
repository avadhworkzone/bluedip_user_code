import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/add_order_req_model.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_payment_req_model.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_sub_menu_item_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_payment_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_sub_menu_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_to_cart_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_booking_order_detail_res.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_status_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_menu_item.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/order_resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/sub_menu_item_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/tack_order_history_res.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/payment_repo.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:get/get.dart';
import '../modal/apiModel/response_modal/add_order_res_model.dart';
import '../modal/apiModel/response_modal/dinein_order_history_res_model.dart';
import '../modal/repo/order_repo.dart';

class OrderViewModel extends GetxController {
  ApiResponse addOrderApiResponse = ApiResponse.initial('Initial');
  ApiResponse orderVerifyOtpApiResponse = ApiResponse.initial('Initial');
  ApiResponse orderResendOtpApiResponse = ApiResponse.initial('Initial');
  ApiResponse orderMenuApiResponse = ApiResponse.initial('Initial');
  ApiResponse addToCartApiResponse = ApiResponse.initial('Initial');
  ApiResponse subMenuApiResponse = ApiResponse.initial('Initial');
  ApiResponse addSubMenuItemsApiResponse = ApiResponse.initial('Initial');
  ApiResponse getOrderDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse addPaymentApiResponse = ApiResponse.initial('Initial');
  ApiResponse addOrderDetailStatusApiResponse = ApiResponse.initial('Initial');
  ApiResponse getBookingOrderDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse editOrderApiResponse = ApiResponse.initial('Initial');
  ApiResponse cancelBookingApiResponse = ApiResponse.initial('Initial');
  ApiResponse tOrderHistoryApiResponse = ApiResponse.initial('Initial');
  ApiResponse guestAttendStatusApiResponse = ApiResponse.initial('Initial');
  ApiResponse dOrderHistoryApiResponse = ApiResponse.initial('Initial');
  ApiResponse updatePaymentApiResponse = ApiResponse.initial('Initial');
  ApiResponse getOtpForOrderApiResponse = ApiResponse.initial('Initial');

  Map<String, dynamic> addToCartLocalData = {};
  List<Map<String, dynamic>> menu = [];

  num priceCount() {
    double allProductPriceTotal = 0.0;
    print('addToCartLocalData list--->>>${addToCartLocalData['data']}');
    addToCartLocalData['data']!.forEach((element) {
      if ((element['menu'] as List).isNotEmpty) {
        print('element menu ===${element['menu']}');
        allProductPriceTotal += (element['menu'] as List)
            .map((item) => item['price'] * item['qty'])
            .reduce((p, e) => p + e);
        print('allProductPriceTotal-->>>>>${allProductPriceTotal}');
      }
    });
    return allProductPriceTotal;
  }

  num savingPriceCount() {
    double savingPriceTotal = 0.0;
    print('addToCartLocalData list--->>>${addToCartLocalData['data']}');
    addToCartLocalData['data']!.forEach((element) {
      if ((element['menu'] as List).isNotEmpty) {
        print('element menu ===${element['menu']}');
        savingPriceTotal += (element['menu'] as List)
            .map((item) => item['saving_price'] * item['qty'])
            .reduce((p, e) => p + e);
      }
    });
    return savingPriceTotal;
  }

  qtyCount() {
    num qty = 0;
    addToCartLocalData['data']!.forEach((element) {
      if ((element['menu'] as List).isNotEmpty) {
        element['menu'].forEach((element) {
          qty += element['qty'];
        });
      }
    });
    return qty;
  }

  /// add order
  Future<void> addOrder({required AddOrderReqModel body}) async {
    addOrderApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      AddOrderResModel response = await OrderRepo().addOrderRepo(model: body);
      addOrderApiResponse = ApiResponse.complete(response);
      log("addOrderApiResponse RES: $response");
    } catch (e) {
      log('addOrderApiResponse.....$e');
      addOrderApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// order verify otp
  Future<void> orderVerifyOtp({String? mobileNumber, String? secretOtp}) async {
    orderVerifyOtpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CommonResModel response = await OrderRepo().orderVerifyOtpRepo(body: {
        "action": "verify_otp",
        // "type": "verify_order",
        "mobile_number": mobileNumber,
        "secret_otp": secretOtp
      });
      orderVerifyOtpApiResponse = ApiResponse.complete(response);
      log("orderVerifyOtpApiResponse RES: $response");
    } catch (e) {
      log('orderVerifyOtpApiResponse.....$e');
      orderVerifyOtpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// order resend otp
  Future<void> orderResendOtp({String? mobileNumber}) async {
    orderResendOtpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      OrderResendOtpResModel response =
          await OrderRepo().orderResendOtpRepo(body: {
        "action": "resend_otp",
        // "type": "verify_order",
        "mobile_number": mobileNumber,
      });
      orderResendOtpApiResponse = ApiResponse.complete(response);
      log("orderResendOtpApiResponse RES: $response");
    } catch (e) {
      log('orderResendOtpApiResponse.....$e');
      orderResendOtpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// order menu items
  Future<void> orderMenuItems(
      {required String restoId, required String offerId}) async {
    orderMenuApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetOrderMenuItemsResModel response =
          await OrderRepo().getOrderMenuRepo(body: {
        "action": "get_menu_item",
        "restaurant_id": restoId,
        "offer_id": offerId,
      });
      orderMenuApiResponse = ApiResponse.complete(response);
      log("orderMenuApiResponse RES: $response");
    } catch (e) {
      log('orderMenuApiResponse.....$e');
      orderMenuApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// add to cart
  Future<void> addToCart(
      {required int subCategoryId,
      required int qty,
      required String orderId}) async {
    addToCartApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      AddToCartResModel response = await OrderRepo().addCartRepo(body: {
        "action": "add_cart",
        "menu_sub_category_id": subCategoryId.toString(),
        "quantity": qty.toString(),
        "order_id": orderId,
        "restaurant_id": PreferenceManagerUtils.getRestoId()
      });
      addToCartApiResponse = ApiResponse.complete(response);
      log("addToCartApiResponse RES: $response");
    } catch (e) {
      log('addToCartApiResponse.....$e');
      addToCartApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// sub menu items
  Future<void> getSubMenu(
      {required String menuSubCatId, required String offerId}) async {
    subMenuApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      SubMenuItemsResModel response = await OrderRepo().getSubMenuRepo(body: {
        "action": "get_sub_menu_items",
        "menu_sub_category_id": menuSubCatId,
        "offer_id": offerId,
      });
      subMenuApiResponse = ApiResponse.complete(response);
      log("subMenuApiResponse RES: $response");
    } catch (e) {
      log('subMenuApiResponse.....$e');
      subMenuApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// add sub menu items
  Future<void> addSubMenuItems({required AddSubMenuItemsReqModel body}) async {
    addSubMenuItemsApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      AddSubMenuItemsResModel response =
          await OrderRepo().addSubMenuItemsRepo(model: body);
      addSubMenuItemsApiResponse = ApiResponse.complete(response);
      log("addSubMenuItemsApiResponse RES: $response");
    } catch (e) {
      log('addSubMenuItemsApiResponse.....$e');
      addSubMenuItemsApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// order detail
  Future<void> getOrderDetail(
      {required String restoId, required String offerId}) async {
    getOrderDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetOrderDetailsResModel response =
          await OrderRepo().getOrderDetailRepo(body: {
        "action": "get_cart_item",
        "restaurant_id": restoId,
        "offer_id": offerId,
      });
      getOrderDetailApiResponse = ApiResponse.complete(response);
      log("getOrderDetailApiResponse RES: $response");
    } catch (e) {
      log('getOrderDetailApiResponse.....$e');
      getOrderDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// add payment
  Future<void> addPayment({required AddPaymentReqModel model}) async {
    addPaymentApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      AddPaymentResModel response =
          await PaymentRepo().paymentRepo(model: model);
      addPaymentApiResponse = ApiResponse.complete(response);
      log("addPaymentApiResponse RES: $response");
    } catch (e) {
      log('addPaymentApiResponse.....$e');
      addPaymentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// get order detail status
  Future<void> getOrderDetailStatus({required String orderId}) async {
    addOrderDetailStatusApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetOrderDetailStatusResModel response =
          await OrderRepo().getOrderDetailStatusRepo(body: {
        "action": "view_order_details",
        "order_id": orderId,
      });
      addOrderDetailStatusApiResponse = ApiResponse.complete(response);
      log("addOrderDetailStatusApiResponse RES: $response");
    } catch (e) {
      log('addOrderDetailStatusApiResponse.....$e');
      addOrderDetailStatusApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// booking order detail
  Future<void> getBookingOrderViewModel({required String orderId}) async {
    getBookingOrderDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetBookingOrderDetailResModel response =
          await OrderRepo().getBookingOrderDetailRepo(body: {
        "action": "get_booking_order",
        "order_id": orderId,
      });
      getBookingOrderDetailApiResponse = ApiResponse.complete(response);
      log("getBookingOrderDetailApiResponse RES: $response");
    } catch (e) {
      log('getBookingOrderDetailApiResponse.....$e');
      getBookingOrderDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// cancel booking order
  Future<void> cancelBookingViewModel({required String? orderId}) async {
    cancelBookingApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      CommonResModel response = await OrderRepo().cancelBookingRepo(body: {
        "action": "cancel_booking",
        "status": "CANCEL_BOOKING",
        "order_id": orderId
      });
      cancelBookingApiResponse = ApiResponse.complete(response);
      log("cancelBookingApiResponse RES: $response");
    } catch (e) {
      log('cancelBookingApiResponse.....$e');
      cancelBookingApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// tack away order history
  Future<void> tOrderHistoryViewModel(
      {required String? sorting, String? keyWord}) async {
    tOrderHistoryApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      TackAwayOrderHistoryResModel response = await OrderRepo()
          .tackAwayOrderHistoryRepo(body: {
        "action": "takeaway_order_history",
        "sorting": sorting,
        "keyword": keyWord ?? ""
      });
      tOrderHistoryApiResponse = ApiResponse.complete(response);
      log("tOrderHistoryApiResponse RES: $response");
    } catch (e) {
      log('tOrderHistoryApiResponse.....$e');
      tOrderHistoryApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// guest Attend Status
  Future<void> guestAttendStatusViewModel(
      {required String? orderId, required String? status}) async {
    guestAttendStatusApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      CommonResModel response = await OrderRepo().guestAttendStatusRepo(body: {
        "action": "guest_attend_status",
        "status": status,
        "order_id": orderId
      });
      guestAttendStatusApiResponse = ApiResponse.complete(response);
      log("guestAttendStatusApiResponse RES: $response");
    } catch (e) {
      log('guestAttendStatusApiResponse.....$e');
      guestAttendStatusApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// dine in order history
  Future<void> dOrderHistoryViewModel(
      {required String? sorting, String? keyWord}) async {
    dOrderHistoryApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      DineInOrderHistoryResModel response = await OrderRepo()
          .dineInOrderHistoryRepo(body: {
        "action": "dine_in_order_history",
        "sorting": sorting,
        "keyword": keyWord ?? ""
      });
      dOrderHistoryApiResponse = ApiResponse.complete(response);
      log("dOrderHistoryApiResponse RES: $response");
    } catch (e) {
      log('dOrderHistoryApiResponse.....$e');
      dOrderHistoryApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// update payment
  Future<void> updatePayment(
      {required String rzpOrderId,
      required String rzpPaymentId,
      required String paymentStatus}) async {
    updatePaymentApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      CommonResModel response = await PaymentRepo().updatePaymentRepo(model: {
        "action": "update_payment",
        "rzp_order_id": rzpOrderId,
        "rzp_payment_id": rzpPaymentId,
        "payment_status": paymentStatus
      });
      updatePaymentApiResponse = ApiResponse.complete(response);
      log("updatePaymentApiResponse RES: $response");
    } catch (e) {
      log('updatePaymentApiResponse.....$e');
      updatePaymentApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// get otp for order
  Future<void> getOtpForOrderViewModel({required String mobileNo}) async {
    getOtpForOrderApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      OrderResendOtpResModel response = await OrderRepo().getOtpForOrderRepo(
          body: {"action": "send_otp", "mobile_number": mobileNo});
      getOtpForOrderApiResponse = ApiResponse.complete(response);
      log("getOtpForOrderApiResponse RES: $response");
    } catch (e) {
      log('getOtpForOrderApiResponse.....$e');
      getOtpForOrderApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
