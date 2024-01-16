import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_status_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/home/RatingBarScreen.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../bottomsheets/BottomSheetSupport.dart';

class OrderDetailStatus extends StatefulWidget {
  OrderDetailStatus({Key? key, this.orderId}) : super(key: key);
  String? orderId;

  @override
  State<OrderDetailStatus> createState() => _OrderDetailStatusState();
}

class _OrderDetailStatusState extends State<OrderDetailStatus> {
  // List<HoursModel> onExtraSide = [
  //   HoursModel("Order Received","09:00 PM"),
  //   HoursModel("Preparing Order","-"),
  //   HoursModel("Ready for Pickup","-"),
  //   HoursModel("Order Completed","-"),
  // ];
  //
  // List<TextDto> orderList = [
  //   TextDto("Order Received", "09:00 PM"),
  //
  // ];
  //
  // List<TextDto> shippedList = [
  //   TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
  //   TextDto("Your item has been received in the nearest hub to you.", null),
  // ];
  //
  // List<TextDto> outOfDeliveryList = [
  //   TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
  // ];
  //
  // List<TextDto> deliveredList = [
  //   TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
  // ];

  OrderViewModel orderViewModel = Get.find();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isEdit = false;
  bool isDiscountLayout = false;
  bool isNonApplyLayout = true;
  bool isApplyLayout = false;
  GetOrderDetailStatusResModel? response;

  getOrderDetailStatus() async {
    await orderViewModel
        .getOrderDetailStatus(orderId: widget.orderId!)
        .then((value) {
      response = orderViewModel.addOrderDetailStatusApiResponse.data;
      if (orderViewModel.addOrderDetailStatusApiResponse.status ==
          Status.COMPLETE) {
        if (response!.data!.orderStatus == "PICKED_UP") {
          Future.delayed(
            const Duration(seconds: 5),
            () {
              Get.offAll(RatingBarScreen(
                  type: 'delivery',
                  restoId: response!.data!.restaurantId.toString(),
                  restoName: response!.data!.restaurantData!.restaurantName));
            },
          );
        }
      }
    });
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);

    // Format the date
    String formattedDate = DateFormat('d MMM, yyyy h:mm a').format(date);

    return formattedDate;
  }

  @override
  void initState() {
    getOrderDetailStatus();

    super.initState();
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
        backgroundColor: bg_fafbfb,
        body: GetBuilder<OrderViewModel>(
          builder: (controller) {
            if (controller.addOrderDetailStatusApiResponse.status ==
                Status.LOADING) {
              return const Center(child: CircularIndicator());
            }
            if (controller.addOrderDetailStatusApiResponse.status ==
                Status.ERROR) {
              return const ServerError();
            }
            if (controller.addOrderDetailStatusApiResponse.status ==
                Status.COMPLETE) {
              response = controller.addOrderDetailStatusApiResponse.data;
            }
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.white,
              backgroundColor: Colors.red,
              onRefresh: () {
                return getOrderDetailStatus();
              },
              child: Column(
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
                            "${response!.data!.restaurantData!.restaurantName}",
                            style: TextStyle(
                                fontFamily: fontOverpassBold,
                                color: black_504f58,
                                fontSize: 20.sp),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              selectSupport(context);
                            },
                            child: Image.asset(
                              icon_help_info,
                              width: 24.w,
                              height: 24.h,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*Pick up Layout*/
                            Container(
                              width: double.infinity,
                              decoration: cardboxDecoration,
                              padding: EdgeInsets.all(14.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pickup at: 9:10 PM
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: grey_5f6d7b,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 14.sp),
                                        text: "Pickup at: "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: blue_007add,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        text: response!.data!.time)
                                  ])),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: grey_5f6d7b,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 14.sp),
                                        text: "Order Id: "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        text:
                                            response!.data!.orderId.toString())
                                  ])),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: grey_5f6d7b,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 14.sp),
                                        text: "Name: "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        text: response!.data!.userFullName)
                                  ])),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            color: grey_5f6d7b,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 14.sp),
                                        text: "Order: "),
                                    TextSpan(
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        text: formatDate(
                                            response!.data!.dateCreated!))
                                  ])),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  response!.data!.paymentData!
                                              .randomPaymentId ==
                                          null
                                      ? SizedBox()
                                      : RichText(
                                          text: TextSpan(children: [
                                          TextSpan(
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 14.sp),
                                              text: "Trxn Id: "),
                                          TextSpan(
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 14.sp),
                                              text: response!.data!.paymentData!
                                                  .randomPaymentId
                                                  .toString())
                                        ])),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                  response!.data!.paymentData!.paymentType ==
                                          null
                                      ? SizedBox()
                                      : RichText(
                                          text: TextSpan(children: [
                                          TextSpan(
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 14.sp),
                                              text: "Payment Type: "),
                                          TextSpan(
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 14.sp),
                                              text: response!.data!.paymentData!
                                                  .paymentType)
                                        ])),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            /*Order Status Layout*/
                            Container(
                              width: double.infinity,
                              decoration: cardboxDecoration,
                              padding: EdgeInsets.only(left: 14.w, top: 14.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Order Status
                                  Text("Order Status".toUpperCase(),
                                      style: TextStyle(
                                          color: grey_77879e,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),

                                  response!.data!.orderStatus == "REJECT"
                                      ? AnotherStepper(
                                          stepperList: [
                                            StepperData(
                                                title: StepperText(
                                                  "Order Received",
                                                  textStyle: TextStyle(
                                                      color: black_504f58,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium),
                                                ),
                                                subtitle: StepperText(
                                                  response!.data!.dateCreated ==
                                                          null
                                                      ? ""
                                                      : DateFormat('hh:mm a')
                                                          .format(DateTime.parse(
                                                                  response!
                                                                      .data!
                                                                      .dateCreated!)
                                                              .toLocal()),
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          fontMavenProRegular),
                                                ),
                                                iconWidget: SvgPicture.asset(
                                                  response!.data!.orderStatus ==
                                                              "PAYMENT_COMPLETED" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "REJECT"
                                                      ? icon_active_status
                                                      : icon_inactive_status,
                                                  width: 20.w,
                                                  height: 20.h,
                                                )),
                                            StepperData(
                                                title: StepperText(
                                                  "Order Reject",
                                                  textStyle: TextStyle(
                                                      color: black_504f58,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium),
                                                ),
                                                subtitle: StepperText(
                                                  response!.data!.dateCreated ==
                                                          null
                                                      ? ""
                                                      : DateFormat('hh:mm a')
                                                          .format(DateTime.parse(
                                                                  response!
                                                                      .data!
                                                                      .dateCreated!)
                                                              .toLocal()),
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          fontMavenProRegular),
                                                ),
                                                iconWidget: SvgPicture.asset(
                                                  response!.data!.orderStatus ==
                                                          "REJECT"
                                                      ? icon_active_status
                                                      : icon_inactive_status,
                                                  width: 20.w,
                                                  height: 20.h,
                                                )),
                                          ],
                                          stepperDirection: Axis.vertical,
                                          inverted: false,
                                          activeIndex:
                                              response!.data!.orderStatus ==
                                                      "REJECT"
                                                  ? 1
                                                  : 0,
                                          verticalGap: 25,
                                          inActiveBarColor: divider_d9dde3,
                                          activeBarColor: green_5cb85c,
                                          barThickness: 1,
                                          // response!.data![0].orderStatus=="PAYMENT_COMPLETED"?:
                                        )
                                      : AnotherStepper(
                                          stepperList: [
                                            StepperData(
                                                title: StepperText(
                                                  "Order Received",
                                                  textStyle: TextStyle(
                                                      color: black_504f58,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium),
                                                ),
                                                subtitle: StepperText(
                                                  response!.data!.dateCreated ==
                                                          null
                                                      ? ""
                                                      : "${DateFormat('hh:mm a').format(DateTime.parse(response!.data!.dateCreated!).toLocal())}",
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          fontMavenProRegular),
                                                ),
                                                iconWidget: SvgPicture.asset(
                                                  response!.data!.orderStatus ==
                                                              "PAYMENT_COMPLETED" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "ACCEPT" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "READY" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "PICKED_UP"
                                                      ? icon_active_status
                                                      : icon_inactive_status,
                                                  width: 20.w,
                                                  height: 20.h,
                                                )),
                                            StepperData(
                                                title: StepperText(
                                                  "Preparing Order",
                                                  textStyle: TextStyle(
                                                      color: black_504f58,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium),
                                                ),
                                                subtitle: StepperText(
                                                  response!.data!
                                                              .orderAcceptedTime ==
                                                          null
                                                      ? ""
                                                      : "${DateFormat('hh:mm a').format(DateTime.parse(response!.data!.orderAcceptedTime!))}",
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          fontMavenProRegular),
                                                ),
                                                iconWidget: SvgPicture.asset(
                                                  response!.data!.orderStatus ==
                                                              "ACCEPT" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "READY" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "PICKED_UP"
                                                      ? icon_active_status
                                                      : icon_inactive_status,
                                                  width: 20.w,
                                                  height: 20.h,
                                                )),
                                            StepperData(
                                                title: StepperText(
                                                  "Ready for Pickup",
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          fontMavenProMedium),
                                                ),
                                                subtitle: StepperText(
                                                  response!.data!
                                                              .orderReadyTime ==
                                                          null
                                                      ? ""
                                                      : "${DateFormat('hh:mm a').format(DateTime.parse(response!.data!.orderReadyTime!))}",
                                                  textStyle: TextStyle(
                                                      color: grey_77879e,
                                                      fontSize: 12.sp,
                                                      fontFamily:
                                                          fontMavenProRegular),
                                                ),
                                                iconWidget: SvgPicture.asset(
                                                  response!.data!.orderStatus ==
                                                              "READY" ||
                                                          response!.data!
                                                                  .orderStatus ==
                                                              "PICKED_UP"
                                                      ? icon_active_status
                                                      : icon_inactive_status,
                                                  width: 20.w,
                                                  height: 20.h,
                                                )),
                                            StepperData(
                                              iconWidget: SvgPicture.asset(
                                                response!.data!.orderStatus ==
                                                        "PICKED_UP"
                                                    ? icon_active_status
                                                    : icon_inactive_status,
                                                width: 20.w,
                                                height: 20.h,
                                              ),
                                              title: StepperText(
                                                "Order Completed",
                                                textStyle: TextStyle(
                                                    color: grey_77879e,
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        fontMavenProMedium),
                                              ),
                                              subtitle: StepperText(
                                                response!.data!
                                                            .orderPickupTime ==
                                                        null
                                                    ? ""
                                                    : "${DateFormat('hh:mm a').format(DateTime.parse(response!.data!.orderPickupTime!))}",
                                                textStyle: TextStyle(
                                                    color: grey_77879e,
                                                    fontSize: 12.sp,
                                                    fontFamily:
                                                        fontMavenProRegular),
                                              ),
                                            ),
                                          ],
                                          stepperDirection: Axis.vertical,
                                          inverted: false,
                                          activeIndex: response!
                                                      .data!.orderStatus ==
                                                  "PICKED_UP"
                                              ? 3
                                              : response!.data!.orderStatus ==
                                                      "READY"
                                                  ? 2
                                                  : response!.data!
                                                              .orderStatus ==
                                                          "ACCEPT"
                                                      ? 1
                                                      : 0,
                                          verticalGap: 25,
                                          inActiveBarColor: divider_d9dde3,
                                          activeBarColor: green_5cb85c,
                                          barThickness: 1,
                                          // response!.data![0].orderStatus=="PAYMENT_COMPLETED"?:
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            /*Item Layout*/
                            Container(
                              decoration: cardboxDecoration,
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 14.w, right: 14.w, top: 14.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Item(s)".toUpperCase(),
                                      style: TextStyle(
                                          color: grey_77879e,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.left),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    primary: false,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(top: 16.h),
                                    itemCount: response!.data!.cartData!.length,
                                    itemBuilder: (context, i) => Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SvgPicture.asset(
                                              response!.data!.cartData![i]
                                                          .menuItemName!.type ==
                                                      "veg"
                                                  ? icon_veg
                                                  : icon_nonveg,
                                              width: 18.w,
                                              height: 18.h,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      response!
                                                          .data!
                                                          .cartData![i]
                                                          .menuItemName!
                                                          .name,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          color: black_504f58)),
                                                  SizedBox(
                                                    height: 4.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              response!
                                                                  .data!
                                                                  .cartData![i]
                                                                  .quantity
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      red_dc3642,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          SvgPicture.asset(
                                                              icon_cross),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Image.asset(
                                                            icon_rupee_status,
                                                            width: 10.w,
                                                            height: 10.h,
                                                            color: black_504f58,
                                                          ),
                                                          Text(
                                                              response!
                                                                  .data!
                                                                  .cartData![i]
                                                                  .discountPrice
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right)
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                icon_rupee_slim,
                                                                width: 10.w,
                                                                height: 10.h,
                                                                color:
                                                                    black_504f58,
                                                              ),
                                                              Text(
                                                                  "${response!.data!.cartData![i].quantity * response!.data!.cartData![i].discountPrice}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          black_504f58,
                                                                      fontFamily:
                                                                          fontMavenProBold,
                                                                      fontSize: 13
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right)
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 4.h,
                                                      ),
                                                      // Free Range Poached,White Toast...
                                                      // Text(
                                                      //     "Free Range Poached,White Toast...",
                                                      //     style:  TextStyle(
                                                      //         color:  grey_5f6d7b,
                                                      //         fontFamily: fontMavenProRegular,
                                                      //         fontSize: 12.sp
                                                      //     ),
                                                      //     textAlign: TextAlign.left
                                                      // ),
                                                      SizedBox(
                                                        height: 4.h,
                                                      ),
                                                      response!
                                                                  .data!
                                                                  .cartData![i]
                                                                  .subMenuItem ==
                                                              null
                                                          ? SizedBox()
                                                          : ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: response!
                                                                  .data!
                                                                  .cartData![i]
                                                                  .subMenuItem!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Text(response!
                                                                    .data!
                                                                    .cartData![
                                                                        i]
                                                                    .subMenuItem![
                                                                        index]
                                                                    .name!);
                                                                //   ReadMoreText(
                                                                //   response!
                                                                //       .data!
                                                                //       .cartData![
                                                                //           i]
                                                                //       .subMenuItem![
                                                                //           index]
                                                                //       .name!,
                                                                //   trimLines: 2,
                                                                //   colorClickableText:
                                                                //       grey_5f6d7b,
                                                                //   trimMode:
                                                                //       TrimMode
                                                                //           .Line,
                                                                //   trimCollapsedText:
                                                                //       'View more',
                                                                //   trimExpandedText:
                                                                //       'View less',
                                                                //   lessStyle: TextStyle(
                                                                //       fontSize:
                                                                //           12.sp,
                                                                //       fontFamily:
                                                                //           fontMavenProMedium,
                                                                //       color:
                                                                //           blue_007add),
                                                                //   style: TextStyle(
                                                                //       fontSize:
                                                                //           12.sp,
                                                                //       fontFamily:
                                                                //           fontMavenProRegular,
                                                                //       color:
                                                                //           grey_5f6d7b),
                                                                //   moreStyle: TextStyle(
                                                                //       fontSize:
                                                                //           12.sp,
                                                                //       fontFamily:
                                                                //           fontMavenProMedium,
                                                                //       color:
                                                                //           blue_007add),
                                                                // );
                                                              },
                                                            )
                                                      // Text(
                                                      //     "Edit",
                                                      //     style:  TextStyle(
                                                      //         color:  blue_007add,
                                                      //         fontFamily: fontMavenProMedium,
                                                      //         fontSize: 12.sp
                                                      //     ),
                                                      //     textAlign: TextAlign.left
                                                      // )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 14.h,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                          ],
                                        ),
                                        i ==
                                                response!.data!.cartData!
                                                        .length -
                                                    1
                                            ? SizedBox()
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 26.w),
                                                    child: const DottedLine(
                                                      direction:
                                                          Axis.horizontal,
                                                      lineLength:
                                                          double.infinity,
                                                      lineThickness: 1.0,
                                                      dashLength: 2.0,
                                                      dashColor: divider_d4dce7,
                                                      dashRadius: 0.0,
                                                      dashGapLength: 2.0,
                                                      dashGapColor:
                                                          Colors.transparent,
                                                      dashGapRadius: 0.0,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                ],
                                              )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /*Cooking Instruction Layout*/
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: cardboxDecoration,
                                  padding: EdgeInsets.all(14.r),
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Customer Detail
                                      Text("Cooking Instructions".toUpperCase(),
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      // Make it little spicy
                                      Text(response!.data!.specialRequest,
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            /*Payment Summery Layout*/
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: cardboxDecoration,
                                  padding: EdgeInsets.all(14.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Customer Detail
                                      Text("Payment Summary".toUpperCase(),
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                      SizedBox(
                                        height: 14.h,
                                      ),

                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Sub total",
                                                style: TextStyle(
                                                    color: light_black_5f6d7b,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.left),
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 10.w,
                                                height: 10.h,
                                              ),
                                              Text(
                                                  response!.data!.paymentData!
                                                      .subTotal
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Text(
                                                    "GST (${response!.data!.paymentData!.gst ?? 0}%)",
                                                    style: TextStyle(
                                                        color:
                                                            light_black_5f6d7b,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.left),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                PopupMenuButton(
                                                    padding:
                                                        EdgeInsets.all(0.0),
                                                    offset:
                                                        const Offset(15, -80),
                                                    tooltip: "",
                                                    shadowColor:
                                                        Color(0x60d3d1d8),
                                                    constraints:
                                                        new BoxConstraints(
                                                      maxHeight: 105.0,
                                                      maxWidth: 105.0,
                                                    ),
                                                    itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                              enabled: false,
                                                              value: 1,
                                                              height: 30,
                                                              child: // Edit
                                                                  // CGST(2.5%)
                                                                  Text(
                                                                      "CGST(${response!.data!.paymentData!.cgst ?? 0}%)",
                                                                      style: TextStyle(
                                                                          color:
                                                                              light_black_5f6d7b,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontSize: 12
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left)),
                                                          PopupMenuItem(
                                                              enabled: false,
                                                              value: 2,
                                                              height: 30,
                                                              child: // Edit
                                                                  Text(
                                                                      "SGST(${response!.data!.paymentData!.sgst ?? 0}%)",
                                                                      style: TextStyle(
                                                                          color:
                                                                              light_black_5f6d7b,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontSize: 12
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left)),
                                                        ],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: SvgPicture.asset(
                                                        icon_info_cirlce))
                                              ],
                                            ),
                                          ),
                                          // 250
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 10.w,
                                                height: 10.h,
                                              ),
                                              Text(
                                                  response!.data!.paymentData!
                                                      .gstAmount
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Packing Charges",
                                                style: TextStyle(
                                                    color: light_black_5f6d7b,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.left),
                                          ),
                                          // 250
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 10.w,
                                                height: 10.h,
                                              ),
                                              Text(
                                                  response!.data!.paymentData!
                                                      .packingCharges
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      const DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength: double.infinity,
                                        lineThickness: 1.0,
                                        dashLength: 4.0,
                                        dashColor: divider_d4dce7,
                                        dashRadius: 0.0,
                                        dashGapLength: 4.0,
                                        dashGapColor: Colors.transparent,
                                        dashGapRadius: 0.0,
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Grand Total",
                                                style: TextStyle(
                                                    color: light_black_5f6d7b,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.left),
                                          ),
                                          // 250
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 10.w,
                                                height: 10.h,
                                              ),
                                              Text(
                                                  response!.data!.paymentData!
                                                      .grandTotal
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),

                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Coupon Discount",
                                                style: TextStyle(
                                                    color: green_5cb85c,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.left),
                                          ),
                                          // 250
                                          Row(
                                            children: [
                                              Text("-",
                                                  style: TextStyle(
                                                      color: green_5cb85c,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 10.w,
                                                height: 10.h,
                                                color: green_5cb85c,
                                              ),
                                              Text("50",
                                                  style: TextStyle(
                                                      color: green_5cb85c,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Net Payable",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProProSemiBold,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left),
                                          ),
                                          // Paid
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                                color: Color(0x215cb85c)),
                                            child: Text("PAID",
                                                style: TextStyle(
                                                    color: green_5cb85c,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.sp),
                                                textAlign: TextAlign.right),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          // 250
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 12.w,
                                                height: 12.h,
                                              ),
                                              Text(
                                                  response!.data!.paymentData!
                                                      .netPayable
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.left),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void selectSupport(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [BottomSheetSupport()],
              ),
            ));
      });
}
