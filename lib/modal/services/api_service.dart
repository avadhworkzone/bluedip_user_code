import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:js';

import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/auth/WelcomeScreen.dart';
import 'package:bluedip_user/view/splash/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../../utils/enum_utils.dart';
import '../apis/api_exception.dart';
import 'base_service.dart';

class ApiService extends BaseService {
  var response;
  // final dio.Dio _dio = dio.Dio();
  // Future uploadImage({required File file}) async {
  //   var response;
  //   try {
  //     String fileName = file.path.split('/').last;
  //     log("FILE NAME $fileName");
  //     log("FILE NAME PATH ${file.path}");
  //     dio.FormData formData = dio.FormData.fromMap({
  //       "file": await dio.MultipartFile.fromFile(file.path
  //           // filename: fileName,
  //           // contentType: MediaType("image", 'jpg'),
  //           ),
  //     });
  //
  //     response =
  //         await _dio.post('https://test.zooscores.in/api/misc/upload-file',
  //             data: formData,
  //             options: dio.Options(
  //               headers: {
  //                 'Content-Type': 'application/json',
  //                 'key': 'therapistImage'
  //               },
  //             ));
  //     log('response$response');
  //     // response = returnResponse(response.statusCode!, jsonEncode(response.data));
  //     return response;
  //   } on DioError catch (e) {
  //     return e;
  //   }
  // }

  Map<String, String> header({APIHeaderType? status}) {
    String token = PreferenceManagerUtils.getToken();

    ///PreferenceManagerUtils.getToken();

    if (status == APIHeaderType.fileUploadWithToken) {
      return {'Content-Type': "form-data", "Authorization": 'Bearer $token'};
    } else if (status == APIHeaderType.fileUploadWithoutToken) {
      return {
        'Content-Type': "form-data",
      };
    } else if (status == APIHeaderType.jsonBodyWithToken) {
      return {
        'Content-Type': 'application/json',
        "Authorization": 'Bearer $token'
      };
    } else if (status == APIHeaderType.onlyToken) {
      return {"Authorization": 'Bearer $token'};
    } else {
      return {
        'Content-Type': 'application/json',
      };
    }
  }

  Future<dynamic> getResponse(
      {required APIType? apiType,
      required String? url,
      Map<String, dynamic>? body,
      bool withToken = true,
      bool fileUpload = false}) async {
    log('URL : ${baseUrl + url!}');
    String uri = baseUrl + url;
    print("REQUEST FOR API ${jsonEncode(body)}");
    print("token ------------${PreferenceManagerUtils.getToken()}");
    try {
      if (apiType == APIType.aGet) {
        var result = await http.get(Uri.parse(uri),
            headers: header(
              status: withToken
                  ? APIHeaderType.jsonBodyWithToken
                  : APIHeaderType.jsonBodyWithoutToken,
            ));
        // AnalyticsService.sendEvent(url, jsonDecode(result.body));
        response = returnResponse(
          result.statusCode,
          result.body,
        );

        // log("Result==================${result.body}");
      } else if (apiType == APIType.aPost) {
        var result = await http.post(
          Uri.parse(uri),
          body: jsonEncode(body),
          headers: header(
            status: withToken
                ? APIHeaderType.jsonBodyWithToken
                : APIHeaderType.jsonBodyWithoutToken,
          ),
        );
        // AnalyticsService.sendEvent(url, jsonDecode(result.body));
        response = returnResponse(
          result.statusCode,
          result.body,
        );

        // log("Result==================${result.body}");
        // log("response==================${response}");
      } else if (apiType == APIType.aPut) {
        var result = await http.put(
          Uri.parse(uri),
          body: jsonEncode(body),
          headers: header(),
        );
        // AnalyticsService.sendEvent(url, jsonDecode(result.body));
        response = returnResponse(
          result.statusCode,
          result.body,
        );

        // log("Result==================${result.body}");
      } else if (apiType == APIType.aDelete) {
        var result = await http.delete(Uri.parse(uri));
        // AnalyticsService.sendEvent(url, jsonDecode(result.body));
        response = returnResponse(
          result.statusCode,
          result.body,
        );

        // log("Result==================${result.body}");
      }
      return response;
    } catch (e) {
      log('Error=>.. $e');
    }
  }

  returnResponse(int status, String result) {
    print('status$status');
    if (status == 401) {
      PreferenceManagerUtils.clearPreference();
      Get.to(const SplashScreen());
    } else {
      return jsonDecode(result);
    }
    // if (status >= 200 && status <= 299) {

    // } else {
    //   throw ServerException('Server Error');
    // }
    // switch (status) {
    //   case 200:
    //     return jsonDecode(result);
    //   case 256:
    //     return jsonDecode(result);
    //   case 422:
    //     return jsonDecode(result);
    //   case 400:
    //     throw BadRequestException('Bad Request');
    //   case 401:
    //     throw UnauthorisedException('Unauthorised user');
    //   case 404:
    //     throw ServerException('Server Error');
    //   case 503:
    //     throw ServerException('Server Error');
    //   case 499:
    //     throw ServerException('Server Error');
    //   case 501:
    //     throw ServerException('Server Error');
    //   case 505:
    //     throw ServerException('Server Error');
    //   case 504:
    //     throw ServerException('Server Error');
    //   case 500:
    //     throw ServerException('Server Error');
    //   default:
    //     return jsonDecode(result);
    // }
  }
}
