import 'dart:io';

import 'package:bluedip_user/Styles/my_strings.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/upload_profile_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/upload_profile_pic_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/profile/EditProfilePicture.dart';
import 'package:bluedip_user/viewModel/upload_image_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Styles/my_colors.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../../Widget/common_red_button.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  final CameraDescription cameras;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  UploadImageViewModel uploadImageViewModel = Get.find();
  UploadProfilePicReqModel uploadProfilePicReqModel =
      UploadProfilePicReqModel();

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras);
  }

  Future takePicture({String? profilePicPath}) async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    // if (_cameraController.value.isTakingPicture) {
    //   return null;
    // }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      print('picture click==${picture.path}');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProfilePicture(
                    picture: picture,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.low);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        (_cameraController.value.isInitialized)
            ? Stack(
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: CameraPreview(_cameraController)),
                  IgnorePointer(
                    child: ClipPath(
                      clipper: InvertedCircleClipper(),
                      child: Container(
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                  ToolbarWithTitleShadow("Profile Picture"),
                ],
              )
            : Container(
                color: Colors.black,
                child: const Center(child: CircularProgressIndicator())),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: GetBuilder<UploadImageViewModel>(
              builder: (controller) {
                if (uploadImageViewModel.uploadImageApiResponse.status ==
                    Status.LOADING) {
                  return const CircularIndicator();
                }

                if (uploadImageViewModel.uploadImageApiResponse.status ==
                    Status.ERROR) {
                  return const ServerError();
                }

                return CommonRedButton(strSave.toUpperCase(), () async {
                  if (!_cameraController.value.isInitialized) {
                    return null;
                  }

                  if (_cameraController.value.isTakingPicture) {
                    return null;
                  }

                  try {
                    await _cameraController.setFlashMode(FlashMode.off);
                    XFile picture = await _cameraController.takePicture();
                    print('picture===${picture.path.split('.').last}');
                    uploadProfilePicReqModel.folder = "images";
                    uploadProfilePicReqModel.fileName = "test";
                    uploadProfilePicReqModel.contentType =
                        "image/${picture.path.split('.').last}";
                    await uploadImageViewModel.uploadImage(
                        body: uploadProfilePicReqModel);

                    if (uploadImageViewModel.uploadImageApiResponse.status ==
                        Status.COMPLETE) {
                      UploadProfilePicResModel res =
                          uploadImageViewModel.uploadImageApiResponse.data;

                      var response = await http.put(
                        Uri.parse(res.uploadURL!),
                        headers: {
                          'Content-Type':
                              "image/${picture.path.split('.').last}",
                          'Accept': "*/*",
                          'Content-Length':
                              File(picture.path).lengthSync().toString(),
                          'Connection': 'keep-alive',
                        },
                        body: File(picture.path).readAsBytesSync(),
                      );
                      if (response.statusCode == 200) {
                        await PreferenceManagerUtils.setProfile(
                            'https://bluedip.s3.ap-south-1.amazonaws.com/${res.key}');

                        print('response put--${response.statusCode}');
                        Get.back();
                      }
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => EditProfilePicture(
                    //               picture: picture,
                    //             )));
                  } on CameraException catch (e) {
                    debugPrint('Error occurred while taking picture: $e');
                    return null;
                  }
                }, red_dc3642);
              },
            ),
          ),
        ),
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Container(
        //       height: MediaQuery.of(context).size.height * 0.20,
        //       decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        //           color: Colors.black),
        //       child:
        //       Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        //         Expanded(
        //             child: IconButton(
        //               padding: EdgeInsets.zero,
        //               iconSize: 30,
        //               icon: Icon(
        //                   _isRearCameraSelected
        //                       ? CupertinoIcons.switch_camera
        //                       : CupertinoIcons.switch_camera_solid,
        //                   color: Colors.white),
        //               onPressed: () {
        //                 setState(
        //                         () => _isRearCameraSelected = !_isRearCameraSelected);
        //                 initCamera(widget.cameras);
        //               },
        //             )),
        //         Expanded(
        //             child: IconButton(
        //               onPressed: takePicture,
        //               iconSize: 50,
        //               padding: EdgeInsets.zero,
        //               constraints: const BoxConstraints(),
        //               icon: const Icon(Icons.circle, color: Colors.white),
        //             )),
        //
        //         const Spacer(),
        //       ]),
        //     )),
      ]),
    ));
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return new Path()
      ..addOval(Rect.fromCircle(
          center: new Offset(size.width / 2, size.height / 3),
          radius: size.width * 0.35))
      ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
