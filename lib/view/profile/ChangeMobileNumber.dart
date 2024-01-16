import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/edit_mobile_no_res_model.dart';
import 'package:bluedip_user/utils/validation_utils.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/viewModel/user_detail_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/green_ticket_widget.dart';
import '../../Widget/home_rating_box_shadow.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../../modal/apis/api_response.dart';
import 'ChangeMobileNumberOtp.dart';
import '../order/RedeemOtpVerified.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';

class ChangeMobileNumber extends StatefulWidget {
  const ChangeMobileNumber({Key? key}) : super(key: key);

  @override
  State<ChangeMobileNumber> createState() => _ChangeMobileNumberState();
}

class _ChangeMobileNumberState extends State<ChangeMobileNumber> {
  final _mobilenumberController = TextEditingController();
  UserDetailViewModel userDetailViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: white_ffffff,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleShadow("Change Mobile Number"),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("New Mobile Number",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 6.h,
                      ),
                      loginTextformField("",
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _mobilenumberController,
                          obscureText: true, onChanged: (value) {
                        if (value.length == 10) {
                          FocusScope.of(context).unfocus();
                        }
                      }, regularExpression: RegularExpression.digitsPattern),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<UserDetailViewModel>(
                builder: (controller) {
                  if (controller.editMobileNumberApiResponse.status ==
                      Status.LOADING) {
                    return const CircularIndicator();
                  }
                  if (controller.editMobileNumberApiResponse.status ==
                      Status.ERROR) {
                    // return const ServerError();
                  }
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                    child: CommonRedButton("Send Otp".toUpperCase(), () async {
                      await userDetailViewModel.editMobileNumber(
                          mobileNo: _mobilenumberController.text);
                      EditMobileNumberResModel response =
                          controller.editMobileNumberApiResponse.data;

                      if (controller.editMobileNumberApiResponse.status ==
                          Status.COMPLETE) {
                        if (response.data?.status == true) {
                          Get.to(() => ChangeMobileNumberOtp(
                              otp: response.data!.otp!,
                              mobileNo: _mobilenumberController.text));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //            ChangeMobileNumberOtp(otp: response.data!.otp!,mobileNo: _mobilenumberController.text),
                          //     ));
                        } else {
                          snackBar(title: '${response.data!.message}');
                          // Get.snackbar('', '${response.data!.message}',
                          //     snackPosition: SnackPosition.BOTTOM,
                          //     colorText: Colors.white,
                          //     backgroundColor: blue_3d56f0);
                        }
                      }
                    }, red_dc3642),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
