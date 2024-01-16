import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/box_shadow_ticket_inactive_second.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Model/HoursModel.dart';
import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button.dart';
import '../Widget/box_shadow_ticket.dart';
import '../Widget/box_shadow_ticket_inactive.dart';
import '../Widget/box_shadow_ticket_second.dart';
import '../Widget/search_bar.dart';
import '../Widget/toolbar_with_search.dart';
import '../Widget/toolbar_with_title.dart';
import '../modal/apiModel/response_modal/get_booking_order_detail_res.dart';
import 'bottomsheets/BottomSheetBestDeal.dart';
import 'bottomsheets/BottomSheetCallRestaurant.dart';
import 'bottomsheets/BottomSheetCancel.dart';
import 'bottomsheets/BottomSheetMoreOption.dart';
import 'RedeemOfferDetailPage.dart';
import '../Widget/common_red_button.dart';
import '../Widget/common_verify_red_button.dart';

class RedeemDineInBookingDetailInActive extends StatefulWidget {
  RedeemDineInBookingDetailInActive({Key? key, required this.response})
      : super(key: key);
  Data response;

  @override
  State<RedeemDineInBookingDetailInActive> createState() =>
      _RedeemDineInBookingDetailInActiveState();
}

class _RedeemDineInBookingDetailInActiveState
    extends State<RedeemDineInBookingDetailInActive> {
  int mypostion = 0;
  OrderViewModel orderViewModel = Get.find();
  bool isOpen = false;
  // GetBookingOrderDetailResModel? response;
  Map<String, dynamic>? currentData;
  String? formattedDateTime;

  // getBookingOrderDetailApiCall() async {
  //   await orderViewModel.getBookingOrderViewModel(orderId: "76").then((value) {
  //     if (orderViewModel.getBookingOrderDetailApiResponse.status ==
  //         Status.COMPLETE) {
  //       response = orderViewModel.getBookingOrderDetailApiResponse.data;
  //
  //       fetchDate();
  //     }
  //   });
  // }
  fetchDate() {
    int currentDayIndex;
    if (widget.response.restaurantData!.hours != null ||
        widget.response.restaurantData!.hours!.isNotEmpty) {
      String day = DateFormat.EEEE().format(DateTime.now()).toLowerCase();
      Map<String, dynamic> hoursJson =
          widget.response.restaurantData!.hours!.first.toJson();

      /// key
      List<dynamic> key = hoursJson.keys.toList();

      currentDayIndex = key.indexWhere((element) => element == day);

      ///value
      List<dynamic> value = hoursJson.values.toList();

      currentData = value[currentDayIndex];
      // closeDate = currentData['to'];
      // openDate = currentData['from'];
    }
  }

  formattedDate() {
    DateTime createdDate = DateTime.parse(widget.response.dateCreated!);

    String formattedDate = DateFormat('dd/MM/yyyy').format(createdDate);
    String formattedTime = DateFormat('h:mm a').format(createdDate);

    formattedDateTime = '$formattedDate at $formattedTime';
  }

  @override
  void initState() {
    formattedDate();
    fetchDate();
    // getBookingOrderDetailApiCall();
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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: SvgPicture.asset(icon_cancel)),
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Image.asset(bluedip_app_icon_second,width: 60.w,height: 60.h),
                    //     // Bluedip
                    //     Text(
                    //         "Bluedip",
                    //         style:  TextStyle(
                    //             color:  red_dc3642,
                    //             fontFamily: fontOverpassBold,
                    //             fontSize: 20.sp
                    //         ),
                    //         textAlign: TextAlign.center
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: boxDecorationTicketInActive,
                              padding: EdgeInsets.only(
                                  left: 18.w,
                                  right: 18.w,
                                  top: 18.h,
                                  bottom: 20..h),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: widget.response.restaurantData!
                                                .restaurantImg ==
                                            null
                                        ? Image.asset(
                                            "assets/images/bluedip_app_icon_second.png",
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover)
                                        : Image.network(
                                            "https://bluedip.s3.ap-south-1.amazonaws.com/images/${widget.response.restaurantData!.restaurantImg!}",
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover),

                                    // Image.asset(
                                    //   img_pizza_food_buddy,
                                    //   width: 98.h,
                                    //   height: 98.h,
                                    //   fit: BoxFit.cover,
                                    // )
                                  ),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          widget.response.restaurantData!
                                                  .restaurantName ??
                                              "",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProBold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18.sp),
                                          textAlign: TextAlign.center),
                                      // 20% OFF
                                      Text(
                                          "${widget.response.offerData!.offerPercentage} OFF",
                                          style: TextStyle(
                                              color: green_5cb85c,
                                              fontFamily: fontOverpassBold,
                                              fontSize: 28.sp),
                                          textAlign: TextAlign.center),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                          "Hours: ${currentData!['from']}-${currentData!['to']}",
                                          style: TextStyle(
                                              color: grey_5f6d7b,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            Container(
                              color: Color(0xfff0f0f0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(16.r),
                                              bottomRight:
                                                  Radius.circular(16.r)),
                                          color: Colors.white),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Color(0xffaeaeae),
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Text("Deal Inactive",
                                      style: TextStyle(
                                          color: red_dc3642,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: fontMavenProBold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: DottedLine(
                                      direction: Axis.horizontal,
                                      lineLength: double.infinity,
                                      lineThickness: 1.0,
                                      dashLength: 4.0,
                                      dashColor: Color(0xffaeaeae),
                                      dashRadius: 0.0,
                                      dashGapLength: 4.0,
                                      dashGapColor: Colors.transparent,
                                      dashGapRadius: 0.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              bottomLeft:
                                                  Radius.circular(16.r)),
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Booking Details
                            Container(
                              decoration: boxDecorationTicketSecondInActive,
                              padding: EdgeInsets.only(
                                  left: 18.w,
                                  right: 14.w,
                                  top: 20.h,
                                  bottom: 16..h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text("Booking Details",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontOverpassBold,
                                            fontSize: 18.sp),
                                        textAlign: TextAlign.center),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Coupon Type",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("${widget.response.orderType}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Booking Time",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("${widget.response.time}, Today",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Party of",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text(
                                          "${widget.response.noOfGuest} People",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Name",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("${widget.response.userFullName}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Phone",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("${widget.response.mobileNumber}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Redeem Time",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("$formattedDateTime",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Special Request",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      // Dine in
                                      Text("${widget.response.specialRequest}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.right)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 10.h,
                        ),

                        Row(
                          children: [
                            // Edit Info
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(0xfff0f0f0)),
                                  child: Text("Edit Info",
                                      style: TextStyle(
                                          color: blue_007add,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Color(0xfff0f0f0)),
                                  child: Text("More Options",
                                      style: TextStyle(
                                          color: blue_007add,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(
                          height: 24.h,
                        ),

                        // Experiencing an issue?
                        Center(
                          child: Text("Experiencing an issue?",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProMedium,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),

                        Text(
                            "Offers is valid on all full-priced menu item, including drinks. May not be valid in conjunction with other offers ₹500 minimum spend",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProRegular,
                                fontSize: 14.sp,
                                height: 1.5),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
