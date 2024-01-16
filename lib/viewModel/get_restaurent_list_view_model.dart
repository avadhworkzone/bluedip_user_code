import 'dart:convert';
import 'dart:developer';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/get_resturent_list_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_cuisine_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_resturent_list_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/get_resturent_list_repo.dart';
import 'package:bluedip_user/modal/repo/order_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetRestaurantListViewModel extends GetxController {
  ApiResponse getRestaurantApiResponse = ApiResponse.initial('Initial');
  ApiResponse getCuisineApiResponse = ApiResponse.initial('Initial');
  ApiResponse getOrderListApiResponse = ApiResponse.initial('Initial');
  GetRestaurantListResModel? response;

  List<restoData> restaurantListData = [];
  Map restaurantResponse = {};
  int pageNumber = 1;

  clearResponse() {
    restaurantListData.clear();
    pageNumber = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  bool _isPageLoadAll = false;
  bool get isPageLoadAll => _isPageLoadAll;
  set isPageLoadAll(bool value) {
    _isPageLoadAll = value;
    update();
  }

  bool _isMore = false;

  bool get isMore => _isMore;

  set isMore(bool value) {
    _isMore = value;
    update();
  }

  /// get restaurant list
  Future<void> restaurantList({required GetRestaurantListReqModel body}) async {
    if (pageNumber == 1) {
      restaurantListData.clear();
      getRestaurantApiResponse = ApiResponse.loading('Loading');
    } else {
      isPageLoadAll = true;
      update();
    }
    try {
      response = await GetRestaurantListRepo().getRestoListRepo(model: body);
      getRestaurantApiResponse = ApiResponse.complete(response);
      if (response!.data!.restaurantList == null) {
        restaurantListData = [];
      } else {
        restaurantListData.addAll(response!.data!.restaurantList!);
      }

      // isLoader = false;
    } catch (e) {
      // if (response!.status == false) {
      //   snackBar(title: 'error');
      // }
      log('getRestaurantApiResponse-.....$e');
      getRestaurantApiResponse = ApiResponse.error('error');
    }
    _isPageLoadAll = false;
    update();
  }

  /// get cuisine
  Future<void> getCuisineViewModel() async {
    getCuisineApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetCuisineResModel response =
          await GetRestaurantListRepo().getCuisineRepo();
      getCuisineApiResponse = ApiResponse.complete(response);

      log("getCuisineApiResponse RES: $response");
    } catch (e) {
      log('getCuisineApiResponse.....$e');
      getCuisineApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// order list
  Future<void> getOrderList() async {
    getOrderListApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetOrderListResModel response = await OrderRepo()
          .getOrderListRepo(body: {"action": "view_order_list"});
      getOrderListApiResponse = ApiResponse.complete(response);
      log("getOrderListApiResponse RES: $response");
    } catch (e) {
      log('getOrderListApiResponse.....$e');
      getOrderListApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
