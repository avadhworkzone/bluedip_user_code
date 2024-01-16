import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
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
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/green_ticket_widget.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../../modal/apiModel/response_modal/editMobile_resend_otp_res_model.dart';
import '../../modal/apiModel/response_modal/editMobile_verify_otp_res_model.dart';
import '../../modal/apis/api_response.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';

class ChangeMobileNumberOtp extends StatefulWidget {
  ChangeMobileNumberOtp({Key? key, required this.otp, required this.mobileNo})
      : super(key: key);
  int otp;
  String mobileNo;

  @override
  State<ChangeMobileNumberOtp> createState() => _ChangeMobileNumberOtpState();
}

class _ChangeMobileNumberOtpState extends State<ChangeMobileNumberOtp> {
  bool isDataFill = false;
  final pinController = TextEditingController();
  UserDetailViewModel userDetailViewModel = Get.find();
  final _formKey = GlobalKey<FormState>();
  bool _isRunning = false;

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 30;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(1, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(1, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    _startTimer();
    super.initState();
  }

  Timer? _timer;
  int _remainingTime = 30;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isRunning = false;
        }
      });
    });
    _isRunning = true;
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _isRunning = false;
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

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
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolbarWithTitleShadow("Change Mobile Number"),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 4 digit verification code sent on +91 9876434322 Edit
                          Text(strVerifyMobileNumber,
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontOverpassBold,
                                  fontSize: 28.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "4 digit verification code sent on",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProRegular,
                                fontSize: 15.sp),
                          ),
                          Row(
                            children: [
                              Text(
                                "+91 ${widget.mobileNo} ",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: red_dc3642,
                                      fontFamily: fontMavenProRegular,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.sp,
                                      height: 1.5),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text('Your Otp is: ${widget.otp}',
                              style: TextStyle(
                                  color: black_504f58,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: fontMavenProRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 24.h,
                          ),
                          Theme(
                            data: ThemeData(
                              primaryColor: Colors.black,
                              primaryColorDark: Colors.black,
                              focusColor: Colors.black,
                              textSelectionTheme: const TextSelectionThemeData(
                                cursorColor: Colors.black, //thereby
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: PinCodeTextField(
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontMavenProBold,
                                    fontSize: 24.sp),
                                length: 6,
                                controller: pinController,
                                obscureText: false,
                                obscuringCharacter: '*',
                                obscuringWidget: null,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                enablePinAutofill: true,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(15.r),
                                    fieldHeight: 54,
                                    fieldWidth: 54,
                                    borderWidth: 1,
                                    activeFillColor: Colors.white,
                                    inactiveColor: grey_d9dde3,
                                    inactiveFillColor: Colors.white,
                                    errorBorderColor: Colors.red,
                                    activeColor: red_dc3642,
                                    selectedColor: red_dc3642,
                                    selectedFillColor: Colors.white),
                                cursorColor: red_dc3642,
                                cursorWidth: 2,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                keyboardType: TextInputType.number,
                                onCompleted: (v) {
                                  print("Completed");
                                  setState(() {
                                    isDataFill = true;
                                  });
                                },
                                onChanged: (value) {
                                  print(value);
                                  if (value.length == 6) {
                                    setState(() {
                                      isDataFill = true;
                                    });
                                  } else {
                                    setState(() {
                                      isDataFill = false;
                                    });
                                  }
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: currentSeconds != 30
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // You can resend OTP in
                            Text("You can resend OTP in",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 15.sp),
                                textAlign: TextAlign.left),
                            SizedBox(
                              width: 7.w,
                            ),
                            Text(
                              timerText,
                              style: TextStyle(
                                  color: red_dc3642,
                                  fontFamily: fontMavenProRegular,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.sp),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () async {
                            await userDetailViewModel.editMoResendOtpViewModel(
                                mobileNumber: widget.mobileNo);
                            EditMobileResendOtpResModel response =
                                userDetailViewModel
                                    .editMobileNoResendOtpApiResponse.data;

                            if (userDetailViewModel
                                    .editMobileNoResendOtpApiResponse.status ==
                                Status.COMPLETE) {
                              if (response.status == false) {
                                snackBar(title: '${response.message}');
                                // Get.snackbar('', '${response.message}',
                                //     snackPosition: SnackPosition.BOTTOM,
                                //     colorText: Colors.white,
                                //     backgroundColor: blue_3d56f0);
                              } else {
                                widget.otp = int.parse(response.otp.toString());
                                startTimeout();
                                _startTimer();
                              }
                            }
                          },
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                                color: red_dc3642,
                                fontFamily: fontMavenProRegular,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonVerifyRedButton(strVerify.toUpperCase(),
                      () async {
                    if (_formKey.currentState!.validate()) {
                      await userDetailViewModel.editMobileNoVerifyOtpViewModel(
                          mobileNumber: widget.mobileNo,
                          secretOtp: pinController.text);
                      EditMobileVerifyOtpResModel response = userDetailViewModel
                          .editMobileNoVerifyOtpApiResponse.data;
                      if (userDetailViewModel
                              .editMobileNoVerifyOtpApiResponse.status ==
                          Status.COMPLETE) {
                        if (response.status == true) {
                          Get.offAll(const BottomNavigationScreen());
                        } else {
                          snackBar(title: '${response.message}');
                        }
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SignupDetailScreen(),
                      //     ));
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const RedeemExpandOrder(),
                    //     ));
                  }, isDataFill == true ? red_dc3642 : divider_d4dce7,
                      isDataFill == true ? white_ffffff : dark_grey_d9dde3),
                ),
              ],
            ),
            GetBuilder<UserDetailViewModel>(
              builder: (controller) {
                if (controller.editMobileNoVerifyOtpApiResponse.status ==
                        Status.LOADING ||
                    controller.editMobileNoResendOtpApiResponse.status ==
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
}
