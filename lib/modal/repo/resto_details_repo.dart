import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_data_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_detail_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resto_details_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class RestaurantDetailsRepo extends BaseService {
  /// resto detail repo
  Future<dynamic> restoDetailsRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: restaurantDetails,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    RestaurantDetailsResModel restaurantDetailsResModel =
        RestaurantDetailsResModel.fromJson(response);
    return restaurantDetailsResModel;
  }

  /// offer data
  Future<dynamic> offerDataRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: restaurantDetails,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    OfferDataResModel offerDataResModel = OfferDataResModel.fromJson(response);
    return offerDataResModel;
  }

  /// offer detail repo
  Future<dynamic> offerDetailRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: offerDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    OfferDetailsResModel offerDetailsResModel =
        OfferDetailsResModel.fromJson(response);
    return offerDetailsResModel;
  }
}
