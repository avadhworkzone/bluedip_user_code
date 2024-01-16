import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/upload_profile_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/sign_up_details_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/upload_profile_pic_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/utils/validation_utils.dart';
import 'package:bluedip_user/view/select_location/SelecLocationList.dart';
import 'package:bluedip_user/viewModel/auth_view_model.dart';
import 'package:bluedip_user/viewModel/upload_image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/common_red_button.dart';
import '../../utils/enum_utils.dart';

class SignupDetailScreen extends StatefulWidget {
  const SignupDetailScreen({Key? key}) : super(key: key);

  @override
  State<SignupDetailScreen> createState() => _SignupDetailScreenState();
}

class _SignupDetailScreenState extends State<SignupDetailScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = Get.find();
  UploadProfilePicReqModel uploadProfilePicReqModel =
      UploadProfilePicReqModel();
  UploadImageViewModel uploadImageViewModel = Get.find();
  File? selectedImage;
  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: white_ffffff,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      img_status_bar,
                      width: double.infinity,
                      height: 80.h,
                      fit: BoxFit.fill,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 25.w, top: 45.h),
                    //   child: back_button(),
                    // ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Verify Mobile Number
                            Text(strDetails,
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontOverpassBold,
                                    fontSize: 28.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 20.h,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: const Color(0xFFE5E5E5),
                                child: selectedImage != null
                                    ? ClipOval(
                                        child: Image.file(
                                          selectedImage!,
                                          width: Get.width * 0.600,
                                          height: Get.height * 0.200,
                                          fit: BoxFit.fitWidth,
                                          // width: Get.width * 0.500,
                                        ),
                                      )
                                    : ClipOval(
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              // isOnTap = true;
                                            });
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Dialog(
                                                    insetPadding:
                                                        EdgeInsets.all(40.w),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  Get.height *
                                                                      0.05),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          const Text(
                                                            "Choose Profile photo",
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                ElevatedButton
                                                                    .icon(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        red_dc3642,
                                                                  ),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .image),
                                                                  onPressed:
                                                                      () {
                                                                    _openImagePicker();
                                                                  },
                                                                  label: const Text(
                                                                      "gallery"),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.05,
                                                                ),
                                                                ElevatedButton
                                                                    .icon(
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary:
                                                                          red_dc3642,
                                                                      alignment:
                                                                          Alignment
                                                                              .center),
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .camera),
                                                                  onPressed:
                                                                      () {
                                                                    _openCameraPicker();
                                                                  },
                                                                  label: const Text(
                                                                      "camera"),
                                                                ),
                                                              ])
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.white,
                                            size: Get.height * 0.05,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(strFullName,
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              height: 6.h,
                            ),
                            loginTextformField("",
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                controller: _nameController,
                                obscureText: true,
                                onChanged: (value) {},
                                regularExpression:
                                    RegularExpression.alphabetSpacePattern,
                                isValidate: true),

                            SizedBox(
                              height: 20.h,
                            ),

                            Text(strEmail,
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),

                            SizedBox(
                              height: 6.h,
                            ),
                            loginTextformField(
                              "",
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              controller: _emailController,
                              obscureText: true,
                              onChanged: (value) {},
                              regularExpression: RegularExpression.emailPattern,
                              validationType: ValidationType.Email,
                            ),
                            SizedBox(
                              height: 40.h,
                            ),

                            CommonRedButton(strContinue.toUpperCase(),
                                () async {
                              if (_formKey.currentState!.validate()) {
                                await authViewModel.signUpDetailsViewModel(
                                    action: "edit_user",
                                    emailId: _emailController.text,
                                    fullName: _nameController.text,
                                    image: PreferenceManagerUtils.getProfile());
                                GetSignUpDetailsResModel response =
                                    authViewModel
                                        .getSignUpDetailsApiResponse.data;

                                if (authViewModel
                                        .getSignUpDetailsApiResponse.status ==
                                    Status.COMPLETE) {
                                  if (response.status == true) {
                                    await PreferenceManagerUtils.setUserName(
                                        response.data!.fullName);
                                    Get.to(const SelecLocationList());
                                  } else {
                                    snackBar(title: '${response.message}');
                                    // Get.snackbar('', '${response.message}',
                                    //     snackPosition: SnackPosition.BOTTOM,
                                    //     colorText: Colors.white,
                                    //     backgroundColor: blue_3d56f0);
                                  }
                                }
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => const SelecLocationList(),
                                //     ));
                              }
                            }, red_dc3642),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GetBuilder<AuthViewModel>(
              builder: (authViewModel) {
                if (authViewModel.getSignUpDetailsApiResponse.status ==
                    Status.LOADING) {
                  return CircularIndicator();
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openImagePicker() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      print("=======_selectedImage========${selectedImage}");
      Get.back();
      setState(() {});
      uploadProfilePicReqModel.folder = "images";
      uploadProfilePicReqModel.fileName = "test";
      uploadProfilePicReqModel.contentType =
          "image/${pickedImage.path.split('.').last}";
      await uploadImageViewModel.uploadImage(body: uploadProfilePicReqModel);

      if (uploadImageViewModel.uploadImageApiResponse.status ==
          Status.COMPLETE) {
        UploadProfilePicResModel res =
            uploadImageViewModel.uploadImageApiResponse.data;

        var response = await http.put(
          Uri.parse(res.uploadURL!),
          headers: {
            'Content-Type': "image/${pickedImage.path.split('.').last}",
            'Accept': "*/*",
            'Content-Length': File(pickedImage.path).lengthSync().toString(),
            'Connection': 'keep-alive',
          },
          body: File(pickedImage.path).readAsBytesSync(),
        );
        if (response.statusCode == 200) {
          await PreferenceManagerUtils.setProfile(
              'https://bluedip.s3.ap-south-1.amazonaws.com/${res.key}');

          print('response put--${response.statusCode}');
          Get.back();
        }
      }
      // await uploadImage(file: selectedImage!);
    }
  }

  Future<void> _openCameraPicker() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
      source: ImageSource.camera,
    );
    if (pickedImage != null) {
      selectedImage = File(pickedImage.path);
      print("=======_selectedImage========${selectedImage}");
      Get.back();
      setState(() {});
      uploadProfilePicReqModel.folder = "images";
      uploadProfilePicReqModel.fileName = "test";
      uploadProfilePicReqModel.contentType =
          "image/${pickedImage.path.split('.').last}";
      await uploadImageViewModel.uploadImage(body: uploadProfilePicReqModel);

      if (uploadImageViewModel.uploadImageApiResponse.status ==
          Status.COMPLETE) {
        UploadProfilePicResModel res =
            uploadImageViewModel.uploadImageApiResponse.data;

        var response = await http.put(
          Uri.parse(res.uploadURL!),
          headers: {
            'Content-Type': "image/${pickedImage.path.split('.').last}",
            'Accept': "*/*",
            'Content-Length': File(pickedImage.path).lengthSync().toString(),
            'Connection': 'keep-alive',
          },
          body: File(pickedImage.path).readAsBytesSync(),
        );
        if (response.statusCode == 200) {
          await PreferenceManagerUtils.setProfile(
              'https://bluedip.s3.ap-south-1.amazonaws.com/${res.key}');

          print('response put--${response.statusCode}');
          Get.back();
        }
      }
      // await uploadImage(file: selectedImage!);
    }
  }
}
