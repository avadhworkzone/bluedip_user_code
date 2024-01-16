import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/viewModel/wishlist_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Widget/card_box_shadow.dart';
import '../../../Widget/home_rating_box_shadow.dart';
import '../../../Widget/toolbar_with_title_shadow.dart';
import '../../../modal/apiModel/response_modal/get_resturent_list_res_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isNoFavouriteLayout = true;
  bool isFavouriteListLayout = false;
  WishListViewModel wishListViewModel = Get.find();
  GetRestaurantListResModel? res;

  getWishListData() async {
    await wishListViewModel.getWishList();
  }

  @override
  void initState() {
    getWishListData();
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white_ffffff,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolbarWithTitleShadow("Favourite"),

                // Expanded(
                //   flex: 1,
                //   child: SingleChildScrollView(
                //     child: Padding(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Visibility(
                //             visible: isNoFavouriteLayout,
                //             child: GestureDetector(
                //               onTap: () {
                //                 setState(() {
                //                   isNoFavouriteLayout = false;
                //                   isFavouriteListLayout = true;
                //                 });
                //               },
                //               child: SizedBox(
                //                 height: MediaQuery.of(context).size.height / 1.5,
                //                 child: Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     Center(
                //                         child: Image.asset(
                //                       img_no_favourit,
                //                       width: 154.w,
                //                       height: 160.h,
                //                       fit: BoxFit.fill,
                //                     )),
                //                     SizedBox(
                //                       height: 30.h,
                //                     ),
                //                     // No Orders
                //                     Text("No Favourites",
                //                         style: TextStyle(
                //                             color: black_504f58,
                //                             fontFamily: fontMavenProBold,
                //                             fontSize: 16.sp),
                //                         textAlign: TextAlign.center),
                //                     SizedBox(
                //                       height: 10.h,
                //                     ),
                //                     // You don’t have any orders in your history
                //                     Text("You don’t have any favourites yet",
                //                         style: TextStyle(
                //                             color: grey_77879e,
                //                             fontFamily: fontMavenProRegular,
                //                             fontSize: 12.sp),
                //                         textAlign: TextAlign.center)
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //           // Visibility(
                //           //   visible: isFavouriteListLayout,
                //           //   child:  OfferListCommonLayout(),
                //           // )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                GetBuilder<WishListViewModel>(
                  builder: (controller) {
                    if (controller.getWishListApiResponse.status ==
                        Status.LOADING) {
                      return const CircularIndicator();
                    }
                    if (controller.getWishListApiResponse.status ==
                        Status.ERROR) {
                      return const ServerError();
                    }
                    if (controller.getWishListApiResponse.status ==
                        Status.COMPLETE) {
                      res = controller.getWishListApiResponse.data;
                    }
                    return res!.data == null ||
                            res!.data!.restaurantList == null ||
                            res!.data!.restaurantList!.isEmpty
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 20.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: isNoFavouriteLayout,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isNoFavouriteLayout = false;
                                          isFavouriteListLayout = true;
                                        });
                                      },
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                                child: Image.asset(
                                              img_no_favourit,
                                              width: 154.w,
                                              height: 160.h,
                                              fit: BoxFit.fill,
                                            )),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            // No Orders
                                            Text("No Favourites",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProBold,
                                                    fontSize: 16.sp),
                                                textAlign: TextAlign.center),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            // You don’t have any orders in your history
                                            Text(
                                                "You don’t have any favourites yet",
                                                style: TextStyle(
                                                    color: grey_77879e,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.center)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Visibility(
                                  //   visible: isFavouriteListLayout,
                                  //   child:  OfferListCommonLayout(),
                                  // )
                                ],
                              ),
                            ),
                          )
                        : Column(
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
                                itemCount: res!.data!.restaurantList!.length,
                                itemBuilder: (context, i) {
                                  DateTime now = DateTime.parse(res!
                                      .data!.restaurantList![i].dateCreated!);
                                  DateTime oneMonthAfter = DateTime(
                                      now.year, now.month + 1, now.day);
                                  var dateFormate = DateFormat('dd/MM/yyyy')
                                      .format(oneMonthAfter);
                                  var currentDate = DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now());
                                  var isOneMonthComplete =
                                      currentDate.compareTo(dateFormate);

                                  return GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           RestaurantDetailsScreen(
                                      //               restaurantId:
                                      //                   widget.response[i].restaurantId!
                                      //
                                      //               ///widget.response[i].restaurantId!
                                      //               ),
                                      //     ));
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 16.h, left: 6.w),
                                          decoration: cardboxDecoration,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                15.r),
                                                        topRight:
                                                            Radius.circular(
                                                                10.r),
                                                      ),
                                                      child: res!
                                                                  .data!
                                                                  .restaurantList![
                                                                      i]
                                                                  .restaurantImg ==
                                                              null
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
                                                              "https://bluedip.s3.ap-south-1.amazonaws.com/images/${res!.data!.restaurantList![i].restaurantImg!}",
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child: GetBuilder<
                                                            WishListViewModel>(
                                                          builder:
                                                              (wishlistDataController) {
                                                            return GestureDetector(
                                                                onTap:
                                                                    () async {},
                                                                child: SvgPicture
                                                                    .asset(
                                                                        icon_red_heart));
                                                          },
                                                        ),
                                                      )),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           RatingBarScreen(
                                                        //         type: "dine-in",
                                                        //         restoId: widget
                                                        //             .response[i]
                                                        //             .restaurantId!,
                                                        //         restoName: widget
                                                        //             .response[i]
                                                        //             .restaurantName!,
                                                        //       ),
                                                        //     ));
                                                        // selectRatingBar(context);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.w,
                                                                vertical: 7.h),
                                                        margin: EdgeInsets.all(
                                                            12.r),
                                                        decoration:
                                                            homeratingboxDecoration,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            // 4.5
                                                            Text(
                                                                "${res!.data!.restaurantList![i].avg}",
                                                                style: TextStyle(
                                                                    color:
                                                                        black_504f58,
                                                                    fontFamily:
                                                                        fontMavenProMedium,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        12.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            SvgPicture.asset(
                                                                icon_small_rating_bar),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            res!
                                                                        .data!
                                                                        .restaurantList![
                                                                            i]
                                                                        .ratingCount ==
                                                                    null
                                                                ? const SizedBox()
                                                                : Text(
                                                                    "(${res!.data!.restaurantList![i].ratingCount})",
                                                                    style: TextStyle(
                                                                        color:
                                                                            grey_77879e,
                                                                        fontFamily:
                                                                            fontMavenProMedium,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize: 10
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left)
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // McDonald’s
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            res!
                                                                    .data!
                                                                    .restaurantList![
                                                                        i]
                                                                    .restaurantName ??
                                                                "",
                                                            style: TextStyle(
                                                                color:
                                                                    black_504f58,
                                                                fontFamily:
                                                                    fontMavenProProSemiBold,
                                                                fontSize:
                                                                    15.sp),
                                                            textAlign:
                                                                TextAlign.left),
                                                        isOneMonthComplete == 0
                                                            ? SizedBox()
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: [
                                                                            Color(0xffff8a9e),
                                                                            Color(0xfff43f5e),
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(50)),
                                                                child: Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 10
                                                                            .w,
                                                                        vertical: 4
                                                                            .h),
                                                                    child: Text(
                                                                        "New",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            fontSize: 12
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.left)),
                                                              )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    // Sec 16, Dwarka, New Delhi
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        res!.data!.restaurantList![i]
                                                                    .restaurantLocationData ==
                                                                null
                                                            ? const SizedBox()
                                                            : Expanded(
                                                                child: Text(
                                                                    "${res!.data!.restaurantList![i].restaurantLocationData!.address}, ${res!.data!.restaurantList![i].restaurantLocationData!.cityName}, ${res!.data!.restaurantList![i].restaurantLocationData!.country}",

                                                                    ///"Sec 16, Dwarka, New Delhi ",
                                                                    style: TextStyle(
                                                                        color:
                                                                            grey_5f6d7b,
                                                                        fontFamily:
                                                                            fontMavenProRegular,
                                                                        fontStyle:
                                                                            FontStyle
                                                                                .normal,
                                                                        fontSize: 12
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left),
                                                              ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        res!.data!.restaurantList![i]
                                                                    .distanceKm ==
                                                                null
                                                            ? SizedBox()
                                                            : Container(
                                                                width: 3.w,
                                                                height: 3.w,
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        grey_5f6d7b),
                                                              ),
                                                        SizedBox(
                                                          width: 4.w,
                                                        ),
                                                        Text(
                                                            "${res!.data!.restaurantList![i].distanceKm ?? ""}",
                                                            style: TextStyle(
                                                                color:
                                                                    grey_5f6d7b,
                                                                fontFamily:
                                                                    fontMavenProRegular,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize:
                                                                    12.sp),
                                                            textAlign:
                                                                TextAlign.left),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    Row(
                                                      children: List.generate(
                                                        res!
                                                            .data!
                                                            .restaurantList![i]
                                                            .restaurantType!
                                                            .length,
                                                        (index) => Row(
                                                          children: [
                                                            res!.data!.restaurantList![i]
                                                                        .restaurantType![index] ==
                                                                    'dine-in'
                                                                ? Image.asset(
                                                                    icon_dinein_png,
                                                                    width: 14.w,
                                                                    height:
                                                                        14.h,
                                                                  )
                                                                : Image.asset(
                                                                    icon_takeaway_png,
                                                                    width: 14.w,
                                                                    height:
                                                                        14.h,
                                                                  ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            // Takeaway
                                                            Text(
                                                                res!
                                                                        .data!
                                                                        .restaurantList![
                                                                            i]
                                                                        .restaurantType![
                                                                    index],
                                                                style: TextStyle(
                                                                    color:
                                                                        grey_5f6d7b,
                                                                    fontFamily:
                                                                        fontMavenProRegular,
                                                                    fontSize:
                                                                        12.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),

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

                                                    res!
                                                                    .data!
                                                                    .restaurantList![
                                                                        i]
                                                                    .cuisine ==
                                                                null ||
                                                            res!
                                                                .data!
                                                                .restaurantList![
                                                                    i]
                                                                .cuisine!
                                                                .isEmpty
                                                        ? const SizedBox()
                                                        : SizedBox(
                                                            height: 22.h,
                                                            child: ListView
                                                                .builder(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              itemCount: res!
                                                                  .data!
                                                                  .restaurantList![
                                                                      i]
                                                                  .cuisine!
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                          index) =>
                                                                      Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right: 8
                                                                            .w),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5
                                                                            .r),
                                                                    color: Color(
                                                                        0xfff6f6f6)),
                                                                child: // Chicken
                                                                    Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          6.w,
                                                                      vertical:
                                                                          4.h),
                                                                  child: Text(
                                                                      res!.data!
                                                                              .restaurantList![i].cuisine![
                                                                          index],
                                                                      style: TextStyle(
                                                                          color:
                                                                              grey_77879e,
                                                                          fontFamily:
                                                                              fontMavenProRegular,
                                                                          fontSize: 12
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
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

                                        /// offer
                                        res!.data == [] ||
                                                res!.data!.restaurantList![i]
                                                        .offersData ==
                                                    []
                                            ? const SizedBox()
                                            : Column(
                                                children: List.generate(
                                                    res!
                                                                .data!
                                                                .restaurantList![
                                                                    i]
                                                                .offersData!
                                                                .length >
                                                            3
                                                        ? 3
                                                        : res!
                                                            .data!
                                                            .restaurantList![i]
                                                            .offersData!
                                                            .length, (index) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Image.asset(
                                                                  icon_blue_strip,
                                                                  width:
                                                                      210.w)),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              SizedBox(
                                                                width: 13.w,
                                                              ),
                                                              res!
                                                                          .data!
                                                                          .restaurantList![
                                                                              i]
                                                                          .offersData![
                                                                              index]
                                                                          .timeType ==
                                                                      "All day"
                                                                  ? SvgPicture
                                                                      .asset(
                                                                          icon_offer_white)
                                                                  : SvgPicture
                                                                      .asset(
                                                                          icon_flash_offer),
                                                              SizedBox(
                                                                width: 4.w,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // 60% OFF- Takeaway
                                                                  Text(
                                                                      "${res!.data!.restaurantList![i].offersData![index].offerPercentage} OFF- ${res!.data!.restaurantList![i].offersData![index].offerType}",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              fontMavenProMedium,
                                                                          fontStyle: FontStyle
                                                                              .normal,
                                                                          fontSize: 12
                                                                              .sp),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left),

                                                                  // Pick UP Between 5:30 - 7:00pm
                                                                  res!.data!.restaurantList![i].offersData![index].offerType ==
                                                                              "Takeaway" &&
                                                                          res!.data!.restaurantList![i].offersData![index].timeType ==
                                                                              "Time Limit"
                                                                      ? Text(
                                                                          "Pick Up Between ${res!.data!.restaurantList![i].offersData![index].timePeriod!.start} - ${res!.data!.restaurantList![i].offersData![index].timePeriod!.end}",
                                                                          style: TextStyle(
                                                                              color: const Color(
                                                                                  0xc9ffffff),
                                                                              fontFamily:
                                                                                  fontMavenProRegular,
                                                                              fontSize: 10
                                                                                  .sp),
                                                                          textAlign: TextAlign
                                                                              .left)
                                                                      : res!.data!.restaurantList![i].offersData![index].offerType == "Dine-in" &&
                                                                              res!.data!.restaurantList![i].offersData![index].timeType ==
                                                                                  "Time Limit"
                                                                          ? Text(
                                                                              "Arrive Between ${res!.data!.restaurantList![i].offersData![index].timePeriod!.start} - ${res!.data!.restaurantList![i].offersData![index].timePeriod!.end}",
                                                                              style: TextStyle(color: const Color(0xc9ffffff), fontFamily: fontMavenProRegular, fontSize: 10.sp),
                                                                              textAlign: TextAlign.left)
                                                                          : res!.data!.restaurantList![i].offersData![index].timeType == "All day"
                                                                              ? Text("Anytime Today", style: TextStyle(color: const Color(0xc9ffffff), fontFamily: fontMavenProRegular, fontSize: 10.sp), textAlign: TextAlign.left)
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
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}