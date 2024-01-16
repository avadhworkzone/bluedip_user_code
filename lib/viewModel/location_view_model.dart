import 'dart:developer';

import 'package:bluedip_user/modal/apiModel/request_modal/get_user_location_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_city_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/user_location_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/get_city_repo.dart';
import 'package:get/get.dart';

import '../modal/apiModel/response_modal/get_user_location_res_model.dart';
import '../modal/repo/get_resturent_list_repo.dart';

class GetCityViewModel extends GetxController {
  ApiResponse getCityApiResponse = ApiResponse.initial('Initial');
  ApiResponse getUserLocationApiResponse = ApiResponse.initial('Initial');
  ApiResponse userLocationApiResponse = ApiResponse.initial('Initial');

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> getCityList() async {
    getCityApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetCityListResModel response = await GetCityRepo().getCityRepo();
      getCityApiResponse = ApiResponse.complete(response);
      log("getCityApiResponse RES: $response");
    } catch (e) {
      log('getCityApiResponse.....$e');
      getCityApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// get user location
  Future<void> userLocation({required UserLocationReqModel body}) async {
    getUserLocationApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      UserLocationResModel response =
          await GetCityRepo().getUserLocationRepo(model: body);
      getUserLocationApiResponse = ApiResponse.complete(response);
      log("getUserLocationApiResponse RES: $response");
    } catch (e) {
      log('getUserLocationApiResponse.....$e');
      getUserLocationApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// fetch user location
  Future<void> fetchUserLocation() async {
    userLocationApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetUserLocationResModel response = await GetRestaurantListRepo()
          .getUserLocationRepo(body: {"action": "get_user_location"});
      userLocationApiResponse = ApiResponse.complete(response);
      log("userLocationApiResponse RES: $response");
    } catch (e) {
      log('userLocationApiResponse.....$e');
      userLocationApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
