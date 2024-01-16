import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/signUp_SignIn_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/sign_up_details_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/auth_repo.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  ApiResponse authApiResponse = ApiResponse.initial('Initial');
  ApiResponse otpApiResponse = ApiResponse.initial('Initial');
  ApiResponse resendOtpApiResponse = ApiResponse.initial('Initial');
  ApiResponse getSignUpDetailsApiResponse = ApiResponse.initial('Initial');
  ApiResponse deleteUserApiResponse = ApiResponse.initial('Initial');

  ///  sign up sign in view model

  Future<void> signUpSignInViewModel(
      {String? mobileNumber, String? type}) async {
    authApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      SignUpSignInResModel response = await AuthRepo()
          .signUpSignInRepo({"mobile_number": mobileNumber, "type": type});
      authApiResponse = ApiResponse.complete(response);
      log("authApiResponse RES: $response");
    } catch (e) {
      log('authApiResponse.....$e');
      authApiResponse = ApiResponse.error('error');
    }
    update();
  }

  ///  otp view model

  Future<void> otpViewModel(
      {String? action,
      String? type,
      String? mobileNumber,
      String? secretOtp}) async {
    otpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      VerifyOtpResModel response = await AuthRepo().otpRepo({
        "action": action,
        "type": type,
        "mobile_number": mobileNumber,
        "secret_otp": secretOtp
      });
      otpApiResponse = ApiResponse.complete(response);
      log("otpApiResponse RES: $response");
    } catch (e) {
      log('otpApiResponse.....$e');
      otpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// resend otp
  Future<void> resendOtpViewModel(
      {String? action, String? type, String? mobileNumber}) async {
    resendOtpApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      ResendOtpResModel response = await AuthRepo().resendOtpRepo(
          {"action": action, "type": type, "mobile_number": mobileNumber});
      resendOtpApiResponse = ApiResponse.complete(response);
      log("resendOtpApiResponse RES: $response");
    } catch (e) {
      log('resendOtpApiResponse.....$e');
      resendOtpApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// sign up details view model
  Future<void> signUpDetailsViewModel(
      {String? action,
      String? emailId,
      String? fullName,
      String? image}) async {
    getSignUpDetailsApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      GetSignUpDetailsResModel response = await AuthRepo().signUpDetailsRepo({
        "action": action,
        "email_id": emailId,
        "full_name": fullName,
        "user_img": image
      });
      getSignUpDetailsApiResponse = ApiResponse.complete(response);
      log("getSignUpDetailsApiResponse RES: $response");
    } catch (e) {
      log('getSignUpDetailsApiResponse.....$e');
      getSignUpDetailsApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// delete account
  /// resend otp
  Future<void> deleteUserViewModel() async {
    deleteUserApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CommonResModel response =
          await AuthRepo().deleteAccountRepo({"action": "delete_user"});
      deleteUserApiResponse = ApiResponse.complete(response);
      log("deleteUserApiResponse RES: $response");
    } catch (e) {
      log('deleteUserApiResponse.....$e');
      deleteUserApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
