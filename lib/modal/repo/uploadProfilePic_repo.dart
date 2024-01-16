import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/upload_profile_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/upload_profile_pic_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class ProfilePicRepo extends BaseService {
  /// profile pic

  Future<dynamic> profilePicRepo(
      {required UploadProfilePicReqModel body}) async {
    Map<String, dynamic> model = body.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: uploadProfilePic,
      body: model,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    UploadProfilePicResModel uploadProfilePicResModel =
        UploadProfilePicResModel.fromJson(response);
    return uploadProfilePicResModel;
  }
}
