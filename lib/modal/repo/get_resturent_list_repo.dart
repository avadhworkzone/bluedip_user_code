import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/get_resturent_list_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_cuisine_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_resturent_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_user_location_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class GetRestaurantListRepo extends BaseService {
  /// get restaurant list

  Future<dynamic> getRestoListRepo(
      {required GetRestaurantListReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: getRestaurantList,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    GetRestaurantListResModel getRestaurantListResModel =
        GetRestaurantListResModel.fromJson(response);
    return getRestaurantListResModel;
  }

  /// get cuisine
  Future<dynamic> getCuisineRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: getCuisine,
      body: {},
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    GetCuisineResModel getCuisineResModel =
        GetCuisineResModel.fromJson(response);
    return getCuisineResModel;
  }

  /// get user location
  Future<dynamic> getUserLocationRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: getUserLocation,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    GetUserLocationResModel getUserLocationResModel =
        GetUserLocationResModel.fromJson(response);
    return getUserLocationResModel;
  }
}
