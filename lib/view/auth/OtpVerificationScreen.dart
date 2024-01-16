import 'dart:async';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/otp_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/auth/SignupDetailScreen.dart';
import 'package:bluedip_user/viewModel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/back_button.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/common_verify_red_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen({Key? key, required this.otp, required this.mobileNo})
      : super(key: key);
  int otp;
  String mobileNo;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isDataFill = false;
  TextEditingController controllerPin = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthViewModel authViewModel = Get.find();
  bool _isRunning = false;

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 30;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted)
          setState(() {
            print(timer.tick);
            currentSeconds = timer.tick;
            if (timer.tick >= timerMaxSeconds) timer.cancel();
          });
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
    // SystemChrome.setSystemUIOverlayStyle(overlayStyle);
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
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, top: 45.h),
                      child: back_button(),
                    ),
                  ],
                ),
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
                          // Verify Mobile Number
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
                          // Row(
                          //   children: [
                          //     RichText(
                          //         text: TextSpan(children: [
                          //       TextSpan(
                          //           style: TextStyle(
                          //               color: black_504f58,
                          //               fontFamily: fontMavenProRegular,
                          //               fontSize: 15.sp),
                          //           text:
                          //               "4 digit verification code sent on \n"),
                          //       TextSpan(
                          //           style: TextStyle(
                          //               color: black_504f58,
                          //               fontFamily: fontMavenProProSemiBold,
                          //               fontSize: 15.sp),
                          //           text: "+91 ${widget.mobileNo} "),
                          //       TextSpan(
                          //           style: TextStyle(
                          //               color: red_dc3642,
                          //               fontFamily: fontMavenProRegular,
                          //               fontStyle: FontStyle.normal,
                          //               fontSize: 15.sp,
                          //               height: 1.5),
                          //           text: "Edit")
                          //     ])),
                          //     Text('Edit')
                          //   ],
                          // ),

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
                          SizedBox(
                            width: Get.width,
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.black,
                                primaryColorDark: Colors.black,
                                focusColor: Colors.black,
                                textSelectionTheme:
                                    const TextSelectionThemeData(
                                  cursorColor: Colors.black, //thereby
                                ),
                              ),
                              child: Form(
                                key: _formKey,
                                child:
                                    // Pinput(
                                    //   // keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                                    //   //     ? const TextInputType.numberWithOptions(
                                    //   //         decimal: true, signed: true)
                                    //   //     :
                                    //   keyboardType: TextInputType.number,
                                    //   controller: controllerPin,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   defaultPinTheme: PinTheme(
                                    //     margin: EdgeInsets.symmetric(horizontal: 1.w),
                                    //     width: 14.w,
                                    //     height: 14.w,
                                    //     textStyle:
                                    //         FontTextStyle.Proxima24Medium.copyWith(
                                    //             color: ColorUtils.primaryColor),
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(color: grey_d9dde3),
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //   ),
                                    //
                                    //   // forceErrorState: controller.forceErrorState,
                                    //   errorPinTheme: PinTheme(
                                    //     margin: EdgeInsets.symmetric(horizontal: 1.w),
                                    //     width: 14.w,
                                    //     height: 14.w,
                                    //     textStyle:
                                    //         FontTextStyle.Proxima24Medium.copyWith(
                                    //             color: ColorUtils.primaryColor),
                                    //     decoration: BoxDecoration(
                                    //       border:
                                    //           Border.all(color: Colors.red),
                                    //       borderRadius: BorderRadius.circular(10),
                                    //     ),
                                    //   ),
                                    //
                                    //   // errorText: controllerPin.text.isEmpty
                                    //   //     ? VariableUtils.enterOtp
                                    //   //     : VariableUtils.otpErrorMsg,
                                    //   // errorTextStyle:
                                    //   //     FontTextStyle.Proxima12Regular.copyWith(
                                    //   //         overflow: TextOverflow.ellipsis,
                                    //   //         color: ColorUtils.redColor),
                                    //   pinputAutovalidateMode:
                                    //       PinputAutovalidateMode.onSubmit,
                                    //   onChanged: (String value) {
                                    //     if (value.length == 4) {
                                    //       FocusScope.of(context).unfocus();
                                    //     }
                                    //     // controller.forceErrorState = false;
                                    //   },
                                    //   // validator: (pin) {
                                    //   //   apiCall();
                                    //   //   return null;
                                    //   //
                                    //   //   // return 'Pin is incorrect';
                                    //   // },
                                    // ),

                                    PinCodeTextField(
                                  appContext: context,
                                  pastedTextStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: fontMavenProBold,
                                      fontSize: 24.sp),
                                  length: 6,
                                  controller: controllerPin,
                                  obscureText: false,
                                  obscuringCharacter: '*',
                                  obscuringWidget: null,
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  autoFocus: true,
                                  errorTextSpace: 70.w,
                                  errorTextDirection: TextDirection.ltr,
                                  errorTextMargin: EdgeInsets.only(left: 100.w),
                                  enablePinAutofill: true,
                                  validator: (value) {
                                    if (controllerPin.value.text.length < 6 ||
                                        controllerPin.value.text.isEmpty) {
                                      return 'Please Enter Valid Otp';
                                    }
                                    return null;
                                  },
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
                                  // validator: (value) {
                                  //   return ValidationMethod.validateIsRequired(
                                  //       value);
                                  // },
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
                            await authViewModel.resendOtpViewModel(
                                type: "user_login",
                                action: "resend_otp",
                                mobileNumber: widget.mobileNo);
                            ResendOtpResModel response =
                                authViewModel.resendOtpApiResponse.data;

                            if (authViewModel.resendOtpApiResponse.status ==
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
                  padding: EdgeInsets.all(16.0),
                  child: CommonVerifyRedButton(strVerify.toUpperCase(),
                      () async {
                    if (_formKey.currentState!.validate()) {
                      await authViewModel.otpViewModel(
                          type: "user_login",
                          action: "verify_otp",
                          mobileNumber: widget.mobileNo,
                          secretOtp: controllerPin.text);
                      VerifyOtpResModel response =
                          authViewModel.otpApiResponse.data;
                      if (authViewModel.otpApiResponse.status ==
                          Status.COMPLETE) {
                        if (response.status == true) {
                          await PreferenceManagerUtils.setToken(
                              response.token ?? "");
                          print(
                              '===token=====${PreferenceManagerUtils.getToken()}');
                          Get.offAll(SignupDetailScreen());
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
                    // else {
                    //   final snackBar = SnackBar(
                    //     content: const Text('field is required'),
                    //     action: SnackBarAction(
                    //       label: '',
                    //       onPressed: () {
                    //         // Some code to undo the change.
                    //       },
                    //     ),
                    //   );
                    //
                    //   // Find the ScaffoldMessenger in the widget tree
                    //   // and use it to show a SnackBar.
                    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // }
                  }, isDataFill == true ? red_dc3642 : divider_d4dce7,
                      isDataFill == true ? white_ffffff : dark_grey_d9dde3),
                ),
              ],
            ),
            GetBuilder<AuthViewModel>(
              builder: (authViewModel) {
                if (authViewModel.otpApiResponse.status == Status.LOADING ||
                    authViewModel.resendOtpApiResponse.status ==
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
