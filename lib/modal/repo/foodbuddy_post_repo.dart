import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/add_post_req_model.dart';
import 'package:bluedip_user/modal/services/api_service.dart';
import 'package:bluedip_user/modal/services/base_service.dart';
import 'package:bluedip_user/utils/enum_utils.dart';
import '../apiModel/response_modal/add_post_res_model.dart';
import '../apiModel/response_modal/common_res_model.dart';
import '../apiModel/response_modal/view_post_detail_res_model.dart';
import '../apiModel/response_modal/view_post_preview_res_model.dart';
import '../apiModel/response_modal/view_post_res_model.dart';

class FoodBuddyRepo extends BaseService {
  /// add post repo
  Future<dynamic> addPostRepo({required AddPostReqModel model}) async {
    Map<String, dynamic> body = model.toJson();
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    AddPostResModel addPostResModel = AddPostResModel.fromJson(response);
    return addPostResModel;
  }

  /// view post preview repo
  Future<dynamic> viewPostPreviewRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    ViewPostPreviewResModel viewPostPreviewResModel =
        ViewPostPreviewResModel.fromJson(response);
    return viewPostPreviewResModel;
  }

  /// upload post repo
  Future<dynamic> uploadPostRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    CommonResModel uploadPostResModel = CommonResModel.fromJson(response);
    return uploadPostResModel;
  }

  /// view post repo
  Future<dynamic> viewPostRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    ViewPostResModel viewPostResModel = ViewPostResModel.fromJson(response);
    return viewPostResModel;
  }

  /// view post detail
  Future<dynamic> viewPostDetailRepo(
      {required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    ViewPostDetailResModel viewPostDetailResModel =
        ViewPostDetailResModel.fromJson(response);
    return viewPostDetailResModel;
  }

  /// delete post repo
  Future<dynamic> deletePostRepo({required Map<String, dynamic> body}) async {
    var response = await ApiService().getResponse(
      apiType: APIType.aPost,
      url: foodBuddy,
      body: body,
      withToken: true,
    );

    log("=============RES:=========$response");

    if (response == null) {
      return null;
    }

    CommonResModel deletePostResModel = CommonResModel.fromJson(response);
    return deletePostResModel;
  }
}
