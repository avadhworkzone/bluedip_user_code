import 'dart:async';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_order_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_order_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/order_resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/Utility.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/dine_in/RedeemDineInBookingDetail.dart';
import 'package:bluedip_user/view/home/resto_details/RestoDetailScreen.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../../modal/apiModel/response_modal/common_res_model.dart';
import 'RedeemOrderMenuList.dart';
import '../../Widget/common_verify_red_button.dart';

class RedeemOtpVerified extends StatefulWidget {
  int id;
  int otp;
  String mobileNo;
  String restoId;
  String offerId;
  String orderType;
  String userFullName;
  String? noOfGuest;
  String time;
  String specialRequest;

  RedeemOtpVerified(
      {required this.id,
      required this.otp,
      required this.mobileNo,
      required this.restoId,
      required this.offerId,
      required this.orderType,
      required this.userFullName,
      this.noOfGuest,
      required this.time,
      required this.specialRequest});

  @override
  State<RedeemOtpVerified> createState() => _RedeemOtpVerifiedState();
}

class _RedeemOtpVerifiedState extends State<RedeemOtpVerified> {
  bool isDataFill = false;
  TextEditingController controllerPin = TextEditingController();
  OrderViewModel orderViewModel = Get.find();
  final _formKey = GlobalKey<FormState>();
  AddOrderReqModel orderReqModel = AddOrderReqModel();

  bool _isRunning = false;

  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 30;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white_ffffff,
          body: Stack(
            children: [
              Column(
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
                    padding:
                        EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.offAll(RestaurantDetailsScreen(
                                restaurantId:
                                    PreferenceManagerUtils.getRestoId(),
                              ));
                            },
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
                            "Mobile Verification",
                            style: TextStyle(
                                fontFamily: fontOverpassBold,
                                color: black_504f58,
                                fontSize: 20.sp),
                          ),
                        ),
                      ],
                    ),
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
                            // 4 digit verification code sent on +91 9876434322 Edit
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
                                // InkWell(
                                //   onTap: () {
                                //     Get.back();
                                //   },
                                //   child: Text(
                                //     "Edit",
                                //     style: TextStyle(
                                //         color: red_dc3642,
                                //         fontFamily: fontMavenProRegular,
                                //         fontStyle: FontStyle.normal,
                                //         fontSize: 15.sp,
                                //         height: 1.5),
                                //   ),
                                // ),
                              ],
                            ),
                            // RichText(
                            //     text: TextSpan(children: [
                            //   TextSpan(
                            //       style: TextStyle(
                            //           color: black_504f58,
                            //           fontFamily: fontMavenProRegular,
                            //           fontSize: 15.sp),
                            //       text: "4 digit verification code sent on \n"),
                            //   TextSpan(
                            //       style: TextStyle(
                            //           color: black_504f58,
                            //           fontFamily: fontMavenProProSemiBold,
                            //           fontSize: 15.sp,
                            //           height: 1.5),
                            //       text: "+91 9876434322 "),
                            //   // TextSpan(
                            //   //     style:  TextStyle(
                            //   //         color: red_dc3642,
                            //   //         fontFamily: fontMavenProRegular,
                            //   //         fontStyle:  FontStyle.normal,
                            //   //         fontSize: 15.sp,
                            //   //         height: 1.5
                            //   //     ),
                            //   //     text: "Edit")
                            // ])),
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
                                  child: PinCodeTextField(
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
                                        borderRadius:
                                            BorderRadius.circular(15.r),
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
                              await orderViewModel.orderResendOtp(
                                  mobileNumber: widget.mobileNo);

                              if (orderViewModel
                                      .orderResendOtpApiResponse.status ==
                                  Status.COMPLETE) {
                                OrderResendOtpResModel response = orderViewModel
                                    .orderResendOtpApiResponse.data;
                                if (response.status == true) {
                                  widget.otp =
                                      int.parse(response.otp.toString());
                                  startTimeout();
                                  _startTimer();
                                } else {
                                  snackBar(title: '${response.message}');
                                  // Get.snackbar('', '${response.message}',
                                  //     snackPosition: SnackPosition.BOTTOM,
                                  //     colorText: Colors.white,
                                  //     backgroundColor: blue_3d56f0);
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
                        await orderViewModel.orderVerifyOtp(
                            mobileNumber: widget.mobileNo,
                            secretOtp: controllerPin.text);
                        CommonResModel response =
                            orderViewModel.orderVerifyOtpApiResponse.data;
                        if (orderViewModel.orderVerifyOtpApiResponse.status ==
                            Status.COMPLETE) {
                          if (response.status == true) {
                            _stopTimer();
                            orderReqModel.action = "add_order";
                            orderReqModel.restaurantId = widget.restoId;
                            orderReqModel.offerId = widget.offerId;
                            orderReqModel.orderType = widget.orderType;
                            orderReqModel.userFullName = widget.userFullName;
                            orderReqModel.mobileNumber = widget.mobileNo;
                            orderReqModel.noOfGuest = widget.noOfGuest == ""
                                ? null
                                : widget.noOfGuest;
                            orderReqModel.time = widget.time;
                            orderReqModel.specialRequest =
                                widget.specialRequest;
                            await orderViewModel.addOrder(body: orderReqModel);
                            if (orderViewModel.addOrderApiResponse.status ==
                                Status.ERROR) {
                              const ServerError();
                            }
                            if (orderViewModel.addOrderApiResponse.status ==
                                Status.COMPLETE) {
                              AddOrderResModel addOrderResponse =
                                  orderViewModel.addOrderApiResponse.data;
                              if (addOrderResponse.status == true) {
                                Utility.orderType == "Dine-in"
                                    ? Get.to(() => RedeemDineInBookingDetail(
                                          orderId: addOrderResponse.orderId
                                              .toString(),
                                        ))
                                    : Get.to(() => RedeemOrderMenuItems(
                                          orderId: addOrderResponse.orderId!,
                                        ));
                              } else {
                                snackBar(title: addOrderResponse.message);
                              }
                            }
                          } else {
                            snackBar(title: response.message);
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
              GetBuilder<OrderViewModel>(
                builder: (controller) {
                  if (controller.orderVerifyOtpApiResponse.status ==
                          Status.LOADING ||
                      controller.orderResendOtpApiResponse.status ==
                          Status.LOADING) {
                    return const CircularIndicator();
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
