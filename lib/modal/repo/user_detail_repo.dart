import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/edit_user_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/editMobile_verify_otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/edit_mobile_no_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/edit_user_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_user_detail_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

import '../apiModel/response_modal/editMobile_resend_otp_res_model.dart';

class UserDetailRepo extends BaseService {
  /// get user
  Future<dynamic> getUserDetailRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: getUserDetail,
      body: body,
      withToken: true,
    );
    log("=============RES:=========$response");
    if (response == null) {
      return null;
    }
    GetUserDetailResModel getUserDetailResModel =
        GetUserDetailResModel.fromJson(response);
    return getUserDetailResModel;
  }

  /// edit user
  Future<dynamic> editUserDetailRepo({required EditUserReqModel body}) async {
    Map<String, dynamic> model = body.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: getUserDetail,
      body: model,
      withToken: true,
    );
    log("=============RES:=========$response");
    if (response == null) {
      return null;
    }
    EditUserResModel editUserResModel = EditUserResModel.fromJson(response);
    return editUserResModel;
  }

  /// edit mobile number
  Future<dynamic> editMobileNumberRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: editMobileNumber,
      body: body,
      withToken: true,
    );
    log("=========RES:=========$response");
    if (response == null) {
      return null;
    }
    EditMobileNumberResModel editMobileNumberResModel =
        EditMobileNumberResModel.fromJson(response);
    return editMobileNumberResModel;
  }

  /// edit mobile number resend otp
  Future<dynamic> editMobileNoResendOtpRepo(Map<String, dynamic> body) async {
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
    EditMobileResendOtpResModel editMobileResendOtpResModel =
        EditMobileResendOtpResModel.fromJson(response);
    return editMobileResendOtpResModel;
  }

  /// edit mobile number verify otp
  Future<dynamic> editMobileNoVerifyOtpRepo(Map<String, dynamic> body) async {
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
    EditMobileVerifyOtpResModel editMobileVerifyOtpResModel =
        EditMobileVerifyOtpResModel.fromJson(response);
    return editMobileVerifyOtpResModel;
  }
}
