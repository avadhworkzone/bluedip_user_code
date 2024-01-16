import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/signUp_SignIn_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';
import '../apiModel/response_modal/sign_up_details_res_model.dart';

class AuthRepo extends BaseService {
  /// sign up or sign in  repo
  Future<dynamic> signUpSignInRepo(Map<String, dynamic> body) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: signInSignUp,
      body: body,
      withToken: false,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    SignUpSignInResModel signUpSignInResModel =
        SignUpSignInResModel.fromJson(response);
    return signUpSignInResModel;
  }

  /// otp  repo
  Future<dynamic> otpRepo(Map<String, dynamic> body) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: otp,
      body: body,
      withToken: false,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    VerifyOtpResModel otpResModel = VerifyOtpResModel.fromJson(response);
    return otpResModel;
  }

  /// resend otp
  Future<dynamic> resendOtpRepo(Map<String, dynamic> body) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: otp,
      body: body,
      withToken: false,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }
    ResendOtpResModel resendOtpResModel = ResendOtpResModel.fromJson(response);
    return resendOtpResModel;
  }

  /// sign up details repo
  Future<dynamic> signUpDetailsRepo(Map<String, dynamic> body) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: signUpDetails,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    GetSignUpDetailsResModel getSignUpDetailsResModel =
        GetSignUpDetailsResModel.fromJson(response);
    return getSignUpDetailsResModel;
  }

  /// Delete Account repo
  Future<dynamic> deleteAccountRepo(Map<String, dynamic> body) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: signUpDetails,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");
    if (response == null) {
      return null;
    }
    CommonResModel commonResModel = CommonResModel.fromJson(response);
    return commonResModel;
  }
}
