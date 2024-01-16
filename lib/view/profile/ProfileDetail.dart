import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/edit_user_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/edit_user_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_user_detail_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/utils/validation_utils.dart';
import 'package:bluedip_user/viewModel/user_detail_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/toolbar_with_title_edit.dart';
import '../../utils/enum_utils.dart';
import 'CameraPage.dart';
import 'ChangeMobileNumber.dart';
import 'EditProfilePicture.dart';
import '../../Widget/common_red_button.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final _RestaurantNameController = TextEditingController();
  final mobileNumberController = TextEditingController();

  UserDetailViewModel userDetailViewModel = Get.find();
  EditUserReqModel editUserReqModel = EditUserReqModel();

  bool isEdit = false;
  // bool isBottomButton = false;
  // bool isEditLayout = true;
  GetUserDetailResModel? response;

  getUserDetailApi() async {
    await userDetailViewModel.getUserDetail();
    if (userDetailViewModel.userDetailApiResponse.status == Status.COMPLETE) {
      response = userDetailViewModel.userDetailApiResponse.data;
      fullNameController.text = response!.data!.fullName!;
      emailController.text = response!.data!.emailId!;
      mobileNumberController.text = response!.data!.mobileNumber!;
      await PreferenceManagerUtils.setProfile(
          "${response!.data!.userImg ?? ""}");
    }
  }

  @override
  void initState() {
    getUserDetailApi();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: GetBuilder<UserDetailViewModel>(
        builder: (controller) {
          if (controller.userDetailApiResponse.status == Status.LOADING) {
            return const CircularIndicator();
          }
          if (controller.userDetailApiResponse.status == Status.ERROR) {
            return const ServerError();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: white_ffffff,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1017191a),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5),
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                              width: 40.w,
                              height: 40.w,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SvgPicture.asset(icon_arrow_left),
                              ))),
                      SizedBox(
                        width: 20.w,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              fontFamily: fontOverpassBold,
                              color: black_504f58,
                              fontSize: 20.sp),
                        ),
                      ),
                      isEdit == true
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEdit = true;
                                  // isEditIcon = true;
                                  // isBottomButton = true;
                                  // isEditLayout = false;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 17.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  border:
                                      Border.all(color: blue_007add, width: 1),
                                ),
                                child: Text("EDIT",
                                    style: TextStyle(
                                        color: blue_007add,
                                        fontFamily: fontMavenProMedium,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.left),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SizedBox(
                                // width: 128.w,
                                // height: 128.h,
                                child: PreferenceManagerUtils.getProfile() == ""
                                    ? const CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                          'assets/images/bluedip_app_icon_second.png',
                                        ))
                                    : CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            PreferenceManagerUtils
                                                .getProfile()),

                                        // Image.asset(
                                        //   img_girl,
                                        //   width: 128.w,
                                        //   height: 128.h,
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                              ),
                              isEdit == true
                                  ? GestureDetector(
                                      onTap: () async {
                                        final cameras =
                                            await availableCameras();
                                        final firstCamera = cameras[1];
                                        await Get.to(CameraPage(
                                                cameras: firstCamera))
                                            ?.then((value) => setState(() {}));
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           CameraPage(cameras: firstCamera),
                                        //     ));
                                      },
                                      child:
                                          SvgPicture.asset(icon_edit_pen_write))
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(str_first_name,
                            style: TextStyle(
                                color: black_504f58,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: fontMavenProRegular),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 6.h,
                        ),
                        loginTextformField("",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: fullNameController,
                            obscureText: true,
                            readOnly: isEdit == true ? false : true,
                            onChanged: (value) {},
                            regularExpression:
                                RegularExpression.alphabetSpacePattern,
                            focusBorderColor: isEdit == true
                                ? red_dc3642
                                : Colors.transparent),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(str_Email,
                            style: TextStyle(
                                color: black_504f58,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: fontMavenProRegular),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 6.h,
                        ),
                        loginTextformField("",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            //  controller:_emailController,
                            controller: emailController,
                            obscureText: true,
                            readOnly: isEdit == true ? false : true,
                            onChanged: (value) {},
                            regularExpression: RegularExpression.emailPattern,
                            validationType: ValidationType.Email,
                            focusBorderColor: isEdit == true
                                ? red_dc3642
                                : Colors.transparent),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Mobile",
                            style: TextStyle(
                                color: black_504f58,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: fontMavenProRegular),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 6.h,
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            loginTextformField("",
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                // controller:_ContactNumController,
                                controller: mobileNumberController,
                                readOnly: isEdit == true ? false : true,
                                obscureText: true,
                                onChanged: (value) {},
                                inputLength: 10,
                                regularExpression:
                                    RegularExpression.digitsPattern,
                                focusBorderColor: isEdit == true
                                    ? red_dc3642
                                    : Colors.transparent),
                            // Change
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ChangeMobileNumber(),
                                    ));
                              },
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 16.h, right: 16.w),
                                child: Text("Change",
                                    style: TextStyle(
                                        color: blue_007add,
                                        fontFamily: fontMavenProMedium,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              isEdit == true
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 30.h),
                        child: GetBuilder<UserDetailViewModel>(
                          builder: (controller) {
                            if (controller.editUserDetailApiResponse.status ==
                                Status.LOADING) {
                              return const CircularIndicator();
                            }
                            if (controller.editUserDetailApiResponse.status ==
                                Status.ERROR) {
                              // return const ServerError();
                            }

                            return CommonRedButton(strSave.toUpperCase(),
                                () async {
                              editUserReqModel.action = "edit_user";
                              editUserReqModel.userImg =
                                  PreferenceManagerUtils.getProfile();
                              editUserReqModel.fullName =
                                  fullNameController.text;
                              editUserReqModel.emailId = emailController.text;

                              await userDetailViewModel.editUserDetail(
                                  body: editUserReqModel);
                              EditUserResModel res =
                                  controller.editUserDetailApiResponse.data;
                              if (controller.editUserDetailApiResponse.status ==
                                  Status.COMPLETE) {
                                if (res.status == true) {
                                  await PreferenceManagerUtils.setUserName(
                                      fullNameController.text);
                                  Get.back();
                                } else {
                                  snackBar(title: '${res.message}');
                                }
                              }

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const SelecLocationList(),
                              //     ));
                            }, red_dc3642);
                          },
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          );
        },
      ),
    ));
  }
}
