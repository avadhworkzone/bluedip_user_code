import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_info_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_data_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resto_details_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/order_repo.dart';
import 'package:bluedip_user/modal/repo/resto_details_repo.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:get/get.dart';

import '../modal/apiModel/response_modal/offer_detail_res_model.dart';

class RestoDetailViewModel extends GetxController {
  ApiResponse restoDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse offerDataApiResponse = ApiResponse.initial('Initial');
  ApiResponse offerDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse getOrderInfoApiResponse = ApiResponse.initial('Initial');

  /// resto detail
  Future<void> restoDetails({required String restoId}) async {
    restoDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      RestaurantDetailsResModel response =
          await RestaurantDetailsRepo().restoDetailsRepo(body: {
        "action": "get_restaurant_details",
        "restaurant_id": restoId,
        "lang": PreferenceManagerUtils.getLongitude(),
        "lat": PreferenceManagerUtils.getLatitude(),
      });
      restoDetailApiResponse = ApiResponse.complete(response);
      log("restoDetailApiResponse RES: $response");
    } catch (e) {
      log('restoDetailApiResponse.....$e');
      restoDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// offer data
  Future<void> offerDataViewModel({required String restoId}) async {
    offerDataApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      OfferDataResModel response =
          await RestaurantDetailsRepo().offerDataRepo(body: {
        "action": "get_offer_details",
        "restaurant_id": restoId,
      });
      offerDataApiResponse = ApiResponse.complete(response);
      log("offerDataApiResponse RES: $response");
    } catch (e) {
      log('offerDataApiResponse.....$e');
      offerDataApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// offer detail view model
  Future<void> offerDetailViewModel({required String offerId}) async {
    offerDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      OfferDetailsResModel response =
          await RestaurantDetailsRepo().offerDetailRepo(body: {
        "action": "get_order_details",
        "offer_id": offerId.toString(),
      });
      offerDetailApiResponse = ApiResponse.complete(response);
      log("offerDetailApiResponse RES: $response");
    } catch (e) {
      log('offerDetailApiResponse.....$e');
      offerDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// get order info
  Future<void> getOrderInfoViewModel({required String orderId}) async {
    getOrderInfoApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetOrderInfoResModel response = await OrderRepo().getOrderInfoRepo(body: {
        "action": "get_order",
        "restaurant_id": PreferenceManagerUtils.getRestoId(),
        "order_id": orderId.toString()
      });
      getOrderInfoApiResponse = ApiResponse.complete(response);
      log("getOrderInfoApiResponse RES: $response");
    } catch (e) {
      log('getOrderInfoApiResponse.....$e');
      getOrderInfoApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
