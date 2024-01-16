import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/add_payment_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_payment_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';

class PaymentRepo extends BaseService {
  /// add payment
  Future<dynamic> paymentRepo({required AddPaymentReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addPayment,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    AddPaymentResModel addPaymentResModel =
        AddPaymentResModel.fromJson(response);
    return addPaymentResModel;
  }

  /// update payment
  Future<dynamic> updatePaymentRepo(
      {required Map<String, dynamic> model}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: addPayment,
      body: model,
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
