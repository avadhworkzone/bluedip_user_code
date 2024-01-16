import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/resto_details_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/home/Homepage.dart';
import 'package:bluedip_user/viewModel/bottom_view_model.dart';
import 'package:bluedip_user/viewModel/resto_detail_view_model.dart';
import 'package:bluedip_user/viewModel/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Model/CityListModel.dart';
import '../../../Styles/my_colors.dart';
import '../../../Widget/back_button_square.dart';
import '../../../Widget/common_border_button.dart';
import '../../../modal/apiModel/response_modal/offer_data_res_model.dart';
import 'RestoDetailAmenitiesTab.dart';
import 'RestoDetailMenuTab.dart';
import 'RestoDetailOfferTab.dart';
import 'RestoDetailReviewTab.dart';
import 'dart:math' as math;

class RestaurantDetailsScreen extends StatefulWidget {
  RestaurantDetailsScreen({Key? key, required this.restaurantId})
      : super(key: key);
  String restaurantId;

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  TabController? tabController;
  int activeIndex = 0;
  double offset = 0.0;
  RestoDetailViewModel restoDetailViewModel = Get.find();
  RestaurantDetailsResModel? response;
  WishListViewModel wishListViewModel = Get.find();
  int? fromTime;
  int? toTime;
  int? current;
  String? closeDate;
  String? openDate;
  OfferDataResModel? offerDataResponse;
  BottomViewModel bottomViewModel = Get.find();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.offset;
      });
    });
    tabController = TabController(length: 4, vsync: this);
    tabController!.addListener(() {
      activeIndex = tabController!.index;
    });
    restoDetailApi();
  }

  offerDataApiCall() async {
    await restoDetailViewModel
        .offerDataViewModel(restoId: widget.restaurantId)
        .then((value) async {
      if (restoDetailViewModel.offerDataApiResponse.status == Status.COMPLETE) {
        offerDataResponse = restoDetailViewModel.offerDataApiResponse.data;
      }
    });
  }

  fetchDate() {
    int currentDayIndex;
    if (response != null ||
        response!.data != null ||
        response!.data!.hours != null ||
        response!.data!.hours!.isNotEmpty) {
      String day = DateFormat.EEEE().format(DateTime.now()).toLowerCase();
      Map<String, dynamic> hoursJson = response!.data!.hours!.first.toJson();

      /// key
      List<dynamic> key = hoursJson.keys.toList();

      currentDayIndex = key.indexWhere((element) => element == day);

      ///value
      List<dynamic> value = hoursJson.values.toList();

      Map<String, dynamic> currentData = value[currentDayIndex];
      closeDate = currentData['to'];
      openDate = currentData['from'];
      if (closeDate != "" || openDate != "") {
        DateTime now = DateTime.now();
        DateFormat format = DateFormat('h:mm a');
        String currentTime = format.format(now);

        int convertTimeToMinutes(String timeString) {
          DateFormat format = DateFormat('hh:mm a');
          DateTime dateTime = format.parse(timeString);

          int hours = dateTime.hour;
          int minutes = dateTime.minute;

          return (hours * 60) + minutes;
        }

        String from = currentData['from'];
        String to = currentData['to'];
        String timeString3 = currentTime;

        fromTime = convertTimeToMinutes(from);
        toTime = convertTimeToMinutes(to);
        current = convertTimeToMinutes(timeString3);
      }
    }
  }

  restoDetailApi() async {
    await restoDetailViewModel
        .restoDetails(restoId: widget.restaurantId)
        .then((value) async {
      if (restoDetailViewModel.restoDetailApiResponse.status ==
          Status.COMPLETE) {
        response = restoDetailViewModel.restoDetailApiResponse.data;

        if (response == null ||
            response!.data == null ||
            response!.data!.hours == null) {
        } else {
          fetchDate();
        }
      }
    });
    offerDataApiCall();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: GetBuilder<RestoDetailViewModel>(
          builder: (controller) {
            if (controller.restoDetailApiResponse.status == Status.LOADING ||
                controller.offerDataApiResponse.status == Status.LOADING) {
              return const CircularIndicator();
            }
            if (controller.restoDetailApiResponse.status == Status.ERROR ||
                controller.offerDataApiResponse.status == Status.ERROR) {
              return const ServerError();
            }
            if (controller.restoDetailApiResponse.status == Status.COMPLETE) {
              response = controller.restoDetailApiResponse.data;
            }
            return DefaultTabController(
              length: 4,
              child: NestedScrollView(
                controller: _scrollController,
                physics: const ScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: Get.width,
                      backgroundColor: Colors.white,
                      floating: false,
                      pinned: true,
                      elevation: 1,
                      stretch: true,
                      automaticallyImplyLeading: false,
                      leading: Padding(
                        padding: EdgeInsets.only(
                            left: 20.w, right: 3.w, bottom: 10.h, top: 10),
                        child: GestureDetector(
                            onTap: () {
                              bottomViewModel.currentIndex = 0;
                              Get.offAll(() => const BottomNavigationScreen());
                            },
                            child: Container(
                                width: 33.w,
                                height: 33.h,
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: white_ffffff),
                                child: SvgPicture.asset(icon_arrow_left))),
                      ),
                      flexibleSpace:
                          LayoutBuilder(builder: (context, constraints) {
                        bool isAppBarExpanded = constraints.maxHeight >
                            kToolbarHeight + MediaQuery.of(context).padding.top;
                        return FlexibleSpaceBar(
                            title: isAppBarExpanded
                                ? const SizedBox()
                                : Text(
                                    response!.data!.restaurantName ?? "N/A",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontOverpassBold,
                                        fontSize: 18.sp,
                                        letterSpacing: 0.18),
                                  ),
                            stretchModes: const [StretchMode.zoomBackground],
                            background: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      response!.data!.restaurantImg == null ||
                                              response!.data!.restaurantImg ==
                                                  ""
                                          ? Image.asset(
                                              'assets/images/bluedip_app_icon_second.png',
                                              height: 250.h,
                                              fit: BoxFit.cover,
                                              width: Get.width)
                                          : Image.network(
                                              "${response!.data!.restaurantImg}",
                                              fit: BoxFit.cover,
                                              height: 250.h,
                                              width: Get.width,
                                            ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 48.h, left: 24.w, right: 20.w),
                                        child: GetBuilder<WishListViewModel>(
                                          builder: (wishlistDataController) {
                                            return InkWell(
                                                onTap: () async {
                                                  if (wishlistDataController
                                                      .wishListLocalData
                                                      .containsKey(response!
                                                          .data!
                                                          .restaurantId)) {
                                                    wishlistDataController
                                                                .wishListLocalData[
                                                            response!.data!
                                                                .restaurantId]![
                                                        "isLike"] = !wishlistDataController
                                                                .wishListLocalData[
                                                            response!.data!
                                                                .restaurantId]![
                                                        "isLike"];
                                                  } else {
                                                    bool isLike = response!
                                                                .data!
                                                                .isFavourite ==
                                                            true
                                                        ? true
                                                        : false;
                                                    wishlistDataController
                                                        .wishListLocalData
                                                        .addAll({
                                                      response!.data!
                                                          .restaurantId!: {
                                                        "rName": response!.data!
                                                            .restaurantName,
                                                        "id": response!
                                                            .data!.restaurantId,
                                                        "img": response!.data!
                                                            .restaurantImg,
                                                        "isLike": !isLike
                                                      }
                                                    });
                                                  }
                                                  wishlistDataController
                                                      .update();
                                                  if (wishlistDataController
                                                      .wishListLocalData
                                                      .containsKey(response!
                                                          .data!
                                                          .restaurantId!)) {
                                                    if (wishlistDataController
                                                                .wishListLocalData[
                                                            response!.data!
                                                                .restaurantId]![
                                                        "isLike"]) {
                                                      await wishListViewModel
                                                          .wishList(
                                                              action:
                                                                  "add_favourite",
                                                              restaurantId:
                                                                  response!
                                                                      .data!
                                                                      .restaurantId);
                                                    } else {
                                                      await wishListViewModel
                                                          .wishList(
                                                              action:
                                                                  "add_favourite",
                                                              restaurantId:
                                                                  response!
                                                                      .data!
                                                                      .restaurantId);
                                                    }
                                                  } else {
                                                    bool isLike = response!
                                                                .data!
                                                                .isFavourite ==
                                                            true
                                                        ? true
                                                        : false;
                                                    if (isLike == true) {
                                                      await wishListViewModel
                                                          .wishList(
                                                              action:
                                                                  "add_favourite",
                                                              restaurantId:
                                                                  response!
                                                                      .data!
                                                                      .restaurantId);
                                                    } else {
                                                      await wishListViewModel
                                                          .wishList(
                                                              action:
                                                                  "add_favourite",
                                                              restaurantId:
                                                                  response!
                                                                      .data!
                                                                      .restaurantId);
                                                    }
                                                  }
                                                },
                                                child: SvgPicture.asset(wishlistDataController
                                                        .wishListLocalData
                                                        .containsKey(response!
                                                            .data!.restaurantId)
                                                    ? wishlistDataController
                                                                        .wishListLocalData[
                                                                    response!
                                                                        .data!
                                                                        .restaurantId]![
                                                                "isLike"] ==
                                                            true
                                                        ? icon_red_heart
                                                        : icon_white_heart
                                                    : response!.data!
                                                                .isFavourite ==
                                                            false
                                                        ? icon_white_heart
                                                        : icon_red_heart));
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // McDonald’s
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    response!.data!
                                                            .restaurantName ??
                                                        "N/A",
                                                    style:
                                                        TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontOverpassBold,
                                                            fontSize: 18.sp,
                                                            letterSpacing:
                                                                0.18),
                                                    textAlign: TextAlign.left),
                                                SizedBox(
                                                  height: 6.h,
                                                ),
                                                // Sec 16, Dwarka, New Delhi
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          "${response!.data!.restaurantLocationData!.address}, ${response!.data!.restaurantLocationData!.cityName}, ${response!.data!.restaurantLocationData!.country} • ${response!.data!.distanceKm}km",
                                                          // "Sec 16, Dwarka, New Delhi ",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_5f6d7b,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                    // SizedBox(
                                                    //   width: 4.w,
                                                    // ),
                                                    // Container(
                                                    //   width: 3.w,
                                                    //   height: 3.w,
                                                    //   decoration:
                                                    //       const BoxDecoration(
                                                    //           shape: BoxShape
                                                    //               .circle,
                                                    //           color:
                                                    //               grey_5f6d7b),
                                                    // ),
                                                    // SizedBox(
                                                    //   width: 4.w,
                                                    // ),
                                                    // response!.data!
                                                    //             .distanceKm ==
                                                    //         null
                                                    //     ? SizedBox()
                                                    //     : Text(
                                                    //         "${response!.data!.distanceKm}",
                                                    //         style: TextStyle(
                                                    //             color:
                                                    //                 grey_5f6d7b,
                                                    //             fontFamily:
                                                    //                 fontMavenProRegular,
                                                    //             fontStyle:
                                                    //                 FontStyle
                                                    //                     .normal,
                                                    //             fontSize:
                                                    //                 12.sp),
                                                    //         textAlign:
                                                    //             TextAlign.left),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          response!.data!.avg == null
                                              ? SizedBox()
                                              : Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 8.h),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: Color(0xfff6f6f6)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          // 4.5
                                                          Text(
                                                              "${response!.data!.avg}",
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      14.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                          SizedBox(
                                                            width: 2.w,
                                                          ),
                                                          SvgPicture.asset(
                                                            icon_small_rating_bar,
                                                            width: 14.w,
                                                            height: 14.h,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(
                                                          "(${response!.data!.ratingCount})",
                                                          style: TextStyle(
                                                              color:
                                                                  grey_77879e,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  ),
                                                )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Row(
                                        children: List.generate(
                                          response!
                                              .data!.restaurantType!.length,
                                          (index) => Row(
                                            children: [
                                              response!.data!.restaurantType![
                                                          index] ==
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
                                                  response!.data!
                                                      .restaurantType![index],
                                                  style: TextStyle(
                                                      color: grey_5f6d7b,
                                                      fontFamily:
                                                          fontMavenProRegular,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left),

                                              SizedBox(
                                                width: 12.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      response!.data!.cuisine == null ||
                                              response!.data!.cuisine!.isEmpty
                                          ? const SizedBox()
                                          : SizedBox(
                                              height: 22.h,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: response!
                                                    .data!.cuisine!.length,
                                                itemBuilder: (context, index) =>
                                                    Container(
                                                  margin: EdgeInsets.only(
                                                      right: 8.w),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      color: Color(0xfff6f6f6)),
                                                  child: // Chicken
                                                      Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6.w,
                                                            vertical: 4.h),
                                                    child: Text(
                                                        response!.data!
                                                            .cuisine![index],
                                                        style: TextStyle(
                                                            color: grey_77879e,
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 14.h,
                                      ),
                                      Row(
                                        children: [
                                          // Now Open
                                          current == null
                                              ? SizedBox()
                                              : Text(
                                                  current! > fromTime! &&
                                                          current! < toTime!
                                                      ? "Now Open"
                                                      : "Close",
                                                  style: TextStyle(
                                                      color: green_5cb85c,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left),

                                          SizedBox(
                                            width: 8.w,
                                          ),

                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectHours(
                                                    context: context,
                                                    hours:
                                                        response!.data!.hours!);
                                              },
                                              child: Row(
                                                children: [
                                                  current == null
                                                      ? SizedBox()
                                                      : current! >
                                                                  fromTime! &&
                                                              current! < toTime!
                                                          ? Text(
                                                              "Close ${closeDate}",
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize: 12
                                                                      .sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left)
                                                          : Text(
                                                              "Open ${openDate}",
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
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  current == null
                                                      ? SizedBox()
                                                      : SvgPicture.asset(
                                                          icon_down_arrow,
                                                          width: 5.w,
                                                          height: 5.h,
                                                        )
                                                ],
                                              ),
                                            ),
                                          ),

                                          Image.asset(
                                            icon_rupee_slim,
                                            width: 9.w,
                                            height: 9.h,
                                          ),
                                          // 500 for 2
                                          Text(
                                              "${response!.data!.averageCost} for 2",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: divider_d4dce7,
                                ),
                              ],
                            ));
                      }),
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        minHeight: 57,
                        maxHeight: 57,
                        child: Container(
                          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                          height: 35.h,
                          // color: bg_fafbfb,
                          decoration: const BoxDecoration(
                            color: white_ffffff,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1017191a),
                                blurRadius: 8.0,
                                offset: Offset(0.0, 3),
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                          width: double.infinity,
                          child: TabBar(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            labelPadding: EdgeInsets.zero,
                            isScrollable: true,
                            labelColor: Colors.white,
                            unselectedLabelColor: grey_969da8,
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: blue_007add),
                            tabs: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: const Tab(
                                  child: Text("Offers"),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: const Text("Menu"),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: const Text("Review"),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: const Text("Amenities"),
                                ),
                              ),
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
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  removeBottom: true,
                  child: Container(
                    color: bg_fafbfb,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TabBarView(
                            physics: const ScrollPhysics(),
                            controller: tabController,
                            children: [
                              RestoDetailOfferTab(response: offerDataResponse),
                              const RestoDetailMenuTab(),
                              const RestoDetailReviewTab(),
                              const RestoDetailAmenitiesTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void selectHours(
      {required BuildContext context, required List<Hours> hours}) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          List hoursData = [];

          hours.forEach((element) {
            hoursData.add(element);
          });
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Daily Opportunities
                                // Title
                                Center(
                                  child: Text("Opening Hours",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProBold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.center),
                                ),

                                SizedBox(
                                  height: 24.h,
                                ),

                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: divider_d4dce7,
                                ),

                                openingHours(
                                    daysName: 'Monday',
                                    timing:
                                        '${hours[0].monday!.from} - ${hours[0].monday!.to}'),
                                openingHours(
                                    daysName: 'Tuesday',
                                    timing:
                                        '${hours[0].tuesday!.from} - ${hours[0].tuesday!.to}'),
                                openingHours(
                                    daysName: 'Wednesday',
                                    timing:
                                        '${hours[0].wednesday!.from} - ${hours[0].wednesday!.to}'),
                                openingHours(
                                    daysName: 'Thursday',
                                    timing:
                                        '${hours[0].thursday!.from} - ${hours[0].thursday!.to}'),
                                openingHours(
                                    daysName: 'Friday',
                                    timing:
                                        '${hours[0].friday!.from} - ${hours[0].friday!.to}'),
                                openingHours(
                                    daysName: 'Saturday',
                                    timing:
                                        '${hours[0].saturday!.from} - ${hours[0].saturday!.to}'),
                                openingHours(
                                    daysName: 'Sunday',
                                    timing:
                                        '${hours[0].sunday!.from} - ${hours[0].sunday!.to}'),
                                // Row(
                                //   children: [
                                //     Text('Monday',
                                //         style: TextStyle(
                                //             color: grey_5f6d7b,
                                //             fontFamily: fontMavenProRegular,
                                //             fontSize: 14.sp),
                                //         textAlign: TextAlign.left),
                                //     Text("",
                                //         style: TextStyle(
                                //             color: grey_504f58,
                                //             fontFamily: fontMavenProRegular,
                                //             fontSize: 14.sp),
                                //         textAlign: TextAlign.right)
                                //     //   ListView.builder(
                                //     //   scrollDirection: Axis.vertical,
                                //     //   primary: false,
                                //     //   shrinkWrap: true,
                                //     //   padding: EdgeInsets.only(
                                //     //       top: 20.h, left: 16.w, right: 16.w),
                                //     //   itemCount: hoursList.length,
                                //     //   itemBuilder: (context, i) => Padding(
                                //     //     padding:
                                //     //         EdgeInsets.only(bottom: 18.h),
                                //     //     child: Row(
                                //     //       mainAxisAlignment:
                                //     //           MainAxisAlignment.spaceBetween,
                                //     //       children: [
                                //     //         // Sunday
                                //     //         // Text(hoursList[i],
                                //     //         //     style: TextStyle(
                                //     //         //         color: grey_5f6d7b,
                                //     //         //         fontFamily:
                                //     //         //             fontMavenProRegular,
                                //     //         //         fontSize: 14.sp),
                                //     //         //     textAlign: TextAlign.left),
                                //     //
                                //     //         // 10:00 AM - 11:00 PM
                                //     //       ],
                                //     //     ),
                                //     //   ),
                                //     // ),
                                //     // Text(
                                //     //     "${hours[i].monday!.from} - ${hours[i].monday!.to}",
                                //     //     style: TextStyle(
                                //     //         color: grey_504f58,
                                //     //         fontFamily: fontMavenProRegular,
                                //     //         fontSize: 14.sp),
                                //     //     textAlign: TextAlign.right)
                                //   ],
                                // )

                                // ListView.builder(
                                //   scrollDirection: Axis.vertical,
                                //   primary: false,
                                //   shrinkWrap: true,
                                //   padding: EdgeInsets.only(top: 10,),
                                //   itemCount: offerList.length,
                                //   itemBuilder: (context, i) =>   GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         mySelectConsultation = i;
                                //         if(i==2){
                                //           isReasonLayout = true;
                                //         }else{
                                //           isReasonLayout = false;
                                //         }
                                //       });
                                //     },
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(left: 16,top: 11,bottom: 11),
                                //       child: Container(
                                //         color: Colors.white,
                                //         child: Row(
                                //           mainAxisAlignment: MainAxisAlignment.start,
                                //           children: [
                                //             SvgPicture.asset(mySelectConsultation ==i ?icon_selected_radio:icon_unselected_radio),
                                //             SizedBox(width: 12.w,),
                                //             // Value Selected
                                //             Text(
                                //                 offerList[i].title,
                                //                 style:  TextStyle(
                                //                     color:  black_354356,
                                //                     fontWeight: FontWeight.w500,
                                //                     fontFamily: fontMavenProMedium,
                                //                     fontStyle:  FontStyle.normal,
                                //                     fontSize: 15.sp
                                //                 ),
                                //                 textAlign: TextAlign.left
                                //             )
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   )
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CommonBorderButton(
                        "Close".toUpperCase(),
                        () => Navigator.pop(context, false),
                        Colors.white,
                        Colors.white,
                        red_dc3642),
                  ],
                ),
              ));
        });
  }

  openingHours({required String daysName, required String timing}) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(daysName,
              style: TextStyle(
                  color: grey_5f6d7b,
                  fontFamily: fontMavenProRegular,
                  fontSize: 14.sp),
              textAlign: TextAlign.left),
          Text(timing,
              style: TextStyle(
                  color: grey_504f58,
                  fontFamily: fontMavenProRegular,
                  fontSize: 14.sp),
              textAlign: TextAlign.right)
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class HoursModelClass {
  final String? daysName;

  HoursModelClass({this.daysName});
}
