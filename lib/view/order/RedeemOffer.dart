import 'dart:async';
import 'dart:convert';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/Widget/common_border_button.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_order_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_order_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_info_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/order_resend_otp_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/Utility.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/utils/validation_utils.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/dine_in/RedeemDineInBookingDetail.dart';
import 'package:bluedip_user/view/home/resto_details/RestoDetailScreen.dart';
import 'package:bluedip_user/view/order/RedeemOrderMenuList.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:bluedip_user/viewModel/resto_detail_view_model.dart';
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
import '../../Widget/green_ticket_widget.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../../modal/apiModel/response_modal/get_booking_order_detail_res.dart';
import '../../modal/apiModel/response_modal/offer_detail_res_model.dart';
import '../../utils/enum_utils.dart';
import 'RedeemOtpVerified.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';
import '../home/resto_details/timer.dart';

class RedeemOffer extends StatefulWidget {
  RedeemOffer(
      {Key? key, this.dineInOrderId, this.isEditFlow, this.tackAwayOrderId})
      : super(key: key);
  // int? offerId;
  int? dineInOrderId;
  int? tackAwayOrderId;
  // GetBookingOrderDetailResModel? bookingDetailRes;
  bool? isEditFlow;

  @override
  State<RedeemOffer> createState() => _RedeemOfferState();
}

class _RedeemOfferState extends State<RedeemOffer>
    with SingleTickerProviderStateMixin {
  final List<League> data = <League>[
    League(
        'How to redeem',
        <Club>[
          Club(
              icon_diamond,
              "Enter your details below and hit redeem to progress to the online menu",
              0),
          Club(
              icon_diamond,
              "Select the items you would like to order and pay through our secure checkout",
              0),
          Club(
              icon_diamond,
              "Follow your order tracking to know when your food will be ready for pickup",
              0),
        ],
        false),
  ];

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _guestController = TextEditingController();
  String startTime = "Select";
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTimeSecond = TimeOfDay.now();
  Duration duration = const Duration(hours: 1, minutes: 00);
  OrderViewModel orderViewModel = Get.find();
  AddOrderReqModel orderReqModel = AddOrderReqModel();
  RestoDetailViewModel restoDetailViewModel = Get.find();
  OfferDetailsResModel? responseOfferDetail;
  GetOrderInfoResModel? getOrderInfoRes;

  getOrderInfo() async {
    await restoDetailViewModel
        .getOrderInfoViewModel(
            orderId: Utility.orderType == "Dine-in"
                ? widget.dineInOrderId.toString()
                : widget.tackAwayOrderId.toString())
        .then((value) {
      if (restoDetailViewModel.getOrderInfoApiResponse.status ==
          Status.COMPLETE) {
        getOrderInfoRes = restoDetailViewModel.getOrderInfoApiResponse.data;
        if (getOrderInfoRes!.status == true) {
          if (getOrderInfoRes != null || getOrderInfoRes!.data != null) {
            _nameController.text = getOrderInfoRes!.data!.userFullName!;
            _mobileController.text = getOrderInfoRes!.data!.mobileNumber!;
            _guestController.text = getOrderInfoRes!.data!.noOfGuest == null
                ? ""
                : getOrderInfoRes!.data!.noOfGuest!.toString();
            startTime = getOrderInfoRes!.data!.time.toString();
            _specialReqController.text = getOrderInfoRes!.data!.specialRequest!;
          }
        } else {
          snackBar(title: getOrderInfoRes!.message);
        }
      }
    });
  }

  @override
  void initState() {
    // if (widget.isEditFlow == true) {
    //   _nameController.text = widget.bookingDetailRes!.data!.userFullName!;
    //   _mobileController.text = widget.bookingDetailRes!.data!.mobileNumber!;
    //   _guestController.text =
    //       widget.bookingDetailRes!.data!.noOfGuest!.toString();
    //   startTime = widget.bookingDetailRes!.data!.time.toString();
    //   _specialReqController.text =
    //       widget.bookingDetailRes!.data!.specialRequest!;
    // } else {
    getOfferApi();
    widget.isEditFlow == true ? getOrderInfo() : const SizedBox();
    // }
    super.initState();
  }

  getOfferApi() async {
    await restoDetailViewModel
        .offerDetailViewModel(offerId: PreferenceManagerUtils.getOfferId())
        .then((value) {
      if (restoDetailViewModel.offerDetailApiResponse.status ==
          Status.COMPLETE) {
        responseOfferDetail = restoDetailViewModel.offerDetailApiResponse.data;
        if (responseOfferDetail!.status == true) {
        } else {
          snackBar(title: responseOfferDetail!.message);
        }
      }
    });
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
    return Scaffold(
      backgroundColor: white_ffffff,
      body: SafeArea(
        child: GetBuilder<RestoDetailViewModel>(
          builder: (controller) {
            if (controller.offerDetailApiResponse.status == Status.LOADING ||
                controller.getOrderInfoApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.offerDetailApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            if (controller.getOrderInfoApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
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
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.offAll(RestaurantDetailsScreen(
                              restaurantId: PreferenceManagerUtils.getRestoId(),
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
                          'Redeem Offer',
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // widget.isEditFlow == true
                                  //     ? Container(
                                  //         decoration: BoxDecoration(
                                  //             color: white_ffffff,
                                  //             borderRadius: BorderRadius.only(
                                  //                 topLeft:
                                  //                     Radius.circular(18.r),
                                  //                 topRight:
                                  //                     Radius.circular(18.r))),
                                  //         child: Wrap(
                                  //           children: [
                                  //             Column(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.start,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //               children: [
                                  //                 Container(
                                  //                   width: double.infinity,
                                  //                   height: 136.h,
                                  //                   decoration:
                                  //                       const BoxDecoration(
                                  //                           image:
                                  //                               DecorationImage(
                                  //                     image: AssetImage(
                                  //                       "assets/images/img_ticket_green_png.png",
                                  //                     ),
                                  //                   )),
                                  //                   child: Align(
                                  //                     alignment:
                                  //                         Alignment.center,
                                  //                     child: Padding(
                                  //                       padding: EdgeInsets
                                  //                           .symmetric(
                                  //                               horizontal:
                                  //                                   14.h,
                                  //                               vertical: 20.h),
                                  //                       child: Center(
                                  //                         child: Row(
                                  //                           mainAxisAlignment:
                                  //                               MainAxisAlignment
                                  //                                   .center,
                                  //                           crossAxisAlignment:
                                  //                               CrossAxisAlignment
                                  //                                   .center,
                                  //                           mainAxisSize:
                                  //                               MainAxisSize
                                  //                                   .min,
                                  //                           children: [
                                  //                             Expanded(
                                  //                               flex: 1,
                                  //                               child: Padding(
                                  //                                 padding: const EdgeInsets
                                  //                                         .symmetric(
                                  //                                     horizontal:
                                  //                                         8.0),
                                  //                                 child: Column(
                                  //                                   mainAxisAlignment:
                                  //                                       MainAxisAlignment
                                  //                                           .start,
                                  //                                   crossAxisAlignment:
                                  //                                       CrossAxisAlignment
                                  //                                           .start,
                                  //                                   children: [
                                  //                                     // 20% OFF
                                  //                                     RichText(
                                  //                                         text: TextSpan(
                                  //                                             children: [
                                  //                                           TextSpan(
                                  //                                               style: TextStyle(color: green_5cb85c, fontWeight: FontWeight.w700, fontFamily: fontOverpassBold, fontStyle: FontStyle.normal, fontSize: 35.sp),
                                  //                                               text: widget.bookingDetailRes!.data!.offerData!.offerPercentage),
                                  //                                           TextSpan(
                                  //                                               style: TextStyle(color: green_5cb85c, fontWeight: FontWeight.w400, fontFamily: fontMavenProRegular, fontStyle: FontStyle.normal, fontSize: 15.sp),
                                  //                                               text: "\nOFF")
                                  //                                         ])),
                                  //                                     SizedBox(
                                  //                                       height:
                                  //                                           10.h,
                                  //                                     ),
                                  //                                     Text(
                                  //                                         widget
                                  //                                             .bookingDetailRes!
                                  //                                             .data!
                                  //                                             .offerData!
                                  //                                             .offerType!
                                  //                                             .toUpperCase(),
                                  //                                         style: TextStyle(
                                  //                                             color: red_dc3642,
                                  //                                             fontFamily: fontMavenProMedium,
                                  //                                             fontStyle: FontStyle.normal,
                                  //                                             fontSize: 14.sp),
                                  //                                         textAlign: TextAlign.left)
                                  //                                   ],
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                             Padding(
                                  //                               padding: EdgeInsets
                                  //                                   .only(
                                  //                                       right: 6
                                  //                                           .w),
                                  //                               child: Column(
                                  //                                 mainAxisAlignment:
                                  //                                     MainAxisAlignment
                                  //                                         .start,
                                  //                                 crossAxisAlignment:
                                  //                                     CrossAxisAlignment
                                  //                                         .start,
                                  //                                 children: [
                                  //                                   // Pizza Hut
                                  //                                   Text(
                                  //                                       widget
                                  //                                           .bookingDetailRes!
                                  //                                           .data!
                                  //                                           .restaurantData!
                                  //                                           .restaurantName!,
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               black_504f58,
                                  //                                           fontFamily:
                                  //                                               fontOverpassBold,
                                  //                                           fontStyle: FontStyle
                                  //                                               .normal,
                                  //                                           fontSize: 16
                                  //                                               .sp),
                                  //                                       textAlign:
                                  //                                           TextAlign.left),
                                  //                                   SizedBox(
                                  //                                     height:
                                  //                                         4.h,
                                  //                                   ),
                                  //                                   Text(
                                  //                                       "${widget.bookingDetailRes!.data!.offerData!.deals} Deals Left",
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               red_dc3642,
                                  //                                           fontFamily:
                                  //                                               fontMavenProProSemiBold,
                                  //                                           fontStyle: FontStyle
                                  //                                               .normal,
                                  //                                           fontSize: 14
                                  //                                               .sp),
                                  //                                       textAlign:
                                  //                                           TextAlign.left),
                                  //                                   SizedBox(
                                  //                                     height:
                                  //                                         4.h,
                                  //                                   ),
                                  //                                   widget.bookingDetailRes!.data!.offerData!.minAmount !=
                                  //                                           null
                                  //                                       ? Text(
                                  //                                           "The Total Order Incl.Drinks ",
                                  //                                           style: TextStyle(
                                  //                                               color: grey_77879e,
                                  //                                               fontFamily: fontMavenProRegular,
                                  //                                               fontSize: 14.sp,
                                  //                                               height: 1.5),
                                  //                                           textAlign: TextAlign.left)
                                  //                                       : const SizedBox(),
                                  //                                   widget.bookingDetailRes!.data!.offerData!.minAmount !=
                                  //                                           null
                                  //                                       ? RichText(
                                  //                                           text:
                                  //                                               TextSpan(children: [
                                  //                                           TextSpan(
                                  //                                               style: TextStyle(color: grey_77879e, fontFamily: fontMavenProRegular, fontSize: 14.sp, height: 1.5),
                                  //                                               text: "On "),
                                  //                                           TextSpan(
                                  //                                               style: TextStyle(color: grey_504f58, fontFamily: fontMavenProRegular, fontSize: 14.sp),
                                  //                                               text: "₹${widget.bookingDetailRes!.data!.offerData!.minAmount} "),
                                  //                                           TextSpan(
                                  //                                               style: TextStyle(color: grey_77879e, fontFamily: fontMavenProRegular, fontSize: 14.sp),
                                  //                                               text: "Min bill Amount")
                                  //                                         ]))
                                  //                                       : const SizedBox()
                                  //                                 ],
                                  //                               ),
                                  //                             )
                                  //                           ],
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 // Stack(
                                  //                 //   alignment: Alignment.center,
                                  //                 //   children: [
                                  //                 //     SvgPicture.asset(
                                  //                 //       img_ticket_green,
                                  //                 //       width: MediaQuery.of(context).size.width,
                                  //                 //      //height: 136.h,
                                  //                 //       fit: BoxFit.fill,
                                  //                 //     ),
                                  //                 //     Container(
                                  //                 //       margin: const EdgeInsets.all(14.0),
                                  //                 //       child: Row(
                                  //                 //         mainAxisAlignment: MainAxisAlignment.start,
                                  //                 //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //                 //         children: [
                                  //                 //           Expanded(
                                  //                 //             flex:1,
                                  //                 //             child: Column(
                                  //                 //               mainAxisAlignment: MainAxisAlignment.start,
                                  //                 //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //                 //               children: [
                                  //                 //                 // 20% OFF
                                  //                 //                 RichText(
                                  //                 //                     text: TextSpan(children: [
                                  //                 //                       TextSpan(
                                  //                 //                           style:  TextStyle(
                                  //                 //                               color: green_5cb85c,
                                  //                 //                               fontWeight: FontWeight.w700,
                                  //                 //                               fontFamily: fontOverpassBold,
                                  //                 //                               fontStyle: FontStyle.normal,
                                  //                 //                               fontSize: 35.sp),
                                  //                 //                           text: title),
                                  //                 //                       TextSpan(
                                  //                 //                           style:  TextStyle(
                                  //                 //                               color: green_5cb85c,
                                  //                 //                               fontWeight: FontWeight.w400,
                                  //                 //                               fontFamily: fontMavenProRegular,
                                  //                 //                               fontStyle: FontStyle.normal,
                                  //                 //                               fontSize: 15.sp),
                                  //                 //                           text: "\nOFF")
                                  //                 //                     ])),
                                  //                 //                 SizedBox(height: 10.h,),
                                  //                 //                 Text(
                                  //                 //                     type.toUpperCase(),
                                  //                 //                     style:  TextStyle(
                                  //                 //                         color:  red_dc3642,
                                  //                 //                         fontFamily: fontMavenProMedium,
                                  //                 //                         fontStyle:  FontStyle.normal,
                                  //                 //                         fontSize: 14.sp
                                  //                 //                     ),
                                  //                 //                     textAlign: TextAlign.left
                                  //                 //                 )
                                  //                 //               ],
                                  //                 //             ),
                                  //                 //           ),
                                  //                 //           Padding(
                                  //                 //             padding:  EdgeInsets.only(right: 6.w),
                                  //                 //             child: Column(
                                  //                 //               mainAxisAlignment: MainAxisAlignment.start,
                                  //                 //               crossAxisAlignment: CrossAxisAlignment.start,
                                  //                 //               children: [
                                  //                 //                 // Pizza Hut
                                  //                 //                 Text(
                                  //                 //                     "Pizza Hut",
                                  //                 //                     style:  TextStyle(
                                  //                 //                         color:  black_504f58,
                                  //                 //                         fontFamily: fontOverpassBold,
                                  //                 //                         fontStyle:  FontStyle.normal,
                                  //                 //                         fontSize: 16.sp
                                  //                 //                     ),
                                  //                 //                     textAlign: TextAlign.left
                                  //                 //                 ),
                                  //                 //                 SizedBox(height: 4.h,),
                                  //                 //                 Text(
                                  //                 //                     "5 Deals Left",
                                  //                 //                     style:  TextStyle(
                                  //                 //                         color:  red_dc3642,
                                  //                 //                         fontFamily: fontMavenProProSemiBold,
                                  //                 //                         fontStyle:  FontStyle.normal,
                                  //                 //                         fontSize: 14.sp
                                  //                 //                     ),
                                  //                 //                     textAlign: TextAlign.left
                                  //                 //                 ),
                                  //                 //                SizedBox(height: 4.h,),
                                  //                 //                 Text(
                                  //                 //                     "The Total Order Incl.Drinks ",
                                  //                 //                     style:  TextStyle(
                                  //                 //                         color:  grey_77879e,
                                  //                 //                         fontFamily: fontMavenProRegular,
                                  //                 //                         fontSize: 14.sp,
                                  //                 //                         height: 1.5
                                  //                 //                     ),
                                  //                 //                     textAlign: TextAlign.left
                                  //                 //                 ),
                                  //                 //                 // On ₹300 Min bill Amount
                                  //                 //                 RichText(
                                  //                 //                     text: TextSpan(
                                  //                 //                         children: [
                                  //                 //                           TextSpan(
                                  //                 //                               style:  TextStyle(
                                  //                 //                                   color:  grey_77879e,
                                  //                 //                                   fontFamily: fontMavenProRegular,
                                  //                 //                                   fontSize: 14.sp,
                                  //                 //                                   height: 1.5
                                  //                 //                               ),
                                  //                 //                               text: "On "),
                                  //                 //                           TextSpan(
                                  //                 //                               style:  TextStyle(
                                  //                 //                                   color:  grey_504f58,
                                  //                 //                                   fontFamily: fontMavenProRegular,
                                  //                 //                                   fontSize: 14.sp
                                  //                 //                               ),
                                  //                 //                               text: "₹300 "),
                                  //                 //                           TextSpan(
                                  //                 //                               style:  TextStyle(
                                  //                 //                                   color:  grey_77879e,
                                  //                 //                                   fontFamily: fontMavenProRegular,
                                  //                 //                                   fontSize: 14.sp
                                  //                 //                               ),
                                  //                 //                               text: "Min bill Amount")
                                  //                 //                         ]
                                  //                 //                     )
                                  //                 //                 )
                                  //                 //               ],
                                  //                 //             ),
                                  //                 //           )
                                  //                 //         ],
                                  //                 //       ),
                                  //                 //     )
                                  //                 //   ],
                                  //                 // ),
                                  //                 SizedBox(
                                  //                   height: 10.h,
                                  //                 ),
                                  //                 Row(
                                  //                   children: [
                                  //                     SvgPicture.asset(
                                  //                         icon_clock_blue),
                                  //                     SizedBox(
                                  //                       width: 4.w,
                                  //                     ),
                                  //                     // Valid Anytime Today
                                  //                     TimerClass(
                                  //                       isBookingDetail: true,
                                  //                       bookingDetailRes: widget
                                  //                           .bookingDetailRes,
                                  //                       // response: null,
                                  //                     )
                                  //                   ],
                                  //                 ),
                                  //                 // GreenTicketWidget(
                                  //                 //     title: '${res.data!.offerPercentage}',
                                  //                 //     subtitle: 'Valid Anytime Today',
                                  //                 //     type: "${res.data!.offerType}"),
                                  //                 SizedBox(
                                  //                   height: 10.h,
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         ))
                                  //     :
                                  Container(
                                      decoration: BoxDecoration(
                                          color: white_ffffff,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(18.r),
                                              topRight: Radius.circular(18.r))),
                                      child: Wrap(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 136.h,
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                    "assets/images/img_ticket_green_png.png",
                                                  ),
                                                )),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 14.h,
                                                            vertical: 20.h),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // 20% OFF
                                                                  RichText(
                                                                      text: TextSpan(
                                                                          children: [
                                                                        TextSpan(
                                                                            style: TextStyle(
                                                                                color: green_5cb85c,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: fontOverpassBold,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 35.sp),
                                                                            text: responseOfferDetail!.data!.offerPercentage ?? ""),
                                                                        TextSpan(
                                                                            style: TextStyle(
                                                                                color: green_5cb85c,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontFamily: fontMavenProRegular,
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 15.sp),
                                                                            text: "\nOFF")
                                                                      ])),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                  Text(
                                                                      responseOfferDetail!
                                                                          .data!
                                                                          .offerType!
                                                                          .toUpperCase(),
                                                                      style: TextStyle(
                                                                          color:
                                                                              red_dc3642,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize: 14
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 6.w),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                // Pizza Hut
                                                                Text(
                                                                    responseOfferDetail!
                                                                        .data!
                                                                        .restaurantData![
                                                                            0]
                                                                        .restaurantName!,
                                                                    style: TextStyle(
                                                                        color:
                                                                            black_504f58,
                                                                        fontFamily:
                                                                            fontOverpassBold,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize: 16
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                SizedBox(
                                                                  height: 4.h,
                                                                ),
                                                                Text(
                                                                    "${responseOfferDetail!.data!.deals} Deals Left",
                                                                    style: TextStyle(
                                                                        color:
                                                                            red_dc3642,
                                                                        fontFamily:
                                                                            fontMavenProProSemiBold,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize: 14
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                                SizedBox(
                                                                  height: 4.h,
                                                                ),
                                                                responseOfferDetail!
                                                                            .data!
                                                                            .minAmount !=
                                                                        null
                                                                    ? Text(
                                                                        "The Total Order Incl.Drinks ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                grey_77879e,
                                                                            fontFamily:
                                                                                fontMavenProRegular,
                                                                            fontSize: 14
                                                                                .sp,
                                                                            height:
                                                                                1.5),
                                                                        textAlign:
                                                                            TextAlign.left)
                                                                    : const SizedBox(),
                                                                responseOfferDetail!
                                                                            .data!
                                                                            .minAmount !=
                                                                        null
                                                                    ? RichText(
                                                                        text: TextSpan(
                                                                            children: [
                                                                            TextSpan(
                                                                                style: TextStyle(color: grey_77879e, fontFamily: fontMavenProRegular, fontSize: 14.sp, height: 1.5),
                                                                                text: "On "),
                                                                            TextSpan(
                                                                                style: TextStyle(color: grey_504f58, fontFamily: fontMavenProRegular, fontSize: 14.sp),
                                                                                text: "₹${responseOfferDetail!.data!.minAmount} "),
                                                                            TextSpan(
                                                                                style: TextStyle(color: grey_77879e, fontFamily: fontMavenProRegular, fontSize: 14.sp),
                                                                                text: "Min bill Amount")
                                                                          ]))
                                                                    : const SizedBox()
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Stack(
                                              //   alignment: Alignment.center,
                                              //   children: [
                                              //     SvgPicture.asset(
                                              //       img_ticket_green,
                                              //       width: MediaQuery.of(context).size.width,
                                              //      //height: 136.h,
                                              //       fit: BoxFit.fill,
                                              //     ),
                                              //     Container(
                                              //       margin: const EdgeInsets.all(14.0),
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.start,
                                              //         crossAxisAlignment: CrossAxisAlignment.center,
                                              //         children: [
                                              //           Expanded(
                                              //             flex:1,
                                              //             child: Column(
                                              //               mainAxisAlignment: MainAxisAlignment.start,
                                              //               crossAxisAlignment: CrossAxisAlignment.start,
                                              //               children: [
                                              //                 // 20% OFF
                                              //                 RichText(
                                              //                     text: TextSpan(children: [
                                              //                       TextSpan(
                                              //                           style:  TextStyle(
                                              //                               color: green_5cb85c,
                                              //                               fontWeight: FontWeight.w700,
                                              //                               fontFamily: fontOverpassBold,
                                              //                               fontStyle: FontStyle.normal,
                                              //                               fontSize: 35.sp),
                                              //                           text: title),
                                              //                       TextSpan(
                                              //                           style:  TextStyle(
                                              //                               color: green_5cb85c,
                                              //                               fontWeight: FontWeight.w400,
                                              //                               fontFamily: fontMavenProRegular,
                                              //                               fontStyle: FontStyle.normal,
                                              //                               fontSize: 15.sp),
                                              //                           text: "\nOFF")
                                              //                     ])),
                                              //                 SizedBox(height: 10.h,),
                                              //                 Text(
                                              //                     type.toUpperCase(),
                                              //                     style:  TextStyle(
                                              //                         color:  red_dc3642,
                                              //                         fontFamily: fontMavenProMedium,
                                              //                         fontStyle:  FontStyle.normal,
                                              //                         fontSize: 14.sp
                                              //                     ),
                                              //                     textAlign: TextAlign.left
                                              //                 )
                                              //               ],
                                              //             ),
                                              //           ),
                                              //           Padding(
                                              //             padding:  EdgeInsets.only(right: 6.w),
                                              //             child: Column(
                                              //               mainAxisAlignment: MainAxisAlignment.start,
                                              //               crossAxisAlignment: CrossAxisAlignment.start,
                                              //               children: [
                                              //                 // Pizza Hut
                                              //                 Text(
                                              //                     "Pizza Hut",
                                              //                     style:  TextStyle(
                                              //                         color:  black_504f58,
                                              //                         fontFamily: fontOverpassBold,
                                              //                         fontStyle:  FontStyle.normal,
                                              //                         fontSize: 16.sp
                                              //                     ),
                                              //                     textAlign: TextAlign.left
                                              //                 ),
                                              //                 SizedBox(height: 4.h,),
                                              //                 Text(
                                              //                     "5 Deals Left",
                                              //                     style:  TextStyle(
                                              //                         color:  red_dc3642,
                                              //                         fontFamily: fontMavenProProSemiBold,
                                              //                         fontStyle:  FontStyle.normal,
                                              //                         fontSize: 14.sp
                                              //                     ),
                                              //                     textAlign: TextAlign.left
                                              //                 ),
                                              //                SizedBox(height: 4.h,),
                                              //                 Text(
                                              //                     "The Total Order Incl.Drinks ",
                                              //                     style:  TextStyle(
                                              //                         color:  grey_77879e,
                                              //                         fontFamily: fontMavenProRegular,
                                              //                         fontSize: 14.sp,
                                              //                         height: 1.5
                                              //                     ),
                                              //                     textAlign: TextAlign.left
                                              //                 ),
                                              //                 // On ₹300 Min bill Amount
                                              //                 RichText(
                                              //                     text: TextSpan(
                                              //                         children: [
                                              //                           TextSpan(
                                              //                               style:  TextStyle(
                                              //                                   color:  grey_77879e,
                                              //                                   fontFamily: fontMavenProRegular,
                                              //                                   fontSize: 14.sp,
                                              //                                   height: 1.5
                                              //                               ),
                                              //                               text: "On "),
                                              //                           TextSpan(
                                              //                               style:  TextStyle(
                                              //                                   color:  grey_504f58,
                                              //                                   fontFamily: fontMavenProRegular,
                                              //                                   fontSize: 14.sp
                                              //                               ),
                                              //                               text: "₹300 "),
                                              //                           TextSpan(
                                              //                               style:  TextStyle(
                                              //                                   color:  grey_77879e,
                                              //                                   fontFamily: fontMavenProRegular,
                                              //                                   fontSize: 14.sp
                                              //                               ),
                                              //                               text: "Min bill Amount")
                                              //                         ]
                                              //                     )
                                              //                 )
                                              //               ],
                                              //             ),
                                              //           )
                                              //         ],
                                              //       ),
                                              //     )
                                              //   ],
                                              // ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Row(
                                                children: [
                                                  responseOfferDetail!
                                                                  .data!
                                                                  .timePeriod!
                                                                  .start ==
                                                              "" ||
                                                          responseOfferDetail!
                                                                  .data!
                                                                  .timePeriod!
                                                                  .end ==
                                                              ""
                                                      ? SizedBox()
                                                      : SvgPicture.asset(
                                                          icon_clock_blue),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  // Valid Anytime Today
                                                  TimerClass(
                                                      response:
                                                          responseOfferDetail!)
                                                ],
                                              ),
                                              // GreenTicketWidget(
                                              //     title: '${res.data!.offerPercentage}',
                                              //     subtitle: 'Valid Anytime Today',
                                              //     type: "${res.data!.offerType}"),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  // GreenTicketWidget(
                                  //     title: '20%',
                                  //     subtitle: 'Valid Anytime Today',
                                  //     type: "Takeaway"),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(0.r),
                              itemBuilder: (BuildContext context, int index) =>
                                  data[index].listClubs.isNotEmpty
                                      ? Column(
                                          children: [
                                            Theme(
                                              data: Theme.of(context).copyWith(
                                                  dividerColor:
                                                      Colors.transparent),
                                              child: ListTileTheme(
                                                contentPadding:
                                                    EdgeInsets.all(0.r),
                                                dense: true,
                                                horizontalTitleGap: 0.0,
                                                minLeadingWidth: 0,
                                                child: ExpansionTile(
                                                  iconColor: grey_77879e,
                                                  collapsedIconColor:
                                                      grey_77879e,

                                                  onExpansionChanged: (value) {
                                                    setState(() {
                                                      data[index]
                                                              .isExpandArrow =
                                                          value;
                                                    });
                                                  },
                                                  //  trailing: isExpanded? SvgPicture.asset(icon_down_arrow_expand) : SvgPicture.asset(icon_down_arrow_expand),
                                                  trailing: AnimatedRotation(

                                                      /// you can use different widget for animation
                                                      turns: data[index]
                                                              .isExpandArrow
                                                          ? .5
                                                          : 0,
                                                      duration: const Duration(
                                                          milliseconds: 1),
                                                      child: SvgPicture.asset(
                                                          icon_down_arrow_expand) // your svgImage here
                                                      ),

                                                  // trailing: Icon(
                                                  //   Icons.keyboard_arrow_down,
                                                  //   color: Colors.green,
                                                  // ),

                                                  key: PageStorageKey<League>(
                                                      data[index]),
                                                  tilePadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 16.w,
                                                          vertical: 0.h),
                                                  title: Text(
                                                      data[index].TvTitle,
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontFamily:
                                                              fontOverpassBold,
                                                          color: black_504f58)),
                                                  children: data[index]
                                                      .listClubs
                                                      .asMap()
                                                      .entries
                                                      .map(
                                                    (pos) {
                                                      return Builder(
                                                        builder: (BuildContext
                                                            context) {
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            16.w),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 10.h),
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            data[index].listClubs[pos.key].icon,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              8.w,
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child: Text(
                                                                              data[index].listClubs[pos.key].tvLable,
                                                                              style: TextStyle(fontSize: 14.sp, fontFamily: fontMavenProRegular, color: grey_5f6d7b, height: 1.5)),
                                                                        ),

                                                                        //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                                      ],
                                                                    ),
                                                                    data[index].listClubs.length -
                                                                                1 !=
                                                                            pos
                                                                                .key
                                                                        ? const SizedBox(
                                                                            height:
                                                                                12,
                                                                          )
                                                                        : const SizedBox(
                                                                            height:
                                                                                20)
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: divider_d9dde3,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            ListTile(
                                              title: Text(data[index].TvTitle,
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      // fontFamily: fontOverpassBold,
                                                      color: black_504f58)),
                                            ),
                                            // Divider(
                                            //   height: 1,
                                            //   thickness: 1,
                                            //   color: grey_969da8,
                                            // ),
                                          ],
                                        ),
                              itemCount: data.length,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 30.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(strFullName,
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  loginTextformField("Enter your full name",
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      controller: _nameController,
                                      obscureText: true,
                                      onChanged: (value) {},
                                      regularExpression: RegularExpression
                                          .alphabetSpacePattern),

                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  // Title
                                  Text("Mobile Number",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),

                                  SizedBox(
                                    height: 6.h,
                                  ),

                                  loginTextformField("Enter your mobile number",
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      controller: _mobileController,
                                      validationType: ValidationType.PNumber,
                                      inputLength: 10,
                                      readOnly: widget.isEditFlow == true
                                          ? true
                                          : false,
                                      obscureText: true,
                                      onChanged: (value) {},
                                      regularExpression:
                                          RegularExpression.digitsPattern),
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  Utility.orderType == "Dine-in"
                                      ? Text("Number of Guests",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left)
                                      : const SizedBox(),

                                  Utility.orderType == "Dine-in"
                                      ? SizedBox(
                                          height: 6.h,
                                        )
                                      : const SizedBox(),
                                  Utility.orderType == "Dine-in"
                                      ? loginTextformField(
                                          "Enter number of guest",
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.next,
                                          controller: _guestController,
                                          obscureText: true,
                                          regularExpression:
                                              RegularExpression.digitsPattern,
                                          onChanged: (value) {},
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  // Title
                                  Utility.orderType == "Dine-in"
                                      ? Text("Select Booking Time",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left)
                                      : Text("Select Takeaway Time",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),

                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      selectTimePicker(context);
                                      // setState(() {
                                      //   _selectTime(context);
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(14.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        border: Border.all(
                                            color: grey_d9dde3, width: 1),
                                      ),
                                      child: // Detail
                                          Row(
                                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(startTime,
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                textAlign: TextAlign.left),
                                          ),
                                          SvgPicture.asset(icon_clock_time_grey)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text("Special Request",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),

                                  SizedBox(
                                    height: 6.h,
                                  ),

                                  loginTextformField(
                                      "If you have any special request",
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      controller: _specialReqController,
                                      obscureText: true,
                                      onChanged: (value) {},
                                      regularExpression: RegularExpression
                                          .alphabetSpacePattern),

                                  SizedBox(
                                    height: 40.h,
                                  ),

                                  CommonRedButton(
                                      widget.isEditFlow == true &&
                                              Utility.orderType == "Dine-in"
                                          ? 'Update Booking'.toUpperCase()
                                          : widget.isEditFlow == true &&
                                                  Utility.orderType ==
                                                      "tackaway"
                                              ? 'Update Order'.toUpperCase()
                                              : Utility.orderType == "Dine-in"
                                                  ? "Continue To Booking"
                                                      .toUpperCase()
                                                  : "Continue To Order"
                                                      .toUpperCase(), () async {
                                    if (widget.isEditFlow == true) {
                                      orderReqModel.action = "edit_order";

                                      orderReqModel.orderId =
                                          Utility.orderType == "Dine-in"
                                              ? widget.dineInOrderId.toString()
                                              : widget.tackAwayOrderId
                                                  .toString();
                                      orderReqModel.restaurantId =
                                          PreferenceManagerUtils.getRestoId();
                                      orderReqModel.offerId =
                                          responseOfferDetail!.data!.offerId
                                              .toString();
                                      orderReqModel.orderType =
                                          responseOfferDetail!.data!.offerType;
                                      orderReqModel.userFullName =
                                          _nameController.text;
                                      orderReqModel.mobileNumber =
                                          _mobileController.text;
                                      orderReqModel.noOfGuest =
                                          _guestController.text.isEmpty
                                              ? null
                                              : _guestController.text;
                                      orderReqModel.time = startTime;
                                      orderReqModel.specialRequest =
                                          _specialReqController.text;
                                      await orderViewModel.addOrder(
                                          body: orderReqModel);
                                      if (orderViewModel
                                              .addOrderApiResponse.status ==
                                          Status.ERROR) {
                                        const ServerError();
                                      }
                                      if (orderViewModel
                                              .addOrderApiResponse.status ==
                                          Status.COMPLETE) {
                                        AddOrderResModel response =
                                            orderViewModel
                                                .addOrderApiResponse.data;
                                        if (response.status == true) {
                                          Utility.orderType == "Dine-in"
                                              ? Get.offAll(() =>
                                                  RedeemDineInBookingDetail(
                                                    orderId: widget
                                                        .dineInOrderId
                                                        .toString(),
                                                  ))
                                              : Get.offAll(() =>
                                                  RedeemOrderMenuItems(
                                                    orderId: response.orderId!,
                                                  ));
                                        } else {
                                          snackBar(title: response.message);
                                        }
                                      }
                                    } else {
                                      await orderViewModel
                                          .getOtpForOrderViewModel(
                                              mobileNo: _mobileController.text);
                                      if (orderViewModel
                                              .getOtpForOrderApiResponse
                                              .status ==
                                          Status.ERROR) {
                                        const ServerError();
                                      }
                                      if (orderViewModel
                                              .getOtpForOrderApiResponse
                                              .status ==
                                          Status.COMPLETE) {
                                        OrderResendOtpResModel response =
                                            orderViewModel
                                                .getOtpForOrderApiResponse.data;
                                        if (response.status == true) {
                                          print(
                                              'order---id---${jsonEncode(response)}');
                                          Get.to(RedeemOtpVerified(
                                            id: 1,
                                            otp: response.otp!,
                                            mobileNo: _mobileController.text,
                                            offerId: responseOfferDetail!
                                                .data!.offerId
                                                .toString(),
                                            orderType: responseOfferDetail!
                                                .data!.offerType!,
                                            restoId: responseOfferDetail!
                                                .data!.restaurantId!,
                                            specialRequest:
                                                _specialReqController.text,
                                            time: startTime,
                                            userFullName: _nameController.text,
                                            noOfGuest:
                                                _guestController.text.isEmpty
                                                    ? ""
                                                    : _guestController.text,

                                            // orderId: response.orderId
                                            //     .toString()
                                          ));
                                          // ?.then((value) {
                                          // _nameController.clear();
                                          // _mobileController.clear();
                                          // _specialReqController.clear();
                                          // _guestController.clear();
                                          // startTime = 'Select';
                                          // setState(() {});
                                          // });
                                        } else {
                                          snackBar(title: response.message);
                                        }
                                      }
                                    }
                                  }, red_dc3642),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<OrderViewModel>(
                          builder: (controller) {
                            if (controller.addOrderApiResponse.status ==
                                Status.LOADING) {
                              return const CircularIndicator();
                            }
                            return const SizedBox();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void selectTimePicker(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Container(
              margin: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.r),
                      topRight: Radius.circular(13.r),
                      bottomRight: Radius.circular(13.r),
                      bottomLeft: Radius.circular(13.r))),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13)),
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Daily Opportunities
                                  // Title
                                  Center(
                                    child: Text("Select Time",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProBold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            SizedBox(
                              height: 180.h,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                minimumDate: DateTime.now(),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: false,
                                // This is called when the user changes the time.
                                onDateTimeChanged: (DateTime newTime) {
                                  DateTime dateTime =
                                      DateTime.parse(newTime.toString());
                                  String yourDateTime =
                                      DateFormat('h:mm a').format(dateTime);
                                  setState(() => startTime = yourDateTime);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            ),

                            // Cancel
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, false);
                                  FocusScope.of(context).unfocus();
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text("Confirm".toUpperCase(),
                                        style: TextStyle(
                                            color: Blue_5468ff,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: fontMavenProMedium,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.sp),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, false);
                        startTime = 'Select';
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: // Cancel
                            Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Cancel".toUpperCase(),
                              style: TextStyle(
                                  color: blue_3653f6,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}

class League {
  String TvTitle;
  bool isExpandArrow = false;
  List<Club> listClubs;

  League(this.TvTitle, this.listClubs, this.isExpandArrow);
}

class Club {
  int count;
  String icon;
  String tvLable;

  Club(this.icon, this.tvLable, this.count);
}
