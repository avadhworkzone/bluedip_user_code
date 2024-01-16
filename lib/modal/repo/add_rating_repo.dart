import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class AddRatingRepo extends BaseService {
  Future<dynamic> addRating({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
        apiType: APIType.aPost, url: addRatingUrl, body: body, withToken: true);
    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    CommonResModel ratingRes = CommonResModel.fromJson(response);
    return ratingRes;
  }
}
