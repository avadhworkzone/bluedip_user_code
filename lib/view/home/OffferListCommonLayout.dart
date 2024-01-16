import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_resturent_list_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/viewModel/get_restaurent_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/home_rating_box_shadow.dart';
import '../../viewModel/wishlist_view_model.dart';
import 'RatingBarScreen.dart';
import '../bottomsheets/BottomSheetRatingBar.dart';
import 'resto_details/RestoDetailScreen.dart';

class OfferListCommonLayout extends StatefulWidget {
  OfferListCommonLayout(
      {Key? key, required this.response, required this.controller})
      : super(key: key);

  ScrollController? controller;
  List<restoData> response;

  @override
  State<OfferListCommonLayout> createState() => _OfferListCommonLayoutState();
}

class _OfferListCommonLayoutState extends State<OfferListCommonLayout> {
  List<CityListModel> onDealsModel = [];
  List<CityListModel> selectedList = [];
  WishListViewModel wishListViewModel = Get.find();

  @override
  void initState() {
    onDealsModel.clear();
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_burger));
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_burger));
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 4.h,
          ),
          itemCount: widget.response.length,
          itemBuilder: (context, i) {
            DateTime now = DateTime.parse(widget.response[i].dateCreated!);
            DateTime oneMonthAfter = DateTime(now.year, now.month + 1, now.day);
            var dateFormate = DateFormat('dd/MM/yyyy').format(oneMonthAfter);
            var currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
            var isOneMonthComplete = currentDate.compareTo(dateFormate);

            return GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetailsScreen(
                          restaurantId: widget.response[i].restaurantId!

                          ///widget.response[i].restaurantId!
                          ),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16.h, left: 6.w),
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
                                child: widget.response[i].restaurantImg ==
                                            null ||
                                        widget.response[i].restaurantImg == ""
                                    ? Image.asset(
                                        'assets/images/bluedip_app_icon_second.png',
                                        height: 175.h,
                                        fit: BoxFit.cover,
                                        width: Get.width)
                                    // Image.network(
                                    //         'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png',
                                    //         fit: BoxFit.fill,
                                    //         height: 172.h,
                                    //         width: Get.width,
                                    //       )
                                    : Image.network(
                                        "${widget.response[i].restaurantImg!}",
                                        fit: BoxFit.cover,
                                        height: 175.h,
                                        width: Get.width,
                                      )
                                // Image.asset(
                                //   onDealsModel[i].title,
                                //   width: double.infinity,
                                //   height: 172.h,
                                //   fit: BoxFit.fill,
                                // )
                                ),
                            Positioned(
                                top: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GetBuilder<WishListViewModel>(
                                    builder: (wishlistDataController) {
                                      return GestureDetector(
                                          onTap: () async {
                                            // setState(() {
                                            // setState(
                                            //   () async {
                                            if (wishlistDataController
                                                .wishListLocalData
                                                .containsKey(widget.response[i]
                                                    .restaurantId)) {
                                              wishlistDataController
                                                              .wishListLocalData[
                                                          widget.response[i]
                                                              .restaurantId]![
                                                      "isLike"] =
                                                  !wishlistDataController
                                                              .wishListLocalData[
                                                          widget.response[i]
                                                              .restaurantId]![
                                                      "isLike"];
                                            } else {
                                              bool isLike = widget.response[i]
                                                          .isFavourite ==
                                                      true
                                                  ? true
                                                  : false;
                                              wishlistDataController
                                                  .wishListLocalData
                                                  .addAll({
                                                widget.response[i]
                                                    .restaurantId!: {
                                                  "rName": widget.response[i]
                                                      .restaurantName,
                                                  "id": widget
                                                      .response[i].restaurantId,
                                                  "img": widget.response[i]
                                                      .restaurantImg,
                                                  "isLike": !isLike
                                                }
                                              });
                                            }
                                            wishlistDataController.update();
                                            // if (PreferenceUtils
                                            //         .getUserId()
                                            //     .isNotEmpty) {
                                            if (wishlistDataController
                                                .wishListLocalData
                                                .containsKey(widget.response[i]
                                                    .restaurantId!)) {
                                              if (wishlistDataController
                                                          .wishListLocalData[
                                                      widget.response[i]
                                                          .restaurantId]![
                                                  "isLike"]) {
                                                // productAddToWishlistReqModel
                                                //         .productId =
                                                //     newArrivalData.id;
                                                // productAddToWishlistReqModel
                                                //         .userId =
                                                //     PreferenceUtils
                                                //         .getUserId();
                                                await wishListViewModel
                                                    .wishList(
                                                        action: "add_favourite",
                                                        restaurantId: widget
                                                            .response[i]
                                                            .restaurantId);
                                              } else {
                                                // removeWishlistReqModel
                                                //         .productId =
                                                //     newArrivalData.id;
                                                // removeWishlistReqModel
                                                //         .userId =
                                                //     PreferenceUtils
                                                //         .getUserId();
                                                await wishListViewModel
                                                    .wishList(
                                                        action: "add_favourite",
                                                        restaurantId: widget
                                                            .response[i]
                                                            .restaurantId);
                                              }
                                            } else {
                                              bool isLike = widget.response[i]
                                                          .isFavourite ==
                                                      true
                                                  ? true
                                                  : false;
                                              if (isLike == true) {
                                                // removeWishlistReqModel
                                                //         .productId =
                                                //     newArrivalData.id;
                                                // removeWishlistReqModel
                                                //         .userId =
                                                //     PreferenceUtils
                                                //         .getUserId();
                                                await wishListViewModel
                                                    .wishList(
                                                        action: "add_favourite",
                                                        restaurantId: widget
                                                            .response[i]
                                                            .restaurantId);
                                              } else {
                                                await wishListViewModel
                                                    .wishList(
                                                        action: "add_favourite",
                                                        restaurantId: widget
                                                            .response[i]
                                                            .restaurantId);
                                              }
                                            }
                                            // }
                                            // if (selectedList
                                            //     .contains(onDealsModel[i])) {
                                            //   selectedList
                                            //       .remove(onDealsModel[i]);
                                            // } else {
                                            //   selectedList
                                            //       .add(onDealsModel[i]);
                                            // }
                                            //   },
                                            // );
                                            // });
                                          },
                                          child: SvgPicture.asset(wishlistDataController
                                                  .wishListLocalData
                                                  .containsKey(widget
                                                      .response[i].restaurantId)
                                              ? wishlistDataController
                                                                  .wishListLocalData[
                                                              widget.response[i]
                                                                  .restaurantId]![
                                                          "isLike"] ==
                                                      true
                                                  ? icon_red_heart
                                                  : icon_white_heart
                                              : widget.response[i]
                                                          .isFavourite ==
                                                      false
                                                  ? icon_white_heart
                                                  : icon_red_heart));
                                    },
                                  ),
                                )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RatingBarScreen(
                                          type: "dine-in",
                                          restoId:
                                              widget.response[i].restaurantId!,
                                          restoName: widget
                                              .response[i].restaurantName!,
                                        ),
                                      ));
                                  // selectRatingBar(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 7.h),
                                  margin: EdgeInsets.all(12.r),
                                  decoration: homeratingboxDecoration,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // 4.5
                                      Text("${widget.response[i].avg ?? ""}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      SvgPicture.asset(icon_small_rating_bar),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                          "(${widget.response[i].ratingCount})",
                                          style: TextStyle(
                                              color: grey_77879e,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 10.sp),
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // McDonald’s
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.response[i].restaurantName ?? "",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.left),
                                  isOneMonthComplete == 0
                                      ? SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xffff8a9e),
                                                  Color(0xfff43f5e),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 4.h),
                                              child: Text("New",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left)),
                                        )
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              // Sec 16, Dwarka, New Delhi
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  widget.response[i].restaurantLocationData ==
                                          null
                                      ? const SizedBox()
                                      : Expanded(
                                          child: Text(
                                              "${widget.response[i].restaurantLocationData!.address}, ${widget.response[i].restaurantLocationData!.cityName}, ${widget.response[i].restaurantLocationData!.country}",

                                              ///"Sec 16, Dwarka, New Delhi ",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                        ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
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
                                  Text("${widget.response[i].distanceKm}",
                                      style: TextStyle(
                                          color: grey_5f6d7b,
                                          fontFamily: fontMavenProRegular,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.sp),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              Row(
                                children: List.generate(
                                  widget.response[i].restaurantType!.length,
                                  (index) => Row(
                                    children: [
                                      widget.response[i]
                                                  .restaurantType![index] ==
                                              'dine-in'
                                          ? Image.asset(
                                              icon_dinein_png,
                                              width: 14.w,
                                              height: 14.h,
                                            )
                                          : Image.asset(
                                              icon_takeaway_png,
                                              width: 14.w,
                                              height: 14.h,
                                            ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      // Takeaway
                                      Text(
                                          widget.response[i]
                                              .restaurantType![index],
                                          style: TextStyle(
                                              color: grey_5f6d7b,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),

                                      SizedBox(
                                        width: 12.w,
                                      ),

                                      // Image.asset(
                                      //   icon_dinein_png,
                                      //   width: 14.w,
                                      //   height: 14.h,
                                      // ),
                                      // SizedBox(
                                      //   width: 4.w,
                                      // ),
                                      // Takeaway
                                      // Text("Dine-in",
                                      //     style: TextStyle(
                                      //         color: grey_5f6d7b,
                                      //         fontFamily: fontMavenProRegular,
                                      //         fontSize: 12.sp),
                                      //     textAlign: TextAlign.left),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8.h,
                              ),

                              widget.response[i].cuisine == null ||
                                      widget.response[i].cuisine!.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 22.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount:
                                            widget.response[i].cuisine!.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: Color(0xfff6f6f6)),
                                          child: // Chicken
                                              Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w, vertical: 4.h),
                                            child: Text(
                                                widget.response[i]
                                                    .cuisine![index],
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
                        ),
                      ],
                    ),
                  ),
                  widget.response == [] || widget.response[i].offersData == []
                      ? const SizedBox()
                      : Column(
                          children: List.generate(
                              widget.response[i].offersData!.length > 3
                                  ? 3
                                  : widget.response[i].offersData!.length,
                              (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 7.h,
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Image.asset(icon_blue_strip,
                                            width: 210.w)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: 13.w,
                                        ),
                                        widget.response[i].offersData![index]
                                                    .timeType ==
                                                "All day"
                                            ? SvgPicture.asset(icon_offer_white)
                                            : SvgPicture.asset(
                                                icon_flash_offer),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // 60% OFF- Takeaway
                                            Text(
                                                "${widget.response[i].offersData![index].offerPercentage} OFF- ${widget.response[i].offersData![index].offerType}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        fontMavenProMedium,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.left),

                                            // Pick UP Between 5:30 - 7:00pm
                                            widget.response[i].offersData![index].offerType == "Takeaway" &&
                                                    widget
                                                            .response[i]
                                                            .offersData![index]
                                                            .timeType ==
                                                        "Time Limit"
                                                ? Text("Pick Up Between ${widget.response[i].offersData![index].timePeriod!.start} - ${widget.response[i].offersData![index].timePeriod!.end}",
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xc9ffffff),
                                                        fontFamily:
                                                            fontMavenProRegular,
                                                        fontSize: 10.sp),
                                                    textAlign: TextAlign.left)
                                                : widget.response[i].offersData![index].offerType == "Dine-in" &&
                                                        widget.response[i].offersData![index].timeType ==
                                                            "Time Limit"
                                                    ? Text("Arrive Between ${widget.response[i].offersData![index].timePeriod!.start} - ${widget.response[i].offersData![index].timePeriod!.end}",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xc9ffffff),
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 10.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                    : widget.response[i].offersData![index].timeType ==
                                                            "All day"
                                                        ? Text("Anytime Today",
                                                            style: TextStyle(
                                                                color: const Color(0xc9ffffff),
                                                                fontFamily: fontMavenProRegular,
                                                                fontSize: 10.sp),
                                                            textAlign: TextAlign.left)
                                                        : SizedBox()
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                // Stack(
                                //   alignment: Alignment.center,
                                //   children: [
                                //     Align(
                                //         alignment: Alignment.topLeft,
                                //         child: Image.asset(icon_blue_strip,
                                //             width: 210.w)),
                                //     Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisSize: MainAxisSize.max,
                                //       children: [
                                //         SizedBox(
                                //           width: 13.w,
                                //         ),
                                //         SvgPicture.asset(icon_flash_offer),
                                //         SizedBox(
                                //           width: 4.w,
                                //         ),
                                //         Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             // 60% OFF- Takeaway
                                //             Text("40% OFF- Dine In",
                                //                 style: TextStyle(
                                //                     color: Colors.white,
                                //                     fontFamily:
                                //                         fontMavenProMedium,
                                //                     fontStyle: FontStyle.normal,
                                //                     fontSize: 12.sp),
                                //                 textAlign: TextAlign.left),
                                //
                                //             // Pick UP Between 5:30 - 7:00pm
                                //             Text(
                                //                 "Arrive Between 12:30 - 7:00pm",
                                //                 style: TextStyle(
                                //                     color: Color(0xc9ffffff),
                                //                     fontFamily:
                                //                         fontMavenProRegular,
                                //                     fontSize: 10.sp),
                                //                 textAlign: TextAlign.left)
                                //           ],
                                //         )
                                //       ],
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 5.h,
                                // ),
                                // Stack(
                                //   alignment: Alignment.center,
                                //   children: [
                                //     Align(
                                //         alignment: Alignment.topLeft,
                                //         child: Image.asset(icon_blue_strip,
                                //             width: 210.w)),
                                //     Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.start,
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       mainAxisSize: MainAxisSize.max,
                                //       children: [
                                //         SizedBox(
                                //           width: 13.w,
                                //         ),
                                //         SvgPicture.asset(icon_offer_white),
                                //         SizedBox(
                                //           width: 4.w,
                                //         ),
                                //         Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             // 60% OFF- Takeaway
                                //             Text("25% OFF- Takeaway",
                                //                 style: TextStyle(
                                //                     color: Colors.white,
                                //                     fontFamily:
                                //                         fontMavenProMedium,
                                //                     fontStyle: FontStyle.normal,
                                //                     fontSize: 12.sp),
                                //                 textAlign: TextAlign.left),
                                //
                                //             // Pick UP Between 5:30 - 7:00pm
                                //             Text("Anytime Today",
                                //                 style: TextStyle(
                                //                     color: Color(0xc9ffffff),
                                //                     fontFamily:
                                //                         fontMavenProRegular,
                                //                     fontSize: 10.sp),
                                //                 textAlign: TextAlign.left)
                                //           ],
                                //         )
                                //       ],
                                //     )
                                //   ],
                                // ),
                              ],
                            );
                          }),
                        )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

void selectRatingBar(BuildContext context) {
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
              child: const Wrap(
                children: [BottomSheetRatingBar()],
              ),
            ));
      });
}
