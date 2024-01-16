import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/add_payment_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/add_payment_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_detail_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/ApplyCoupon.dart';
import 'package:bluedip_user/view/RedeemAdsOns.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/viewModel/order_view_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Model/RedeemOferDetailModel.dart';
import '../Widget/toolbar_with_title_shadow.dart';

class RedeemOfferDetailPage extends StatefulWidget {
  RedeemOfferDetailPage({Key? key, required this.restoName}) : super(key: key);
  String restoName;

  @override
  State<RedeemOfferDetailPage> createState() => _RedeemOfferDetailPageState();
}

class _RedeemOfferDetailPageState extends State<RedeemOfferDetailPage> {
  List<RedeemOferDetailModel> onRedeemOferDetailModel = [
    RedeemOferDetailModel(icon_veg, "Bloddy Mary", 1),
    RedeemOferDetailModel(icon_nonveg, "Bloddy Mary", 1),
    RedeemOferDetailModel(icon_nonveg, "Bloddy Mary", 1),
  ];

  bool isEdit = false;
  bool isDiscountLayout = false;
  bool isNonApplyLayout = true;
  bool isApplyLayout = false;
  OrderViewModel orderViewModel = Get.find();
  GetOrderDetailsResModel? response;
  AddPaymentReqModel paymentReqModel = AddPaymentReqModel();
  Razorpay? _razorpay;

  @override
  void initState() {
    getOrderDetail();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  updatePayment(
      {required String rzpOrderId,
      required String rzpPaymentId,
      required String paymentStatus}) {
    orderViewModel
        .updatePayment(
            rzpPaymentId: rzpPaymentId,
            paymentStatus: paymentStatus,
            rzpOrderId: rzpOrderId)
        .then((value) {
      if (orderViewModel.updatePaymentApiResponse.status == Status.COMPLETE) {
        Get.offAll(const BottomNavigationScreen());
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    // String paymentId = response.paymentId!;
    // String orderId = response.orderId!;
    // String signature = response.signature!;
    print("Payment ID: ${response.paymentId}");
    print("Order ID: ${response.orderId}");
    print("Signature: ${response.signature}");
    updatePayment(
        rzpOrderId: response.orderId!,
        rzpPaymentId: response.paymentId!,
        paymentStatus: 'success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('eorr----${response.message}');
    print('eorr----${response.code}');
    print('eorr----${response.error}');
    // Handle payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
  }

  void _startPayment({required String amount, required String orderId}) {
    var options = {
      'key': 'rzp_test_pNhBI1u9upo7Tn',
      'amount': amount, //in the smallest currency sub-unit.
      'name': "abc",
      'order_id': orderId, // Generate order_id using Orders API
      'description': "abc def",
      'timeout': 60, // in seconds
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    // var options = {
    //   'key': 'rzp_test_hGo65Kcpu6J3Ft',
    //   'amount':
    //       10000, // amount in the smallest currency unit (e.g., 1000 Rupees = 100000 paise)
    //   'name': 'Your Company Name',
    //   'description': 'Test Payment',
    //   'order_id': "392340",
    //   'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
    //   "timeout": 60,
    //   // 'external': {
    //   //   'wallets': ['paytm'] // optional, to enable wallets like Paytm
    //   // }
    // };
    print('razorpay option====${options}');

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error-------: $e');
    }
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  getOrderDetail() async {
    await orderViewModel.getOrderDetail(
        offerId: PreferenceManagerUtils.getOfferId(),

        ///PreferenceManagerUtils.getOfferId(),
        restoId: PreferenceManagerUtils.getRestoId());

    ///PreferenceManagerUtils.getRestoId());
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
            if (controller.getOrderDetailApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.getOrderDetailApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            if (controller.getOrderDetailApiResponse.status ==
                Status.COMPLETE) {
              response = controller.getOrderDetailApiResponse.data;
            }
            return Stack(
              children: [
                response!.data == null
                    ? const NoDataFound()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ToolbarWithTitleShadow(widget.restoName),
                          Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*Pick up layout*/
                                  response!.data!.orderData!.time == null
                                      ? const SizedBox(
                                          height: 20,
                                        )
                                      : Container(
                                          decoration: cardboxDecoration,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16.w, vertical: 20.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 14.w, vertical: 15.h),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                icon_clock_blue,
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              // Valid Anytime Today
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "Pickup at ${response!.data!.orderData!.time ?? ""}",
                                                    style: TextStyle(
                                                        color: blue_007add,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.left),
                                              ),
                                              SvgPicture.asset(
                                                  icon_next_arrow_detail)
                                            ],
                                          ),
                                        ),

                                  /*Items Layout*/
                                  response!.data!.subItem == null ||
                                          response!.data!.subItem!.isEmpty
                                      ? const SizedBox()
                                      : Container(
                                          decoration: cardboxDecoration,
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          padding: EdgeInsets.only(
                                              left: 14.w,
                                              right: 14.w,
                                              top: 14.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Item(s)".toUpperCase(),
                                                  style: TextStyle(
                                                      color: grey_77879e,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                              ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                primary: false,
                                                shrinkWrap: true,
                                                padding:
                                                    EdgeInsets.only(top: 16.h),
                                                itemCount: response!
                                                    .data!.subItem!.length,
                                                itemBuilder:
                                                    (context, mainIndex) {
                                                  final data = response!.data!
                                                      .subItem![mainIndex];
                                                  return Column(
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: data
                                                            .menuSubCategoryData!
                                                            .length,
                                                        itemBuilder: (context,
                                                                subIndex) =>
                                                            Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 4.h),
                                                              child: SvgPicture.asset(data
                                                                          .menuSubCategoryData![
                                                                              subIndex]
                                                                          .type ==
                                                                      "veg"
                                                                  ? icon_veg
                                                                  : icon_nonveg),
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 4
                                                                            .h),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        data
                                                                            .menuSubCategoryData![
                                                                                subIndex]
                                                                            .name!,
                                                                        style: TextStyle(
                                                                            fontSize: 14
                                                                                .sp,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            color:
                                                                                black_504f58)),
                                                                    SizedBox(
                                                                      height:
                                                                          4.h,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            "\u{20B9}${data.menuSubCategoryData![subIndex].price}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: grey_77879e,
                                                                              fontFamily: fontMavenProMedium,
                                                                              fontSize: 12.sp,
                                                                              decoration: TextDecoration.lineThrough,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.right),
                                                                        SizedBox(
                                                                          width:
                                                                              8.w,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              icon_rupee_slim,
                                                                              width: 10.w,
                                                                              height: 10.h,
                                                                              color: black_504f58,
                                                                            ),
                                                                            Text("${data.menuSubCategoryData![subIndex].discountPrice}",
                                                                                style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontSize: 15.sp),
                                                                                textAlign: TextAlign.right)
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    data.checkSubMenuItem ==
                                                                            null
                                                                        ? const SizedBox()
                                                                        : ListView.builder(
                                                                            itemCount: data.checkSubMenuItem!.length,
                                                                            shrinkWrap: true,
                                                                            itemBuilder: (context, i) => Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 3.h,
                                                                                    ),
                                                                                    // Free Range Poached,White Toast...
                                                                                    Text(data.checkSubMenuItem![i].name!, style: TextStyle(color: grey_5f6d7b, fontFamily: fontMavenProRegular, fontSize: 12.sp), textAlign: TextAlign.left),
                                                                                    SizedBox(
                                                                                      height: 2.h,
                                                                                    ),
                                                                                  ],
                                                                                )),
                                                                    SizedBox(
                                                                      height:
                                                                          3.h,
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(
                                                                            RedeemAdsOns(
                                                                          menuSubCatId: data
                                                                              .menuSubCategoryData![subIndex]
                                                                              .menuSubCategoryId!,
                                                                        ));
                                                                      },
                                                                      child: Text(
                                                                          "Edit",
                                                                          style: TextStyle(
                                                                              color: blue_007add,
                                                                              fontFamily: fontMavenProMedium,
                                                                              fontSize: 12.sp),
                                                                          textAlign: TextAlign.left),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          14.h,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),

                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.1,
                                                                  height: 24,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(5
                                                                              .r),
                                                                      color: Color(
                                                                          0x11dc3642),
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              red_dc3642)),
                                                                  // margin: EdgeInsets.only(left: 8,right: 8,top: 0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            4.w,
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "x${data.quantity}",
                                                                            style: TextStyle(
                                                                                color: black_504f58,
                                                                                fontFamily: fontMavenProProSemiBold,
                                                                                fontSize: 15.sp),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            8.w,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 4.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                      icon_rupee_slim,
                                                                      width:
                                                                          10.w,
                                                                      height:
                                                                          10.h,
                                                                      color:
                                                                          black_504f58,
                                                                    ),
                                                                    Text(
                                                                        "${data.quantity * data.menuSubCategoryData![subIndex].discountPrice}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                black_504f58,
                                                                            fontFamily:
                                                                                fontMavenProBold,
                                                                            fontSize: 13
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.right)
                                                                  ],
                                                                ),
                                                              ],
                                                            ),

                                                            //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                          ],
                                                        ),
                                                      ),
                                                      mainIndex ==
                                                              response!
                                                                      .data!
                                                                      .subItem!
                                                                      .length -
                                                                  1
                                                          ? SizedBox()
                                                          : Column(
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              26.w),
                                                                  child:
                                                                      const DottedLine(
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    lineLength:
                                                                        double
                                                                            .infinity,
                                                                    lineThickness:
                                                                        1.0,
                                                                    dashLength:
                                                                        2.0,
                                                                    dashColor:
                                                                        divider_d4dce7,
                                                                    dashRadius:
                                                                        0.0,
                                                                    dashGapLength:
                                                                        2.0,
                                                                    dashGapColor:
                                                                        Colors
                                                                            .transparent,
                                                                    dashGapRadius:
                                                                        0.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 16.h,
                                                                ),
                                                              ],
                                                            )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                  /*Cooking Instruction*/
                                  response!.data!.orderData!.specialRequest ==
                                          null
                                      ? const SizedBox()
                                      : Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: cardboxDecoration,
                                                padding: EdgeInsets.all(14.r),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 20.h),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Customer Detail
                                                    Text(
                                                        "Cooking Instructions"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: grey_77879e,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 14.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    // Make it little spicy
                                                    Text(
                                                        "${response!.data!.orderData!.specialRequest}",
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 15.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),

                                  /*Coupon Layout*/
                                  Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ApplyCoupon(),
                                              ));
                                          setState(() {
                                            isNonApplyLayout = false;
                                            isApplyLayout = true;
                                            isDiscountLayout = true;
                                          });
                                        },
                                        child: Visibility(
                                          visible: isNonApplyLayout,
                                          child: Container(
                                            decoration: cardboxDecoration,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.w,
                                                vertical: 14.h),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icon_offer_green,
                                                ),
                                                SizedBox(
                                                  width: 11.w,
                                                ),
                                                // Valid Anytime Today
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Apply Coupon",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      Text("2 Available",
                                                          style: TextStyle(
                                                              color: red_dc3642,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    icon_next_arrow_detail)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            setState(() {
                                              isNonApplyLayout = true;
                                              isApplyLayout = false;
                                              isDiscountLayout = false;
                                            });
                                          });
                                        },
                                        child: Visibility(
                                          visible: isApplyLayout,
                                          child: Container(
                                            decoration: cardboxDecoration,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14.w,
                                                vertical: 14.h),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icon_offer_green,
                                                ),
                                                SizedBox(
                                                  width: 11.w,
                                                ),
                                                // Valid Anytime Today
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("FLAT10OFF",
                                                          style: TextStyle(
                                                              color:
                                                                  green_5cb85c,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      SizedBox(
                                                        height: 6.h,
                                                      ),
                                                      Text("Remove",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                    icon_next_arrow_detail)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /*Payment Summery Layout*/
                                  Container(
                                    decoration: cardboxDecoration,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 20.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 14.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                    "${response!.data!.subTotal ?? 0}",
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
                                                      "GST (${response!.data!.gst ?? 0}%)",
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
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  PopupMenuButton(
                                                      offset:
                                                          const Offset(15, -80),
                                                      // enabled: true,
                                                      tooltip: "",
                                                      shadowColor: const Color(
                                                          0x60d3d1d8),
                                                      constraints:
                                                          const BoxConstraints(
                                                        maxHeight: 105.0,
                                                        maxWidth: 100.0,
                                                      ),
                                                      itemBuilder:
                                                          (context) => [
                                                                PopupMenuItem(
                                                                    enabled:
                                                                        false,
                                                                    height: 30,
                                                                    value: 1,
                                                                    child: // Edit
                                                                        // CGST(2.5%)
                                                                        Text(
                                                                            "CGST(${response!.data!.cgst ?? 0}%)",
                                                                            style: TextStyle(
                                                                                color: light_black_5f6d7b,
                                                                                fontFamily: fontMavenProMedium,
                                                                                fontSize: 12.sp),
                                                                            textAlign: TextAlign.left)),
                                                                PopupMenuItem(
                                                                    enabled:
                                                                        false,
                                                                    value: 2,
                                                                    height: 30,
                                                                    child: // Edit
                                                                        Text(
                                                                            "SGST(${response!.data!.sgst ?? 0}%)",
                                                                            style: TextStyle(
                                                                                color: light_black_5f6d7b,
                                                                                fontFamily: fontMavenProMedium,
                                                                                fontSize: 12.sp),
                                                                            textAlign: TextAlign.left)),
                                                              ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24,
                                                          vertical: 10),
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
                                                    "${response!.data!.gstAmount ?? 0}",
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                    "${response!.data!.packingCharges ?? 0}",
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                                    "${response!.data!.grandTotal ?? 0}",
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

                                        Visibility(
                                          visible: isDiscountLayout,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        "Coupon Discount",
                                                        style: TextStyle(
                                                            color: green_5cb85c,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 14.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),
                                                  // 250
                                                  Row(
                                                    children: [
                                                      Text("-",
                                                          style: TextStyle(
                                                              color:
                                                                  green_5cb85c,
                                                              fontFamily:
                                                                  fontMavenProProSemiBold,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                      Image.asset(
                                                        icon_rupee_slim,
                                                        width: 10.w,
                                                        height: 10.h,
                                                        color: green_5cb85c,
                                                      ),
                                                      Text("50",
                                                          style: TextStyle(
                                                              color:
                                                                  green_5cb85c,
                                                              fontFamily:
                                                                  fontMavenProProSemiBold,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                            ],
                                          ),
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
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.left),
                                            ),
                                            // Paid
                                            // Container(
                                            //   padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(4.r),
                                            //       color: Color(0x215cb85c)
                                            //   ),
                                            //   child: Text("PAID",
                                            //       style: TextStyle(
                                            //           color: green_5cb85c,
                                            //           fontFamily: fontMavenProMedium,
                                            //           fontStyle: FontStyle.normal,
                                            //           fontSize: 14.sp),
                                            //       textAlign: TextAlign.right),
                                            // ),
                                            // SizedBox(
                                            //   width: 8.w,
                                            // ),
                                            // 250
                                            Row(
                                              children: [
                                                Image.asset(
                                                  icon_rupee_slim,
                                                  width: 12.w,
                                                  height: 12.h,
                                                ),
                                                Text(
                                                    "${response!.data!.netPayable ?? 0}",
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
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: 16.w, top: 11.h, bottom: 11.h),
                            color: red_dc3642,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // ₹15.53
                                      Text("${response!.data!.items}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  fontMavenProProSemiBold,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.center),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text("Items",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 35.h,
                                  width: 1,
                                  color: white_ffffff,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // ₹15.53
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            icon_rupee_slim,
                                            color: Colors.white,
                                            width: 12.w,
                                            height: 12.h,
                                          ),
                                          Text("${response!.data!.total}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text("Total",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 35.h,
                                  width: 1,
                                  color: white_ffffff,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // ₹15.53
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            icon_rupee_slim,
                                            color: Colors.white,
                                            width: 12.w,
                                            height: 12.h,
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${response!.data!.saving}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        fontMavenProProSemiBold,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text("Savings",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    paymentReqModel.action = 'add_payment';
                                    paymentReqModel.orderId = response!
                                        .data!.orderData!.orderId
                                        .toString();
                                    paymentReqModel.restaurantId =
                                        response!.data!.orderData!.restaurantId;
                                    paymentReqModel.subTotal =
                                        response!.data!.subTotal.toString();
                                    paymentReqModel.grandTotal =
                                        response!.data!.grandTotal.toString();
                                    paymentReqModel.gst =
                                        response!.data!.gst.toString();
                                    paymentReqModel.cgst =
                                        response!.data!.cgst.toString();
                                    paymentReqModel.sgst =
                                        response!.data!.sgst.toString();
                                    paymentReqModel.gstAmount =
                                        response!.data!.gstAmount.toString();
                                    paymentReqModel.netPayable =
                                        response!.data!.netPayable.toString();
                                    paymentReqModel.items =
                                        response!.data!.items.toString();
                                    paymentReqModel.savings =
                                        response!.data!.saving.toString();
                                    paymentReqModel.packingCharges = response!
                                        .data!.packingCharges
                                        .toString();

                                    await orderViewModel.addPayment(
                                        model: paymentReqModel);
                                    if (orderViewModel
                                            .addPaymentApiResponse.status ==
                                        Status.ERROR) {
                                      snackBar(title: 'There Must Be Error');
                                    }
                                    if (orderViewModel
                                            .addPaymentApiResponse.status ==
                                        Status.COMPLETE) {
                                      AddPaymentResModel paymentRes =
                                          orderViewModel
                                              .addPaymentApiResponse.data;
                                      if (paymentRes.status == true) {
                                        print(
                                            'id--paymentRes.data!.rzpOrderId!==${paymentRes.data!.rzpOrderId!}');
                                        _startPayment(
                                          orderId: paymentRes.data!.rzpOrderId!,
                                          amount: response!.data!.netPayable
                                              .toString(),
                                        );
                                        // Get.to(() => const OrderSuccessfully());
                                      } else {
                                        snackBar(title: paymentRes.message);
                                      }
                                    }

                                    ///
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => const OrderSuccessfully(),
                                    //     ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        color: Colors.white),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 22.w, vertical: 15.h),
                                    child: // button
                                        Text("Pay Now".toUpperCase(),
                                            style: TextStyle(
                                                color: red_dc3642,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.center),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                GetBuilder<OrderViewModel>(
                  builder: (controller) {
                    if (controller.addPaymentApiResponse.status ==
                        Status.LOADING) {
                      return const CircularIndicator();
                    }
                    return const SizedBox();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
