import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/upload_profile_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/upload_profile_pic_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/uploadProfilePic_repo.dart';
import 'package:get/get.dart';

class UploadImageViewModel extends GetxController {
  ApiResponse uploadImageApiResponse = ApiResponse.initial('Initial');

  Future<void> uploadImage({required UploadProfilePicReqModel body}) async {
    uploadImageApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      UploadProfilePicResModel response =
          await ProfilePicRepo().profilePicRepo(body: body);
      uploadImageApiResponse = ApiResponse.complete(response);
      log("uploadImageApiResponse RES: $response");
    } catch (e) {
      log('uploadImageApiResponse.....$e');
      uploadImageApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
