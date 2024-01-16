import 'dart:developer';
import 'package:bluedip_user/modal/apiModel/request_modal/add_post_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_post_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_detail_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/view_post_preview_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/modal/repo/foodbuddy_post_repo.dart';
import 'package:get/get.dart';
import '../modal/apiModel/response_modal/view_post_res_model.dart';

class FoodBuddyViewModel extends GetxController {
  ApiResponse addPostApiResponse = ApiResponse.initial('Initial');
  ApiResponse viewPostPreviewApiResponse = ApiResponse.initial('Initial');
  ApiResponse uploadPostApiResponse = ApiResponse.initial('Initial');
  ApiResponse viewPostApiResponse = ApiResponse.initial('Initial');
  ApiResponse viewPostDetailApiResponse = ApiResponse.initial('Initial');
  ApiResponse deletePostApiResponse = ApiResponse.initial('Initial');

  /// add post view model
  Future<void> addPostViewModel({required AddPostReqModel body}) async {
    addPostApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      AddPostResModel response = await FoodBuddyRepo().addPostRepo(model: body);
      addPostApiResponse = ApiResponse.complete(response);
      log("addPostApiResponse RES: $response");
    } catch (e) {
      log('addPostApiResponse.....$e');
      addPostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// view post preview
  Future<void> viewPostPreviewViewModel({required int postId}) async {
    viewPostPreviewApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      ViewPostPreviewResModel response = await FoodBuddyRepo()
          .viewPostPreviewRepo(
              body: {"action": "view_preview_post", "post_id": postId});
      viewPostPreviewApiResponse = ApiResponse.complete(response);
      log("viewPostPreviewApiResponse RES: $response");
    } catch (e) {
      log('viewPostPreviewApiResponse.....$e');
      viewPostPreviewApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// upload post view model
  Future<void> uploadPostViewModel({required int postId}) async {
    uploadPostApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      CommonResModel response = await FoodBuddyRepo()
          .uploadPostRepo(body: {"action": "upload_post", "post_id": postId});
      uploadPostApiResponse = ApiResponse.complete(response);
      log("uploadPostApiResponse RES: $response");
    } catch (e) {
      log('uploadPostApiResponse.....$e');
      uploadPostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// view post view model
  Future<void> viewPostViewModel() async {
    viewPostApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      ViewPostResModel response = await FoodBuddyRepo()
          .viewPostRepo(body: {"action": "view_post_list"});
      viewPostApiResponse = ApiResponse.complete(response);
      log("viewPostApiResponse RES: $response");
    } catch (e) {
      log('viewPostApiResponse.....$e');
      viewPostApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// view post detail model
  Future<void> viewPostDetailViewModel({required int postId}) async {
    viewPostDetailApiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      ViewPostDetailResModel response = await FoodBuddyRepo()
          .viewPostDetailRepo(
              body: {"action": "view_post_details", "post_id": postId});
      viewPostDetailApiResponse = ApiResponse.complete(response);
      log("viewPostDetailApiResponse RES: $response");
    } catch (e) {
      log('viewPostDetailApiResponse.....$e');
      viewPostDetailApiResponse = ApiResponse.error('error');
    }
    update();
  }

  /// delete post view model
  Future<void> deletePostViewModel({required int postId}) async {
    deletePostApiResponse = ApiResponse.loading('Loading');
    update();
    try {
      CommonResModel response = await FoodBuddyRepo()
          .deletePostRepo(body: {"action": "delete_post", "post_id": postId});
      deletePostApiResponse = ApiResponse.complete(response);
      log("addPostApiResponse RES: $response");
    } catch (e) {
      log('addPostApiResponse.....$e');
      deletePostApiResponse = ApiResponse.error('error');
    }
    update();
  }
}
