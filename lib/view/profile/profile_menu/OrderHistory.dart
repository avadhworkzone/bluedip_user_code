import 'dart:async';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/dinein_order_history_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/tack_order_history_res.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/Widget/cooking_instruction_widget.dart';
import 'package:bluedip_user/Widget/payment_summery_widget.dart';
import 'package:bluedip_user/Widget/toolbar_with_title_shadow.dart';
import 'package:bluedip_user/view/home/RatingBarScreen.dart';
import 'package:bluedip_user/view/order/OrderDetailStatus.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:readmore/readmore.dart';

import '../../../Model/HoursModel.dart';
import '../../../Model/RedeemOferDetailModel.dart';
import '../../../Styles/my_strings.dart';
import '../../../Widget/Textfield.dart';
import '../../../Widget/back_button.dart';
import '../../../Widget/box_shadow_ticket.dart';
import '../../../Widget/box_shadow_ticket_second.dart';
import '../../../Widget/search_bar.dart';
import '../../../Widget/toolbar_with_search.dart';
import '../../../Widget/toolbar_with_title.dart';
import '../../bottomsheets/BottomSheetBestDeal.dart';
import '../../bottomsheets/BottomSheetSupport.dart';
import '../../OrderHistoryDineinTab.dart';
import '../../OrderHistoryTakeawayTab.dart';
import '../../RedeemOfferDetailPage.dart';
import '../../../Widget/common_red_button.dart';
import '../../../Widget/common_verify_red_button.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int mySelectConsultation = 0;
  OrderViewModel orderViewModel = Get.find();
  TackAwayOrderHistoryResModel? response;
  DineInOrderHistoryResModel? dineInRes;
  int activeTabIndex = 0;
  String selectedDay = "";
  List<CityListModel> dayList = [
    CityListModel("20% OFF"),
    CityListModel("20% OFF"),
  ];
  List<CityListModel> typeList = [
    CityListModel("Completed"),
    CityListModel("Cancelled"),
  ];
  List<CityListModel> onOfferModel = [
    CityListModel("Today"),
    CityListModel("Last 7 Days"),
    CityListModel("Last 1 Month"),
    CityListModel("Last 3 Month"),
  ];

  getTOrderHistory() async {
    await orderViewModel.tOrderHistoryViewModel(sorting: "today");
  }

  @override
  void initState() {
    getTOrderHistory();
    // TODO: implement initState
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
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
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
                  padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 16.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
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
                            width: 15.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Order",
                              style: TextStyle(
                                  fontFamily: fontOverpassBold,
                                  color: black_504f58,
                                  fontSize: 20.sp),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                selectSortBy(context);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.r),
                                  border:
                                      Border.all(width: 1, color: grey_d9dde3),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 5.h),
                                child: Row(
                                  children: [
                                    // Today
                                    Text(
                                        onOfferModel[mySelectConsultation]
                                            .title,
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.left),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    SvgPicture.asset(icon_down_arrow)
                                  ],
                                ),
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: divider_d9dde3,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        // margin: EdgeInsets.only(left: 32.w,right: 0.w),
                        height: 35.h,
                        color: Colors.white,
                        width: double.infinity,
                        child: TabBar(
                          onTap: (val) async {
                            activeTabIndex = val;
                            if (activeTabIndex == 0) {
                              mySelectConsultation = 0;
                              getTOrderHistory();
                              setState(() {});
                            } else {
                              mySelectConsultation = 0;
                              await orderViewModel.dOrderHistoryViewModel(
                                  sorting: 'today');
                              setState(() {});
                            }
                          },
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          labelPadding: EdgeInsets.zero,
                          isScrollable: true,
                          labelColor: Colors.white,

                          unselectedLabelColor: grey_969da8,

                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: blue_007add),
                          tabs: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: const Tab(
                                child: Text("Takeaway"),
                              ),
                            ),

                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: const Text("Dine-in"),
                              ),
                            ),

                            // Tab(
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 14.w),
                            //     child: const Text("Offline Takeaway"),
                            //   ),
                            // ),
                          ],
                          // indicatorWeight: 10,
                          labelStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily:
                                  fontMavenProMedium), //For Selected tab
                          unselectedLabelStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily:
                                  fontMavenProMedium), //For Un-selected Tabs
                        ),
                      ),
                    ],
                  ),
                ),
                if (activeTabIndex == 0)
                  Expanded(
                      // flex: 1,
                      child: SingleChildScrollView(
                    child: GetBuilder<OrderViewModel>(
                      builder: (controller) {
                        if (controller.tOrderHistoryApiResponse.status ==
                            Status.LOADING) {
                          return const CircularIndicator();
                        }
                        if (controller.tOrderHistoryApiResponse.status ==
                            Status.ERROR) {
                          return const ServerError();
                        }
                        if (controller.tOrderHistoryApiResponse.status ==
                            Status.COMPLETE) {
                          response = controller.tOrderHistoryApiResponse.data;
                        }
                        return response!.data!.activeBooking == null &&
                                response!.data!.previousBooking == null
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.65,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      img_no_orders,
                                      width: 170.w,
                                      height: 152.h,
                                      fit: BoxFit.fill,
                                    )),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    // No Orders
                                    Text("No Orders",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProBold,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // You don’t have any orders in your history
                                    Text(
                                        "You don’t have any orders in your history ",
                                        style: TextStyle(
                                            color: grey_77879e,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 12.sp),
                                        textAlign: TextAlign.center)
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SearchBarWidget(
                                      hintText: strSearch,
                                      onSubmitted: (val) {},
                                      onChanged: (val) async {
                                        await orderViewModel
                                            .tOrderHistoryViewModel(
                                                sorting: mySelectConsultation ==
                                                        0
                                                    ? "today"
                                                    : mySelectConsultation == 1
                                                        ? "last_week"
                                                        : mySelectConsultation ==
                                                                2
                                                            ? "last_month"
                                                            : "last_three_month",
                                                keyWord: val);
                                      },
                                    ),

                                    /// empty
                                    // SizedBox(
                                    //   height: MediaQuery.of(context).size.height / 1.65,
                                    //   child: Column(
                                    //     mainAxisAlignment: MainAxisAlignment.center,
                                    //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //     children: [
                                    //       Center(
                                    //           child: Image.asset(
                                    //         img_no_orders,
                                    //         width: 170.w,
                                    //         height: 152.h,
                                    //         fit: BoxFit.fill,
                                    //       )),
                                    //       SizedBox(
                                    //         height: 30.h,
                                    //       ),
                                    //       // No Orders
                                    //       Text("No Orders",
                                    //           style: TextStyle(
                                    //               color: black_504f58,
                                    //               fontFamily: fontMavenProBold,
                                    //               fontSize: 16.sp),
                                    //           textAlign: TextAlign.center),
                                    //       SizedBox(
                                    //         height: 10.h,
                                    //       ),
                                    //       // You don’t have any orders in your history
                                    //       Text("You don’t have any orders in your history ",
                                    //           style: TextStyle(
                                    //               color: grey_77879e,
                                    //               fontFamily: fontMavenProRegular,
                                    //               fontSize: 12.sp),
                                    //           textAlign: TextAlign.center)
                                    //     ],
                                    //   ),
                                    // ),

                                    SizedBox(
                                      height: 20.h,
                                    ),

                                    /// active orders
                                    response!.data!.activeBooking == null
                                        ? const SizedBox()
                                        : Text("Active Orders",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProBold,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.left),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    /*Active Order ListView*/
                                    if (response!.data!.activeBooking == null)
                                      const SizedBox()
                                    else
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: response!
                                            .data!.activeBooking!.length,
                                        itemBuilder: (context, i) {
                                          final data =
                                              response!.data!.activeBooking![i];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 16.w),
                                            child: Container(
                                              decoration: boxDecorationTicket,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // 20% OFF
                                                      Text(
                                                          "${data.offerData!.offerPercentage ?? ""} OFF",
                                                          style: TextStyle(
                                                              color: red_dc3642,
                                                              fontFamily:
                                                                  fontOverpassBold,
                                                              fontSize: 18.sp),
                                                          textAlign:
                                                              TextAlign.left),

                                                      // Offer valid between 12:30 - 7:00pm
                                                      data.offerData!.offerValid ==
                                                              null
                                                          ? const SizedBox()
                                                          : Text(
                                                              "Offer valid between \n${data.offerData!.offerValid!.start} - ${data.offerData!.offerValid!.end}",
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProRegular,
                                                                  fontSize:
                                                                      12.sp,
                                                                  height: 1.5),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 25.h,
                                                        width: 15.w,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          16.r),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          16.r)),
                                                              color: bg_fafbfb),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.r),
                                                          child: LayoutBuilder(
                                                              builder: (context,
                                                                  constraints) {
                                                            return Flex(
                                                                direction: Axis
                                                                    .horizontal,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: List
                                                                    .generate(
                                                                        (constraints.constrainWidth() /
                                                                                10)
                                                                            .floor(),
                                                                        (index) =>
                                                                            const SizedBox(
                                                                              height: 1,
                                                                              width: 4,
                                                                              child: DecoratedBox(
                                                                                decoration: BoxDecoration(color: divider_d9dde3),
                                                                              ),
                                                                            )));
                                                          }),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 25.h,
                                                        width: 15.w,
                                                        child: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          16.r),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          16.r)),
                                                              color: bg_fafbfb),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.h,
                                                        left: 14.w,
                                                        right: 14.w,
                                                        bottom: 14.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            child: data.restaurantData!
                                                                        .restaurantImg ==
                                                                    null
                                                                ? Image.asset(
                                                                    img_ice_cream,
                                                                    width: 86.w,
                                                                    height:
                                                                        86.h,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )
                                                                : Image.network(
                                                                    "${data.restaurantData!.restaurantImg!}",
                                                                    width: 86.w,
                                                                    height:
                                                                        86.h,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  )),
                                                        SizedBox(
                                                          width: 14.w,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Heaven’s Food
                                                              Text(
                                                                  data.restaurantData!
                                                                          .restaurantName ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      color:
                                                                          black_504f58,
                                                                      fontFamily:
                                                                          fontMavenProProSemiBold,
                                                                      fontSize: 15
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                              SizedBox(
                                                                height: 4.h,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  data.restaurantLocationData!
                                                                              .address ==
                                                                          null
                                                                      ? SizedBox()
                                                                      : SvgPicture
                                                                          .asset(
                                                                          icon_location_pin_account,
                                                                          width:
                                                                              16.w,
                                                                          height:
                                                                              16.h,
                                                                        ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      "${data.restaurantLocationData!.address ?? ""} ${data.restaurantLocationData!.address == null ? '' : ','} ${data.restaurantLocationData!.cityName ?? ""}",
                                                                      style: TextStyle(
                                                                          color:
                                                                              grey_77879e,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.to(
                                                                      OrderDetailStatus(
                                                                    orderId: data
                                                                        .orderId
                                                                        .toString(),
                                                                  ));
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.r),
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color:
                                                                            grey_d9dde3),
                                                                  ),
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          4.h),
                                                                  child: // Track Order
                                                                      Text(
                                                                          "Track Order",
                                                                          style: TextStyle(
                                                                              color: blue_007add,
                                                                              fontFamily: fontMavenProMedium,
                                                                              fontSize: 14.sp),
                                                                          textAlign: TextAlign.left),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    SizedBox(
                                      height: 4.h,
                                    ),

                                    /// Previous Order
                                    response!.data!.previousBooking == null
                                        ? const SizedBox()
                                        : Text("Previous Orders",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProBold,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.left),
                                    SizedBox(
                                      height: 16.h,
                                    ),

                                    response!.data!.previousBooking == null
                                        ? const SizedBox()
                                        : ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: response!
                                                .data!.previousBooking!.length,
                                            itemBuilder: (context, i) {
                                              final previousBData = response!
                                                  .data!.previousBooking![i];
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 16.w),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      decoration:
                                                          boxDecorationTicket,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 14.w,
                                                                right: 14.w,
                                                                top: 14.h,
                                                                bottom: 5.h),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // 20% OFF
                                                            Text(
                                                                "${previousBData.offerData!.offerPercentage} OFF",
                                                                style: TextStyle(
                                                                    color:
                                                                        red_dc3642,
                                                                    fontFamily:
                                                                        fontOverpassBold,
                                                                    fontSize:
                                                                        18.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),

                                                            // Completed
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(6
                                                                              .r),
                                                                  color: previousBData
                                                                              .orderStatus ==
                                                                          "PICKED_UP"
                                                                      ? green_5cb85c
                                                                      : red_dc3642),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          4.h),
                                                              child: Text(
                                                                  previousBData
                                                                              .orderStatus ==
                                                                          "PICKED_UP"
                                                                      ? "Completed"
                                                                      : "Cancelled",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize: 14
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      color: Colors.white,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 25.h,
                                                            width: 15.w,
                                                            child: DecoratedBox(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(16
                                                                              .r),
                                                                      bottomRight:
                                                                          Radius.circular(16
                                                                              .r)),
                                                                  color:
                                                                      bg_fafbfb),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.r),
                                                              child: LayoutBuilder(
                                                                  builder: (context,
                                                                      constraints) {
                                                                return Flex(
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: List.generate(
                                                                        (constraints.constrainWidth() / 10).floor(),
                                                                        (index) => const SizedBox(
                                                                              height: 1,
                                                                              width: 4,
                                                                              child: DecoratedBox(
                                                                                decoration: BoxDecoration(color: divider_d9dde3),
                                                                              ),
                                                                            )));
                                                              }),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 25.h,
                                                            width: 15.w,
                                                            child: DecoratedBox(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(16
                                                                              .r),
                                                                      bottomLeft:
                                                                          Radius.circular(16
                                                                              .r)),
                                                                  color:
                                                                      bg_fafbfb),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration:
                                                          boxDecorationTicketSecond,
                                                      child: Column(
                                                        // mainAxisAlignment:
                                                        //     MainAxisAlignment.start,
                                                        // crossAxisAlignment:
                                                        //     CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.h,
                                                                    left: 14.w,
                                                                    right: 14.w,
                                                                    bottom:
                                                                        14.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(10
                                                                            .r),
                                                                    child: previousBData.restaurantData!.restaurantImg ==
                                                                            null
                                                                        ? Image
                                                                            .asset(
                                                                            img_ice_cream,
                                                                            width:
                                                                                86.w,
                                                                            height:
                                                                                86.h,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            previousBData.restaurantData!.restaurantImg!,
                                                                            width:
                                                                                86.w,
                                                                            height:
                                                                                86.h,
                                                                            fit:
                                                                                BoxFit.fill,
                                                                          )),
                                                                SizedBox(
                                                                  width: 14.w,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // Heaven’s Food
                                                                      Text(
                                                                          previousBData.restaurantData!.restaurantName ??
                                                                              "",
                                                                          style: TextStyle(
                                                                              color: black_504f58,
                                                                              fontFamily: fontMavenProProSemiBold,
                                                                              fontSize: 15.sp),
                                                                          textAlign: TextAlign.left),
                                                                      SizedBox(
                                                                        height:
                                                                            4.h,
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            icon_location_pin_account,
                                                                            width:
                                                                                16.w,
                                                                            height:
                                                                                16.h,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                2.w,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text("${previousBData.restaurantLocationData!.address}, ${previousBData.restaurantLocationData!.cityName}", style: TextStyle(color: grey_77879e, fontFamily: fontMavenProMedium, fontSize: 14.sp)),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            12.h,
                                                                      ),

                                                                      previousBData.rating ==
                                                                              null
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => RatingBarScreen(type: "delivery", restoId: previousBData.restaurantData!.restaurantId!, restoName: previousBData.restaurantData!.restaurantName!, isNavigateHistory: true),
                                                                                    ));
                                                                              },
                                                                              child: Row(
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    icon_yellow_rating_bar,
                                                                                    width: 20.w,
                                                                                    height: 20.h,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5.w,
                                                                                  ),
                                                                                  // 4.5
                                                                                  Text("Add Review", style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.center)
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Row(
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  icon_small_rating_bar,
                                                                                  width: 20.w,
                                                                                  height: 20.h,
                                                                                  color: const Color(0xffffc529),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                // 4.5
                                                                                Text(previousBData.rating.toString(), style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.center)
                                                                              ],
                                                                            )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                  ],
                                ),
                              );
                      },
                    ),
                  )
                      // TabBarView(
                      //   physics: ScrollPhysics(),
                      //   // controller: _tabController,
                      //   children: [
                      //     OrderHistoryTakeawayTab(),
                      //     OrderHistoryDineinTab(),
                      //     //  OrderHistoryOfflineTab(),
                      //   ],
                      // ),
                      ),

                /// booking
                if (activeTabIndex == 1)
                  Expanded(
                      // flex: 1,
                      child: SingleChildScrollView(
                    child: GetBuilder<OrderViewModel>(
                      builder: (controller) {
                        if (controller.dOrderHistoryApiResponse.status ==
                            Status.LOADING) {
                          return const CircularIndicator();
                        }
                        if (controller.dOrderHistoryApiResponse.status ==
                            Status.ERROR) {
                          return const ServerError();
                        }
                        if (controller.dOrderHistoryApiResponse.status ==
                            Status.COMPLETE) {
                          dineInRes = controller.dOrderHistoryApiResponse.data;
                        }
                        return dineInRes!.data!.activeBooking == null &&
                                dineInRes!.data!.previousBooking == null
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.65,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      img_no_orders,
                                      width: 170.w,
                                      height: 152.h,
                                      fit: BoxFit.fill,
                                    )),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    // No Orders
                                    Text("No Orders",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProBold,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // You don’t have any orders in your history
                                    Text(
                                        "You don’t have any orders in your history ",
                                        style: TextStyle(
                                            color: grey_77879e,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 12.sp),
                                        textAlign: TextAlign.center)
                                  ],
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SearchBarWidget(
                                      hintText: strSearch,
                                      onSubmitted: (String) {},
                                      onChanged: (val) async {
                                        await orderViewModel
                                            .dOrderHistoryViewModel(
                                                sorting: mySelectConsultation ==
                                                        0
                                                    ? "today"
                                                    : mySelectConsultation == 1
                                                        ? "last_week"
                                                        : mySelectConsultation ==
                                                                2
                                                            ? "last_month"
                                                            : "last_three_month",
                                                keyWord: val);
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        // Active Orders
                                        dineInRes!.data!.activeBooking == null
                                            ? const SizedBox()
                                            : Text("Active Booking",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProBold,
                                                    fontSize: 16.sp),
                                                textAlign: TextAlign.left),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        dineInRes!.data!.activeBooking == null
                                            ? const SizedBox()
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: dineInRes!.data!
                                                    .activeBooking!.length,
                                                itemBuilder: (context, i) {
                                                  final activeBData = dineInRes!
                                                      .data!.activeBooking![i];
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 16.w),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              boxDecorationTicket,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 14.w,
                                                                    right: 14.w,
                                                                    top: 14.h,
                                                                    bottom:
                                                                        5.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // 20% OFF
                                                                Text(
                                                                    "${activeBData.offerData!.offerPercentage} OFF",
                                                                    style: TextStyle(
                                                                        color:
                                                                            red_dc3642,
                                                                        fontFamily:
                                                                            fontOverpassBold,
                                                                        fontSize: 18
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),

                                                                // Offer valid between 12:30 - 7:00pm
                                                                Text(
                                                                    "Offer valid between \n${activeBData.offerData!.offerValid!.start} - ${activeBData.offerData!.offerValid!.end}",
                                                                    style: TextStyle(
                                                                        color:
                                                                            black_504f58,
                                                                        fontFamily:
                                                                            fontMavenProRegular,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        height:
                                                                            1.5),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          color: Colors.white,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 25.h,
                                                                width: 15.w,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(16
                                                                              .r),
                                                                          bottomRight: Radius.circular(16
                                                                              .r)),
                                                                      color:
                                                                          bg_fafbfb),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .r),
                                                                  child: LayoutBuilder(
                                                                      builder:
                                                                          (context,
                                                                              constraints) {
                                                                    return Flex(
                                                                        direction:
                                                                            Axis
                                                                                .horizontal,
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: List.generate(
                                                                            (constraints.constrainWidth() / 10).floor(),
                                                                            (index) => const SizedBox(
                                                                                  height: 1,
                                                                                  width: 4,
                                                                                  child: DecoratedBox(
                                                                                    decoration: BoxDecoration(color: divider_d9dde3),
                                                                                  ),
                                                                                )));
                                                                  }),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 25.h,
                                                                width: 15.w,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(16
                                                                              .r),
                                                                          bottomLeft: Radius.circular(16
                                                                              .r)),
                                                                      color:
                                                                          bg_fafbfb),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              boxDecorationTicketSecond,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            8.h,
                                                                        left: 14
                                                                            .w,
                                                                        right: 14
                                                                            .w,
                                                                        bottom:
                                                                            14.h),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10
                                                                                .r),
                                                                        child: activeBData.restaurantData!.restaurantImg == null ||
                                                                                activeBData.restaurantData!.restaurantImg == ""
                                                                            ? Image.asset(
                                                                                bluedip_app_icon,
                                                                                width: 86.w,
                                                                                height: 86.h,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                            : Image.network(
                                                                                "${activeBData.restaurantData!.restaurantImg!}",
                                                                                width: 86.w,
                                                                                height: 86.h,
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                    SizedBox(
                                                                      width:
                                                                          14.w,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // Heaven’s Food
                                                                          Text(
                                                                              activeBData.restaurantData!.restaurantName ?? "",
                                                                              style: TextStyle(color: black_504f58, fontFamily: fontMavenProProSemiBold, fontSize: 15.sp),
                                                                              textAlign: TextAlign.left),
                                                                          SizedBox(
                                                                            height:
                                                                                4.h,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                icon_location_pin_account,
                                                                                width: 16.w,
                                                                                height: 16.h,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 2.w,
                                                                              ),
                                                                              Expanded(
                                                                                child: Text("${activeBData.restaurantLocationData!.address}, ${activeBData.restaurantLocationData!.cityName}", style: TextStyle(color: grey_77879e, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.left),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10.h,
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // Navigator.push(
                                                                              //     context,
                                                                              //     MaterialPageRoute(
                                                                              //       builder: (context) =>
                                                                              //           RedeemDineInBookingDetail(),
                                                                              //     ));
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(6.r),
                                                                                border: Border.all(width: 1, color: grey_d9dde3),
                                                                              ),
                                                                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                                                              child: // Track Order
                                                                                  Text("View Voucher", style: TextStyle(color: blue_007add, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.left),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                        SizedBox(
                                          height: 4.h,
                                        ),

                                        // Active Orders
                                        dineInRes!.data!.previousBooking == null
                                            ? const SizedBox()
                                            : Text("Previous Booking",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProBold,
                                                    fontSize: 16.sp),
                                                textAlign: TextAlign.left),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        dineInRes!.data!.previousBooking == null
                                            ? const SizedBox()
                                            : ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: dineInRes!.data!
                                                    .previousBooking!.length,
                                                itemBuilder: (context, i) {
                                                  final previousBData =
                                                      dineInRes!.data!
                                                          .previousBooking![i];
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 16.w),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              boxDecorationTicket,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 14.w,
                                                                    right: 14.w,
                                                                    top: 14.h,
                                                                    bottom:
                                                                        5.h),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // 20% OFF
                                                                Text(
                                                                    "${previousBData.offerData!.offerPercentage} OFF",
                                                                    style: TextStyle(
                                                                        color:
                                                                            red_dc3642,
                                                                        fontFamily:
                                                                            fontOverpassBold,
                                                                        fontSize: 18
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),

                                                                // Completed
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(6
                                                                              .r),
                                                                      color: previousBData.orderStatus == "CANCEL_BOOKING" ||
                                                                              previousBData.orderStatus == "REJECT"
                                                                          ? red_dc3642
                                                                          : green_5cb85c),
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          4.h),
                                                                  child: Text(
                                                                      previousBData.orderStatus == "CANCEL_BOOKING" ||
                                                                              previousBData.orderStatus ==
                                                                                  "REJECT"
                                                                          ? "Cancelled"
                                                                          : "Completed",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontSize: 14
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          color: Colors.white,
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 25.h,
                                                                width: 15.w,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(16
                                                                              .r),
                                                                          bottomRight: Radius.circular(16
                                                                              .r)),
                                                                      color:
                                                                          bg_fafbfb),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(8
                                                                              .r),
                                                                  child: LayoutBuilder(
                                                                      builder:
                                                                          (context,
                                                                              constraints) {
                                                                    return Flex(
                                                                        direction:
                                                                            Axis
                                                                                .horizontal,
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: List.generate(
                                                                            (constraints.constrainWidth() / 10).floor(),
                                                                            (index) => const SizedBox(
                                                                                  height: 1,
                                                                                  width: 5,
                                                                                  child: DecoratedBox(
                                                                                    decoration: BoxDecoration(color: divider_d9dde3),
                                                                                  ),
                                                                                )));
                                                                  }),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 25.h,
                                                                width: 15.w,
                                                                child:
                                                                    DecoratedBox(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(16
                                                                              .r),
                                                                          bottomLeft: Radius.circular(16
                                                                              .r)),
                                                                      color:
                                                                          bg_fafbfb),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              boxDecorationTicketSecond,
                                                          child: Column(
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment.start,
                                                            // crossAxisAlignment:
                                                            //     CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            8.h,
                                                                        left: 14
                                                                            .w,
                                                                        right: 14
                                                                            .w,
                                                                        bottom:
                                                                            14.h),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10
                                                                                .r),
                                                                        child: previousBData.restaurantData!.restaurantImg == null ||
                                                                                previousBData.restaurantData!.restaurantImg == ""
                                                                            ? Image.asset(
                                                                                bluedip_app_icon,
                                                                                width: 86.w,
                                                                                height: 86.h,
                                                                                fit: BoxFit.fill,
                                                                              )
                                                                            : Image.network(
                                                                                "${previousBData.restaurantData!.restaurantImg!}",
                                                                                width: 86.w,
                                                                                height: 86.h,
                                                                                fit: BoxFit.fill,
                                                                              )),
                                                                    SizedBox(
                                                                      width:
                                                                          14.w,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          // Heaven’s Food
                                                                          Text(
                                                                              previousBData.restaurantData!.restaurantName ?? "",
                                                                              style: TextStyle(color: black_504f58, fontFamily: fontMavenProProSemiBold, fontSize: 15.sp),
                                                                              textAlign: TextAlign.left),
                                                                          SizedBox(
                                                                            height:
                                                                                4.h,
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                icon_location_pin_account,
                                                                                width: 16.w,
                                                                                height: 16.h,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 2.w,
                                                                              ),
                                                                              Expanded(
                                                                                child: Text("${previousBData.restaurantLocationData!.address}, ${previousBData.restaurantLocationData!.cityName}", style: TextStyle(color: grey_77879e, fontFamily: fontMavenProMedium, fontSize: 14.sp)),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                12.h,
                                                                          ),

                                                                          previousBData.rating == null
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => RatingBarScreen(type: "delivery", restoId: previousBData.restaurantData!.restaurantId!, restoName: previousBData.restaurantData!.restaurantName!, isNavigateHistory: true),
                                                                                        ));
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      SvgPicture.asset(
                                                                                        icon_yellow_rating_bar,
                                                                                        width: 20.w,
                                                                                        height: 20.h,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 5.w,
                                                                                      ),
                                                                                      // 4.5
                                                                                      Text("Add Review", style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.center)
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : Row(
                                                                                  children: [
                                                                                    SvgPicture.asset(
                                                                                      icon_small_rating_bar,
                                                                                      width: 20.w,
                                                                                      height: 20.h,
                                                                                      color: const Color(0xffffc529),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 5.w,
                                                                                    ),
                                                                                    // 4.5
                                                                                    Text(previousBData.rating.toString(), style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontSize: 14.sp), textAlign: TextAlign.center)
                                                                                  ],
                                                                                )
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  )
                      // TabBarView(
                      //   physics: ScrollPhysics(),
                      //   // controller: _tabController,
                      //   children: [
                      //     OrderHistoryTakeawayTab(),
                      //     OrderHistoryDineinTab(),
                      //     //  OrderHistoryOfflineTab(),
                      //   ],
                      // ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectSortBy(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r))),
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
                                      child: Text("Sort by",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProBold,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.sp),
                                          textAlign: TextAlign.center),
                                    ),

                                    SizedBox(
                                      height: 20.h,
                                    ),

                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: divider_d4dce7,
                                    ),

                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        primary: false,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                        ),
                                        itemCount: onOfferModel.length,
                                        itemBuilder: (context, i) =>
                                            GestureDetector(
                                              onTap: () {
                                                setModalState(
                                                  () {
                                                    mySelectConsultation = i;
                                                    selectedDay =
                                                        (onOfferModel[i].title);
                                                  },
                                                );
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16,
                                                    top: 11,
                                                    bottom: 11),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SvgPicture.asset(
                                                          mySelectConsultation ==
                                                                  i
                                                              ? icon_selected_radio
                                                              : icon_unselected_radio),
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      // Value Selected
                                                      Text(
                                                          onOfferModel[i].title,
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CommonRedButton("Cancel",
                                                () async {
                                              if (activeTabIndex == 0) {
                                                setState(() {
                                                  mySelectConsultation = 0;
                                                });
                                                await orderViewModel
                                                    .tOrderHistoryViewModel(
                                                        sorting: "today");
                                                if (orderViewModel
                                                        .tOrderHistoryApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                }
                                                if (orderViewModel
                                                        .tOrderHistoryApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  const ServerError();
                                                }
                                              } else {
                                                setState(() {
                                                  mySelectConsultation = 0;
                                                });
                                                await orderViewModel
                                                    .dOrderHistoryViewModel(
                                                        sorting: "today");
                                                if (orderViewModel
                                                        .dOrderHistoryApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                }
                                                if (orderViewModel
                                                        .dOrderHistoryApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  const ServerError();
                                                }
                                              }
                                            }, red_dc3642),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CommonRedButton("Apply",
                                                () async {
                                              if (activeTabIndex == 0) {
                                                await orderViewModel.tOrderHistoryViewModel(
                                                    sorting: mySelectConsultation == 0
                                                        ? "today"
                                                        : mySelectConsultation == 1
                                                            ? "last_week"
                                                            : mySelectConsultation == 2
                                                                ? "last_month"
                                                                : "last_three_month");
                                                if (orderViewModel
                                                        .tOrderHistoryApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                }
                                                if (orderViewModel
                                                        .tOrderHistoryApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  const ServerError();
                                                }
                                              } else {
                                                await orderViewModel.dOrderHistoryViewModel(
                                                    sorting: mySelectConsultation == 0
                                                        ? "today"
                                                        : mySelectConsultation == 1
                                                            ? "last_week"
                                                            : mySelectConsultation == 2
                                                                ? "last_month"
                                                                : "last_three_month");
                                                if (orderViewModel
                                                        .dOrderHistoryApiResponse
                                                        .status ==
                                                    Status.COMPLETE) {
                                                  Get.back();
                                                }
                                                if (orderViewModel
                                                        .dOrderHistoryApiResponse
                                                        .status ==
                                                    Status.ERROR) {
                                                  const ServerError();
                                                }
                                              }
                                            }, red_dc3642),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ));
          });
        });
  }
}
