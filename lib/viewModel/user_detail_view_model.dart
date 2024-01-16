import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/edit_user_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/edit_mobile_no_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_user_detail_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/add_rating_repo.dart';
import 'package:get/get.dart';
import '../modal/apiModel/response_modal/editMobile_resend_otp_res_model.dart';
import '../modal/apiModel/response_modal/editMobile_verify_otp_res_model.dart';
import '../modal/apiModel/response_modal/edit_user_res_model.dart';
import '../modal/repo/user_detail_repo.dart';

class UserDetailViewModel extends GetxController {
  ApiResponse userDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse editUserDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse editMobileNumberApiResponse = ApiResponse.initial('Initial');
  ApiResponse editMobileNoResendOtpApiResponse = ApiResponse.initial('Initial');
  ApiResponse editMobileNoVerifyOtpApiResponse = ApiResponse.initial('Initial');
  ApiResponse addRatingApiResponse = ApiResponse.initial('Initial');

  /// get user detail
  Future<void> getUserDetail() async {
    userDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      GetUserDetailResModel response = await UserDetailRepo()
          .getUserDetailRepo(body: {"action": "get_user"});
      userDetailApiResponse = ApiResponse.complete(response);
      log("userDetailApiResponse RES: $response");
    } catch (e) {
      log('userDetailApiResponse.....$e');
      userDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// edit user detail
  Future<void> editUserDetail({required EditUserReqModel body}) async {
    editUserDetailApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      EditUserResModel response =
          await UserDetailRepo().editUserDetailRepo(body: body);
      editUserDetailApiResponse = ApiResponse.complete(response);
      log("editUserDetailApiResponse RES: $response");
    } catch (e) {
      log('editUserDetailApiResponse.....$e');
      editUserDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// edit mobile number
  Future<void> editMobileNumber({String? mobileNo}) async {
    editMobileNumberApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      EditMobileNumberResModel response = await UserDetailRepo()
          .editMobileNumberRepo(body: {
        "action": "edit_mobile_number",
        "mobile_number": mobileNo
      });
      editMobileNumberApiResponse = ApiResponse.complete(response);
      log("editMobileNumberApiResponse RES: $response");
    } catch (e) {
      log('editMobileNumberApiResponse.....$e');
      editMobileNumberApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// resend otp
  Future<void> editMoResendOtpViewModel({String? mobileNumber}) async {
    editMobileNoResendOtpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      EditMobileResendOtpResModel response =
          await UserDetailRepo().editMobileNoResendOtpRepo({
        "action": "resend_otp",
        "type": "edit_mobile_number",
        "mobile_number": mobileNumber
      });
      editMobileNoResendOtpApiResponse = ApiResponse.complete(response);
      log("editMobileNoResendOtpApiResponse RES: $response");
    } catch (e) {
      log('editMobileNoResendOtpApiResponse.....$e');
      editMobileNoResendOtpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// verify otp
  Future<void> editMobileNoVerifyOtpViewModel(
      {String? mobileNumber, String? secretOtp}) async {
    editMobileNoVerifyOtpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      EditMobileVerifyOtpResModel response =
          await UserDetailRepo().editMobileNoVerifyOtpRepo({
        "action": "verify_otp",
        "type": "edit_mobile_number",
        "mobile_number": mobileNumber,
        "secret_otp": secretOtp
      });
      editMobileNoVerifyOtpApiResponse = ApiResponse.complete(response);
      log("editMobileNoVerifyOtpApiResponse RES: $response");
    } catch (e) {
      log('editMobileNoVerifyOtpApiResponse.....$e');
      editMobileNoVerifyOtpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// add rating
  Future<void> addRatingViewModel(
      {required String restoId,
      required String comment,
      required String rating,
      required String type}) async {
    addRatingApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CommonResModel response = await AddRatingRepo().addRating(body: {
        "action": "add_rating",
        "restaurant_id": restoId,
        "comment": comment,
        "rating": rating,
        "type": type
      });
      addRatingApiResponse = ApiResponse.complete(response);
      log("addRatingApiResponse RES: $response");
    } catch (e) {
      log('addRatingApiResponse.....$e');
      addRatingApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
