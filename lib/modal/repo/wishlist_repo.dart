import 'dart:developer';

import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/wishlist_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

import '../apiModel/response_modal/get_resturent_list_res_model.dart';

class WishListRepo extends BaseService {
  /// wish list

  Future<dynamic> wishListRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: wishlist,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    WishlistResModel wishlistResModel = WishlistResModel.fromJson(response);
    return wishlistResModel;
  }

  /// get wish list
  Future<dynamic> getWishListRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: wishlist,
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
}
