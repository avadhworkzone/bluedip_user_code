import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/get_user_location_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_city_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/user_location_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class GetCityRepo extends BaseService {
  /// get repo
  Future<dynamic> getCityRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: getCity,
      withToken: false,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    GetCityListResModel getCityListResModel =
        GetCityListResModel.fromJson(response);
    return getCityListResModel;
  }

  /// get user location
  Future<dynamic> getUserLocationRepo(
      {required UserLocationReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
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
    UserLocationResModel userLocationResModel =
        UserLocationResModel.fromJson(response);
    return userLocationResModel;
  }
}
