import 'dart:convert';
import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_data_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/offer_detail_res_model.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/utils/Utility.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/home/resto_details/timer.dart';
import 'package:bluedip_user/viewModel/resto_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../Widget/circular_progrss_indicator.dart';
import '../../../Widget/common_border_button.dart';
import '../../../Widget/home_rating_box_shadow.dart';
import '../../../modal/apis/api_response.dart';
import '../../bottomsheets/BottomSheetReddem40.dart';
import '../../../Widget/common_red_button.dart';
import '../../order/RedeemOffer.dart';

class RestoDetailOfferTab extends StatefulWidget {
  RestoDetailOfferTab({Key? key, this.response}) : super(key: key);

  OfferDataResModel? response;

  @override
  State<RestoDetailOfferTab> createState() => _RestoDetailOfferTabState();
}

class _RestoDetailOfferTabState extends State<RestoDetailOfferTab> {
  List<CityListModel> foodList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];
  List<CityListModel> onDealsModel = [];
  List<CityListModel> selectedList = [];
  RestoDetailViewModel restoDetailViewModel = Get.find();

  @override
  void initState() {
    onDealsModel.clear();
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_burger));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg_fafbfb,
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.response == null || widget.response!.data == null
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 21.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Image.asset(
                                    img_no_deals,
                                    width: 165.w,
                                    height: 80.h,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(" Oops! No Deals Available",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: fontOverpassBold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  // Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to b
                                  Text(
                                      "Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to be notified when they post their next deal.",
                                      style: TextStyle(
                                          color: grey_5f6d7b,
                                          fontFamily: fontMavenProRegular,
                                          height: 1.5,
                                          fontSize: 14.sp),
                                      textAlign: TextAlign.center),

                                  SizedBox(
                                    height: 24.h,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            )
                          ],
                        )
                      : widget.response == null ||
                              widget.response!.data == null ||
                              widget.response!.data!.isEmpty
                          ? const NoDataFound()
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              primary: false,
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  left: 16.w, right: 16.w, top: 20.h),
                              itemCount: widget.response!.data!.length,
                              itemBuilder: (context, i) => Container(
                                padding: EdgeInsets.all(14.r),
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: cardboxDecoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          icon_flash_offer,
                                          width: 22.w,
                                          height: 22.h,
                                        ),
                                        SizedBox(
                                          width: 3.w,
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
                                                  '${widget.response!.data![i].offerPercentage!} off - ${widget.response!.data![i].offerType}',
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProBold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 16.sp),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              // Offer valid between 12:30 - 7:00pm
                                              Text(
                                                  "Offer valid between ${widget.response!.data![i].timePeriod!.start} - ${widget.response!.data![i].timePeriod!.end}",
                                                  style: TextStyle(
                                                      color: grey_5f6d7b,
                                                      fontFamily:
                                                          fontMavenProRegular,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                              widget.response!.data![i].deals ==
                                                      0
                                                  ? Row(
                                                      children: [
                                                        // 10 Deals Left
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              "Sold out",
                                                              style: TextStyle(
                                                                  color:
                                                                      grey_77879e,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12.r),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    divider_d4dce7,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.r)),
                                                            child: // Redeem
                                                                Text(
                                                                    "None Left",
                                                                    style: TextStyle(
                                                                        color:
                                                                            grey_77879e,
                                                                        fontFamily:
                                                                            fontMavenProMedium,
                                                                        fontSize: 14
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        // 10 Deals Left
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              "${widget.response!.data![i].deals} Deals Left",
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (widget
                                                                      .response!
                                                                      .data![i]
                                                                      .deals ==
                                                                  0) {
                                                                // // Navigator.pop(context, false);
                                                                // selectRedeem40(
                                                                //     context);
                                                              } else {
                                                                // Navigator.pop(context, false);
                                                                Utility.orderType =
                                                                    widget
                                                                        .response!
                                                                        .data![
                                                                            i]
                                                                        .offerType;
                                                                print(
                                                                    '<<===offer type===>>${Utility.orderType}');
                                                                if (Utility
                                                                        .orderType ==
                                                                    'Dine-in') {
                                                                  await restoDetailViewModel.offerDetailViewModel(
                                                                      offerId: widget
                                                                          .response!
                                                                          .data![
                                                                              i]
                                                                          .offerId!
                                                                          .toString());
                                                                  if (restoDetailViewModel
                                                                          .offerDetailApiResponse
                                                                          .status ==
                                                                      Status
                                                                          .ERROR) {
                                                                    snackBar(
                                                                        title:
                                                                            'Server Error');
                                                                  }
                                                                  if (restoDetailViewModel
                                                                          .offerDetailApiResponse
                                                                          .status ==
                                                                      Status
                                                                          .COMPLETE) {
                                                                    OfferDetailsResModel
                                                                        response =
                                                                        restoDetailViewModel
                                                                            .offerDetailApiResponse
                                                                            .data;
                                                                    if (response
                                                                            .status ==
                                                                        true) {
                                                                      await PreferenceManagerUtils.setOfferId(widget
                                                                          .response!
                                                                          .data![
                                                                              i]
                                                                          .offerId
                                                                          .toString());

                                                                      offerDetailBottomSheet(
                                                                          context:
                                                                              context,
                                                                          res:
                                                                              response);
                                                                    } else {
                                                                      snackBar(
                                                                          title:
                                                                              response.message);
                                                                    }
                                                                  }
                                                                } else {
                                                                  selectVenueOrdering(
                                                                      context:
                                                                          context,
                                                                      offerId: widget
                                                                          .response!
                                                                          .data![
                                                                              i]
                                                                          .offerId!);
                                                                  await PreferenceManagerUtils.setOfferId(widget
                                                                      .response!
                                                                      .data![i]
                                                                      .offerId
                                                                      .toString());
                                                                }
                                                              }
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          12.r),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      gradient:
                                                                          const LinearGradient(
                                                                        begin: Alignment
                                                                            .centerLeft,
                                                                        end: Alignment
                                                                            .centerRight,
                                                                        colors: [
                                                                          Color(
                                                                              0xffff8a9e),
                                                                          Color(
                                                                              0xfff43f5e),
                                                                        ],
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12.r)),
                                                              child: // Redeem
                                                                  Text(
                                                                      widget.response!.data![i].deals ==
                                                                              0
                                                                          ? "None Left"
                                                                          : "Redeem",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontSize: 14
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                  // Similar Restaurants
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, top: 24.h, bottom: 16.h),
                    child: Text("Similar Restaurants",
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProBold,
                            fontSize: 16.sp),
                        textAlign: TextAlign.left),
                  ),

                  SizedBox(
                    height: 290.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: 16.w,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: onDealsModel.length,
                      itemBuilder: (context, i) => Stack(
                        children: [
                          Container(
                            width: 280.w,
                            margin: EdgeInsets.only(bottom: 30.h, left: 2.w),
                            decoration: cardboxDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.r),
                                          topRight: Radius.circular(10.r),
                                        ),
                                        child: Image.asset(
                                          onDealsModel[i].title,
                                          width: double.infinity,
                                          height: 136.h,
                                          fit: BoxFit.fill,
                                        )),
                                    Positioned(
                                        bottom: 80,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  setState(
                                                    () {
                                                      if (selectedList.contains(
                                                          onDealsModel[i])) {
                                                        selectedList.remove(
                                                            onDealsModel[i]);
                                                      } else {
                                                        selectedList.add(
                                                            onDealsModel[i]);
                                                      }
                                                    },
                                                  );
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                  selectedList.contains(
                                                          onDealsModel[i])
                                                      ? icon_red_heart
                                                      : icon_white_heart)),
                                        )),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 7.h),
                                        margin: EdgeInsets.all(12.r),
                                        decoration: homeratingboxDecoration,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // 4.5
                                            Text("4.5",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            SvgPicture.asset(
                                                icon_small_rating_bar),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Text("(25+)",
                                                style: TextStyle(
                                                    color: grey_77879e,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 10.sp),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // McDonald’s
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("McDonald’s",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      // Sec 16, Dwarka, New Delhi
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Sec 16, Dwarka, New Delhi ",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                          Container(
                                            width: 3.w,
                                            height: 3.w,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: grey_5f6d7b),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text("2.5km",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),

                                      Row(
                                        children: [
                                          Image.asset(
                                            icon_takeaway_png,
                                            width: 14.w,
                                            height: 14.h,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          // Takeaway
                                          Text("Takeaway",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),

                                          SizedBox(
                                            width: 12.w,
                                          ),

                                          Image.asset(
                                            icon_dinein_png,
                                            width: 14.w,
                                            height: 14.h,
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          // Takeaway
                                          Text("Dine-in",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 8.h,
                                      ),

                                      SizedBox(
                                        height: 22.h,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount: foodList.length,
                                          itemBuilder: (context, i) =>
                                              Container(
                                            margin: EdgeInsets.only(right: 8.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                color: Color(0xfff6f6f6)),
                                            child: // Chicken
                                                Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6.w,
                                                  vertical: 4.h),
                                              child: Text(foodList[i].title,
                                                  style: TextStyle(
                                                      color: grey_77879e,
                                                      fontFamily:
                                                          fontMavenProRegular,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              SizedBox(
                                  height: 26.h,
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Image.asset(
                                        icon_blue_strip,
                                        width: 78.w,
                                        height: 26.h,
                                        fit: BoxFit.fill,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          SvgPicture.asset(icon_dinning_white),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text("20% off",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                  height: 26.h,
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Image.asset(
                                        icon_blue_strip,
                                        width: 78.w,
                                        height: 26.h,
                                        fit: BoxFit.fill,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          SvgPicture.asset(
                                              icon_shopping_cart_bag_white),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text("10% off",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  child: GetBuilder<RestoDetailViewModel>(
                    builder: (controller) {
                      if (controller.offerDetailApiResponse.status ==
                          Status.LOADING) {
                        return const CircularIndicator();
                      }
                      return const SizedBox();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void offerDetailBottomSheet(
      {required BuildContext context, required OfferDetailsResModel res}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateData) {
          return Container(
              decoration: BoxDecoration(
                  color: white_ffffff,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r))),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.h, vertical: 20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 136.h,
                                margin: EdgeInsets.only(right: 2),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(
                                    "assets/images/img_ticket_green_png.png",
                                  ),
                                )),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.h, vertical: 20.h),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // 20% OFF
                                                  RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        style: TextStyle(
                                                            color: green_5cb85c,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                fontOverpassBold,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 35.sp),
                                                        text: res.data!
                                                            .offerPercentage),
                                                    TextSpan(
                                                        style: TextStyle(
                                                            color: green_5cb85c,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 15.sp),
                                                        text: "\nOFF")
                                                  ])),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                      res.data!.offerType!
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: red_dc3642,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14.sp),
                                                      textAlign: TextAlign.left)
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Pizza Hut
                                              Text(
                                                  res.data!.restaurantData![0]
                                                      .restaurantName!,
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontOverpassBold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 16.sp),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Text(
                                                  "${res.data!.deals} Deals Left",
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              res.data!.minAmount != null
                                                  ? Text(
                                                      "The Total Order Incl.Drinks ",
                                                      style: TextStyle(
                                                          color: grey_77879e,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 14.sp,
                                                          height: 1.5),
                                                      textAlign: TextAlign.left)
                                                  : const SizedBox(),
                                              res.data!.minAmount != null
                                                  ? RichText(
                                                      text: TextSpan(children: [
                                                      TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp,
                                                              height: 1.5),
                                                          text: "On "),
                                                      TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  grey_504f58,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          text:
                                                              "₹${res.data!.minAmount} "),
                                                      TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 14.sp),
                                                          text:
                                                              "Min bill Amount")
                                                    ]))
                                                  : const SizedBox()
                                            ],
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
                                  SvgPicture.asset(icon_clock_blue),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  // Valid Anytime Today
                                  TimerClass(response: res)
                                ],
                              ),
                            ],
                          ),
                          // GreenTicketWidget(
                          //     title: '${res.data!.offerPercentage}',
                          //     subtitle: 'Valid Anytime Today',
                          //     type: "${res.data!.offerType}"),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CommonBorderButton("Close".toUpperCase(),
                                    () {
                                  countTimer?.cancel();
                                  Navigator.pop(context, false);
                                }, red_dc3642, white_ffffff, red_dc3642),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: CommonRedButton(
                                    Utility.orderType == 'Dine-in'
                                        ? "Redeem for dine in".toUpperCase()
                                        : "Order & Pay In App".toUpperCase(),
                                    () {
                                  // timer?.cancel();
                                  countTimer?.cancel();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RedeemOffer(),
                                      ));
                                }, red_dc3642),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        },
      ),
    );
  }

  void selectRedeem40(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Container(
              decoration: BoxDecoration(
                  color: white_ffffff,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r))),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: const [BottomSheetReddem40()],
                ),
              ));
        });
  }

  void selectVenueOrdering(
      {required BuildContext context, required int offerId}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return Container(
              decoration: BoxDecoration(
                  color: white_ffffff,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r))),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              img_venue_png,
                              width: double.infinity,
                              height: 190.h,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                              "This venue is set up for Bluedip In \nApp Ordering.",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontOverpassBold,
                                  height: 1.5,
                                  fontSize: 18.sp),
                              textAlign: TextAlign.center),
                          Text(
                              "You can order and pay through a digital \nmenu with the deal already applied \nto your order.",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  height: 1.5,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CommonBorderButton("Close".toUpperCase(),
                                    () {
                                  Navigator.pop(context, false);
                                }, red_dc3642, white_ffffff, red_dc3642),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: GetBuilder<RestoDetailViewModel>(
                                  builder: (controller) {
                                    // if (controller
                                    //         .offerDetailApiResponse.status ==
                                    //     Status.LOADING) {
                                    //   return const Center(
                                    //       child: CircularProgressIndicator());
                                    // }
                                    return CommonRedButton(
                                        "OK, Continue".toUpperCase(), () async {
                                      await restoDetailViewModel
                                          .offerDetailViewModel(
                                              offerId: PreferenceManagerUtils
                                                  .getOfferId());
                                      if (controller
                                              .offerDetailApiResponse.status ==
                                          Status.ERROR) {
                                        snackBar(title: 'Server Error');
                                      }
                                      if (controller
                                              .offerDetailApiResponse.status ==
                                          Status.COMPLETE) {
                                        OfferDetailsResModel response =
                                            restoDetailViewModel
                                                .offerDetailApiResponse.data;
                                        if (response.status == true) {
                                          Navigator.pop(context, false);

                                          offerDetailBottomSheet(
                                              context: context, res: response);
                                        } else {
                                          snackBar(title: response.message);
                                        }
                                      }
                                    }, red_dc3642);
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}

// class TimerClass extends StatefulWidget {
//   TimerClass({Key? key, required this.response}) : super(key: key);
//   OfferDetailsResModel response;
//
//   @override
//   State<TimerClass> createState() => _TimerClassState();
// }
//
// class _TimerClassState extends State<TimerClass> {
//   String textData = '';
//   String currentTime = DateFormat("HH:mm:ss").format(DateTime.now());
//
//   /// start time
//   DateTime startTime = DateFormat("HH:mm a").parse("2:00 PM");
//
//   startTimer() {
//     ///res.data!.timePeriod!.start!
//     String formattedSTime = DateFormat('HH:mm:ss').format(startTime);
//
//     /// end time
//     var format = DateFormat("HH:mm:ss");
//     var one = format.parse(currentTime);
//     DateTime parsedTime = DateFormat('hh:mm a').parse("4:00 PM");
//     String formattedETime = DateFormat('HH:mm:ss').format(parsedTime);
//     var endTime = format.parse(formattedETime);
//     var start = format.parse(formattedSTime);
//
//     int convertTimeToMinutes(String timeString) {
//       DateFormat format = DateFormat('hh:mm:ss');
//       DateTime dateTime = format.parse(timeString);
//
//       int hours = dateTime.hour;
//       int minutes = dateTime.minute;
//
//       return (hours * 60) + minutes;
//     }
//
//     var fromTime = convertTimeToMinutes(formattedSTime);
//     var toTime = convertTimeToMinutes(formattedETime);
//     var current = convertTimeToMinutes(currentTime);
//     var timeDifference = endTime.difference(start).inHours;
//
//     if (current > fromTime && current < toTime) {
//       if (timeDifference <= 2) {
//         print('2 hour ni condition ma jay che');
//         countTimer = Timer.periodic(Duration(seconds: 1), (Timer t) {
//           var timeDif = format
//               .parse(DateFormat('HH:mm:ss')
//                   .format(DateFormat('hh:mm a').parse("4:00 PM")))
//               .difference(
//                   format.parse(DateFormat("HH:mm:ss").format(DateTime.now())));
//           print('timedifference==${timeDif}');
//
//           final mm = (timeDif.inMinutes % 60).toString().padLeft(2, '0');
//           final HH = (timeDif.inHours).toString().padLeft(2, '0');
//           final ss = (timeDif.inSeconds % 60).toString().padLeft(2, '0');
//           setState(() {
//             textData = "${HH}h ${mm}m ${ss}s";
//           });
//           //   print('textData====>$textData');
//           //   print('------timeDifference----${timeDifference}');
//         });
//         print('textData====>$textData');
//       } else {
//         setState(() {
//           textData =
//               "Offer valid between ${widget.response.data!.timePeriod!.start} - ${widget.response.data!.timePeriod!.end}";
//         });
//       }
//     } else {
//       print('else ni condition ma jay che');
//       setState(() {
//         textData = "";
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     countTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     startTimer();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(textData,
//         style: TextStyle(
//             color: blue_007add,
//             fontFamily: fontMavenProMedium,
//             fontSize: 14.sp),
//         textAlign: TextAlign.left);
//   }
// }
