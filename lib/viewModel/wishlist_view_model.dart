import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/wishlist_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/order_repo.dart';
import 'package:bluedip_user/modal/repo/wishlist_repo.dart';
import 'package:get/get.dart';

import '../modal/apiModel/response_modal/get_resturent_list_res_model.dart';

class WishListViewModel extends GetxController {
  ApiResponse wishListApiResponse = ApiResponse.initial('Initial');
  ApiResponse getWishListApiResponse = ApiResponse.initial('Initial');

  Map<String, Map> wishListLocalData = {};

  Future<void> wishList({String? action, String? restaurantId}) async {
    wishListApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      WishlistResModel response = await WishListRepo().wishListRepo(
          body: {"action": action, "restaurant_id": restaurantId});
      wishListApiResponse = ApiResponse.complete(response);
      log("wishListApiResponse RES: $response");
    } catch (e) {
      log('wishListApiResponse.....$e');
      wishListApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// get wish list
  Future<void> getWishList() async {
    getWishListApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetRestaurantListResModel response = await WishListRepo()
          .getWishListRepo(body: {"action": "get_favourite"});
      getWishListApiResponse = ApiResponse.complete(response);
      log("getWishListApiResponse RES: $response");
    } catch (e) {
      log('getWishListApiResponse.....$e');
      getWishListApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
