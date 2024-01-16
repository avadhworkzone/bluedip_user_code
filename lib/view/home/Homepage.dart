import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/Widget/home_rating_box_shadow.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/get_resturent_list_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_cuisine_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_order_list_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_resturent_list_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/Utility.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/home/RatingBarScreen.dart';
import 'package:bluedip_user/view/order/OrderDetailStatus.dart';
import 'package:bluedip_user/viewModel/get_restaurent_list_view_model.dart';
import 'package:bluedip_user/viewModel/wishlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/filter_box_shadow.dart';
import '../../Widget/search_bar_home.dart';
import '../../Widget/toolbar_with_title_cancel.dart';
import 'NotificationScreen.dart';
import '../../Widget/common_red_button.dart';
import 'resto_details/RestoDetailScreen.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int activeTabIndex = 0;
  bool statusOffer = false;
  GetRestaurantListResModel? response;
  // GetCuisineResModel? cuisineResponse;
  GetRestaurantListReqModel getRestaurantListReqModel =
      GetRestaurantListReqModel();
  GetRestaurantListViewModel getRestaurantListViewModel = Get.find();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  WishListViewModel wishListViewModel = Get.find();
  List cuisineList = [
    'African',
    'American',
    'Argentinian',
    'Asian',
    'Australian',
    'Bakery',
    'Bar',
    'Brazilian',
    'Breakfast',
    'Brunch',
    'Bubble Tea',
    'Buffet',
    'Burgers',
    'Cafe',
    'Caribbean',
    'Chinese',
    'Contemporary',
    'Dessert',
    'Dim Sum',
    'Donuts',
    'Dumplings',
    'European',
    'French',
    'Fried Chicken',
    'Greek',
    'Hot Pot',
    'Ice Cream',
    'Indian',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Kosher',
    'Latin American',
    'Lebanese',
    'Malaysian',
    'Mediterranean',
    'Mexican',
    'Middle Eastern',
    "Nepalese",
    'Nightclub',
    'Pizza',
    'Pub',
    'Ramen',
    'Ribs',
    'Salads',
    'Seafood',
    'Soup',
    'SouthEast Asian',
    'Spanish',
    'Sri Lankan',
    'Steak',
    'Tapas',
    'Thai',
    'Turkish',
    'Vegan',
    'Vegetarian',
    'Vietnamese',
    'Other'
  ];

  List<CityListModel> onOfferModel = [
    CityListModel("Relevance"),
    CityListModel("Rating: High to Low"),
    CityListModel("Cost: Low to High"),
    CityListModel("Cost: High to Low"),
  ];

  int mySelectConsultation = 0;
  String selectedDay = "";
  bool isLoading = false;
  bool isFirstTime = false;
  bool isFilterApply = false;
  bool isLoadingForNoData = false;
  GetOrderListResModel? orderListRes;

  ScrollController? scrollController;

  void _scrollDown() {
    scrollController!.jumpTo(scrollController!.position.maxScrollExtent);
  }

  initScrolling(BuildContext context) {
    scrollController = new ScrollController();

    scrollController!.addListener(() async {
      print("Scrolling");

      if (scrollController!.position.maxScrollExtent ==
          scrollController!.position.pixels) {
        _scrollDown();

        setState(() {});
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          getRestaurantListViewModel.pageNumber =
              getRestaurantListViewModel.pageNumber + 1;
          apiCall();
        });
      }
    });
  }

  initData() {
    isFirstTime = true;

    print('isFilterApply==${isFilterApply}');
    getRestaurantListViewModel.clearResponse();

    print('clear response==${getRestaurantListViewModel.restaurantListData}');
    initScrolling(context);
    apiCall();

    isFirstTime = false;
    setState(() {});
  }

  apiCall() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getRestaurantListReqModel.action = "get_restaurant_list";
      getRestaurantListReqModel.sorting = Utility.sorting;
      getRestaurantListReqModel.status = Utility.status;
      Utility.status == "distance"
          ? getRestaurantListReqModel.city_name =
              PreferenceManagerUtils.getCity().isEmpty
                  ? "Surat"
                  : PreferenceManagerUtils.getCity()
          : getRestaurantListReqModel.city_name = "";
      getRestaurantListReqModel.lat =
          PreferenceManagerUtils.getLatitude().isEmpty
              ? ""
              : PreferenceManagerUtils.getLatitude();
      getRestaurantListReqModel.lang =
          PreferenceManagerUtils.getLongitude().isEmpty
              ? ""
              : PreferenceManagerUtils.getLongitude();
      getRestaurantListReqModel.keyword = "";
      getRestaurantListReqModel.page = getRestaurantListViewModel.pageNumber;
      getRestaurantListReqModel.limit = 10;
      if (isFilterApply == true && Utility.filter != null) {
        getRestaurantListReqModel.filter = Utility.filter;
      }
      getRestaurantListReqModel.liveStatus = Utility.liveStatus;
      setState(() {});
      await getRestaurantListViewModel
          .restaurantList(body: getRestaurantListReqModel)
          .then((value) {
        if (getRestaurantListViewModel.getRestaurantApiResponse.status ==
            Status.COMPLETE) {
          response = getRestaurantListViewModel.getRestaurantApiResponse.data;
        }
      });
    });
  }

  // getCuisine() async {
  //   await getRestaurantListViewModel.getCuisineViewModel();
  //   getOrderList();
  // }

  getOrderList() async {
    await getRestaurantListViewModel.getOrderList().then((value) {
      if (getRestaurantListViewModel.getOrderListApiResponse.status ==
          Status.COMPLETE) {
        orderListRes = getRestaurantListViewModel.getOrderListApiResponse.data;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isFilterApply = false;
    Utility.status = "distance";
    Utility.sorting = "relevance";
    initData();
    getOrderList();
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        activeTabIndex = 0;
        activeTabIndex = _tabController!.index;
        print("Check$activeTabIndex");
      });
    });
  }

  List<CityListModel> onExtraSide = [
    CityListModel("Takeaway"),
    CityListModel("Dine-in"),
  ];

  List<String> selectedListCategory = [];

  List<String> onCategory = [
    "Veg Only",
    "Romantic Dining",
    "Lunch",
    "Dinner",
  ];

  List<String> selectedListCuisine = [];

  int _value = 1000;
  String _status = '2500';

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) _tabController!.dispose();
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
            alignment: Alignment.bottomCenter,
            children: [
              GetBuilder<GetRestaurantListViewModel>(
                builder: (controller) {
                  if (controller.getRestaurantApiResponse.status ==
                          Status.LOADING ||
                      controller.getCuisineApiResponse.status ==
                          Status.LOADING ||
                      controller.getOrderListApiResponse.status ==
                          Status.LOADING) {
                    return const CircularIndicator();
                  }

                  if (controller.getRestaurantApiResponse.status ==
                          Status.ERROR ||
                      controller.getCuisineApiResponse.status == Status.ERROR) {
                    return const SizedBox();
                  }
                  if (getRestaurantListViewModel
                          .getOrderListApiResponse.status ==
                      Status.COMPLETE) {
                    orderListRes =
                        getRestaurantListViewModel.getOrderListApiResponse.data;
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: NestedScrollView(
                            headerSliverBuilder: (context, value) {
                              return [
                                SliverToBoxAdapter(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Location
                                                          Text("Location",
                                                              style: TextStyle(
                                                                  color:
                                                                      grey_77879e,
                                                                  fontFamily:
                                                                      fontMavenProRegular,
                                                                  fontSize:
                                                                      14.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2.h),
                                                            child: SvgPicture.asset(
                                                                icon_down_arrow),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 2.h,
                                                      ),
                                                      response!.data!.userLocation ==
                                                              null
                                                          ? const SizedBox()
                                                          : Text(
                                                              "${response!.data!.userLocation!.address}",
                                                              style: TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      15.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start)
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const NotificationScreen(),
                                                        ));
                                                  },
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      SvgPicture.asset(
                                                        icon_notification,
                                                        width: 24.w,
                                                        height: 24.h,
                                                      ),
                                                      Container(
                                                        width: 6.w,
                                                        height: 6.h,
                                                        margin: EdgeInsets.only(
                                                            right: 5.w,
                                                            top: 1.5.h),
                                                        decoration:
                                                            const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    red_dc3642),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: SearchBarHome(
                                                      hintText: strFindFood,
                                                      onSubmitted: (String) {},
                                                      onChanged: (val) async {
                                                        getRestaurantListViewModel
                                                            .restaurantListData
                                                            .clear();
                                                        getRestaurantListReqModel
                                                                .action =
                                                            "get_restaurant_list";
                                                        getRestaurantListReqModel
                                                            .sorting = mySelectConsultation ==
                                                                0
                                                            ? "relevance"
                                                            : mySelectConsultation ==
                                                                    1
                                                                ? "rating-h-l"
                                                                : mySelectConsultation ==
                                                                        2
                                                                    ? "cost-l-h"
                                                                    : "cost-h-l";
                                                        getRestaurantListReqModel
                                                                .status =
                                                            activeTabIndex == 0
                                                                ? "distance"
                                                                : activeTabIndex ==
                                                                        1
                                                                    ? "best-deals"
                                                                    : "new";
                                                        getRestaurantListReqModel
                                                                .lat =
                                                            PreferenceManagerUtils
                                                                .getLatitude();
                                                        getRestaurantListReqModel
                                                                .lang =
                                                            PreferenceManagerUtils
                                                                .getLongitude();
                                                        getRestaurantListReqModel
                                                            .keyword = val;

                                                        await getRestaurantListViewModel
                                                            .restaurantList(
                                                                body:
                                                                    getRestaurantListReqModel);
                                                      },
                                                    )),
                                                GestureDetector(
                                                  onTap: () async {
                                                    filterScreen();
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //       builder: (context) =>
                                                    //           const filterScreen(),
                                                    //     ));
                                                  },
                                                  child: Container(
                                                    height: 50.h,
                                                    width: 50.w,
                                                    margin: EdgeInsets.only(
                                                        left: 16.w),
                                                    decoration:
                                                        filterboxDecoration,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.r),
                                                      child: SvgPicture.asset(
                                                          icon_filter),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ];
                            },
                            body: RefreshIndicator(
                              key: _refreshIndicatorKey,
                              color: Colors.white,
                              backgroundColor: Colors.red,
                              onRefresh: () {
                                getOrderList();
                                return initData();
                              },
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    height: 36.h,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await selectSortBy(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 6.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                border: Border.all(
                                                    width: 1,
                                                    color: grey_d9dde3)),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(icon_sort),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Text("Sort",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign:
                                                        TextAlign.center),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                SvgPicture.asset(icon_shape),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        TabBar(
                                          onTap: (val) async {
                                            activeTabIndex = val;
                                            if (activeTabIndex == 0) {
                                              setState(() {
                                                isFilterApply = false;
                                                mySelectConsultation = 0;
                                                getRestaurantListViewModel
                                                    .pageNumber = 1;
                                                Utility.sorting = "relevance";
                                                Utility.status = "distance";

                                                initData();
                                              });
                                            } else if (activeTabIndex == 1) {
                                              setState(() {
                                                isFilterApply = false;
                                                mySelectConsultation = 0;
                                                getRestaurantListViewModel
                                                    .pageNumber = 1;
                                                Utility.sorting = "relevance";
                                                Utility.status = "best-deals";
                                                initData();
                                              });
                                            } else {
                                              isFilterApply = false;
                                              mySelectConsultation = 0;
                                              getRestaurantListViewModel
                                                  .pageNumber = 1;
                                              Utility.sorting = "relevance";
                                              Utility.status = "new";
                                              setState(() {});
                                              initData();
                                            }
                                          },
                                          controller: _tabController,
                                          //   padding: EdgeInsets.only(right: 16),
                                          indicatorPadding: EdgeInsets.only(
                                              right: 20.w, left: 5.w),
                                          labelPadding:
                                              EdgeInsets.only(right: 16.w),
                                          labelColor: red_dc3642,
                                          unselectedLabelStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: fontMavenProRegular,
                                              color: grey_77879e),
                                          labelStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: fontMavenProMedium,
                                              color: red_dc3642),
                                          unselectedLabelColor: grey_77879e,
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                "Distance",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              child: activeTabIndex == 1
                                                  ? Column(
                                                      children: [
                                                        Text(
                                                          "Best Deals",
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        // Within 2Km
                                                        Text("Within 2Km",
                                                            style: TextStyle(
                                                                fontSize: 9.sp),
                                                            textAlign: TextAlign
                                                                .center)
                                                      ],
                                                    )
                                                  : Text(
                                                      "Best Deals",
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                            ),
                                            Tab(
                                              child: Text(
                                                " New ",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                          indicator: MaterialIndicator(
                                            color: red_dc3642,
                                            height: 2,
                                            topLeftRadius: 6,
                                            topRightRadius: 6,
                                            bottomLeftRadius: 6,
                                            bottomRightRadius: 6,
                                            tabPosition: TabPosition.bottom,
                                          ),
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          isScrollable: true,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16.h),
                                              child: Row(
                                                children: [
                                                  // Restaurants near you
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        "Restaurants near you",
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontMavenProBold,
                                                            fontSize: 16.sp,
                                                            letterSpacing: 0.5),
                                                        textAlign:
                                                            TextAlign.left),
                                                  ),

                                                  // Live offers
                                                  Text("Live offers ",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.right),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),

                                                  FlutterSwitch(
                                                    width: 40.0,
                                                    height: 23.0,
                                                    activeColor: green_5cb85c,
                                                    inactiveColor: grey_e2e3e5,
                                                    valueFontSize: 0.0,
                                                    toggleSize: 16.0,
                                                    value: statusOffer,
                                                    borderRadius: 15.0,
                                                    padding: 3.0,
                                                    showOnOff: true,
                                                    onToggle: (val) {
                                                      setState(() {
                                                        statusOffer = val;
                                                        isFilterApply = false;
                                                        Utility.status =
                                                            activeTabIndex == 0
                                                                ? "distance"
                                                                : activeTabIndex ==
                                                                        1
                                                                    ? "best-deals"
                                                                    : "new";
                                                        Utility
                                                            .sorting = mySelectConsultation ==
                                                                0
                                                            ? "relevance"
                                                            : mySelectConsultation ==
                                                                    1
                                                                ? "rating-h-l"
                                                                : mySelectConsultation ==
                                                                        2
                                                                    ? "cost-l-h"
                                                                    : "cost-h-l";
                                                        Utility.liveStatus =
                                                            val == true
                                                                ? true
                                                                : false;
                                                        initData();
                                                        print(
                                                            'statusOffer==${statusOffer}');
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // GetBuilder(
                                            //   builder: (controller) {
                                            //
                                            //     return
                                            // controller.isPageLoadAll == true
                                            //     ? SizedBox(
                                            //         height: Get.height / 2,
                                            //         width: Get.width,
                                            //         child:
                                            //             const CircularIndicator())
                                            //     :
                                            // controller.isPageLoadAll ==
                                            //                     false &&
                                            controller.restaurantListData ==
                                                        [] ||
                                                    controller
                                                        .restaurantListData
                                                        .isEmpty
                                                ? SizedBox(
                                                    height: Get.height / 2,
                                                    width: Get.width,
                                                    child: const NoDataFound())
                                                : Column(
                                                    children: [
                                                      // OfferListCommonLayout(
                                                      //     response: controller
                                                      //         .restaurantListData,
                                                      //     controller:
                                                      //         scrollController),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 4.h,
                                                            ),
                                                            itemCount: controller
                                                                .restaurantListData
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              DateTime now = DateTime
                                                                  .parse(controller
                                                                      .restaurantListData[
                                                                          i]
                                                                      .dateCreated!);
                                                              DateTime
                                                                  oneMonthAfter =
                                                                  DateTime(
                                                                      now.year,
                                                                      now.month +
                                                                          1,
                                                                      now.day);
                                                              var dateFormate =
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .format(
                                                                          oneMonthAfter);
                                                              var currentDate =
                                                                  DateFormat(
                                                                          'dd/MM/yyyy')
                                                                      .format(DateTime
                                                                          .now());
                                                              var isOneMonthComplete =
                                                                  currentDate
                                                                      .compareTo(
                                                                          dateFormate);

                                                              return GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await PreferenceManagerUtils.setRestoId(
                                                                      controller
                                                                          .restaurantListData[
                                                                              i]
                                                                          .restaurantId!);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => RestaurantDetailsScreen(
                                                                            restaurantId:
                                                                                controller.restaurantListData[i].restaurantId!

                                                                            ///widget.response[i].restaurantId!
                                                                            ),
                                                                      ));
                                                                },
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          bottom: 16
                                                                              .h,
                                                                          left:
                                                                              6.w),
                                                                      decoration:
                                                                          cardboxDecoration,
                                                                      child:
                                                                          Column(
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
                                                                                  borderRadius: BorderRadius.only(
                                                                                    topLeft: Radius.circular(15.r),
                                                                                    topRight: Radius.circular(10.r),
                                                                                  ),
                                                                                  child: controller.restaurantListData[i].restaurantImg == null || controller.restaurantListData[i].restaurantImg == ""
                                                                                      ? Image.asset('assets/images/bluedip_app_icon_second.png', height: 175.h, fit: BoxFit.cover, width: Get.width)
                                                                                      //bluedip_app_icon_second
                                                                                      // Image.network(
                                                                                      //         'https://service.sarawak.gov.my/web/web/web/web/res/no_image.png',
                                                                                      //         fit: BoxFit.fill,
                                                                                      //         height: 172.h,
                                                                                      //         width: Get.width,
                                                                                      //       )
                                                                                      : Image.network(
                                                                                          controller.restaurantListData[i].restaurantImg!,
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
                                                                                              if (wishlistDataController.wishListLocalData.containsKey(controller.restaurantListData[i].restaurantId)) {
                                                                                                wishlistDataController.wishListLocalData[controller.restaurantListData[i].restaurantId]!["isLike"] = !wishlistDataController.wishListLocalData[controller.restaurantListData[i].restaurantId]!["isLike"];
                                                                                              } else {
                                                                                                bool isLike = controller.restaurantListData[i].isFavourite == true ? true : false;
                                                                                                wishlistDataController.wishListLocalData.addAll({
                                                                                                  controller.restaurantListData[i].restaurantId!: {
                                                                                                    "rName": controller.restaurantListData[i].restaurantName,
                                                                                                    "id": controller.restaurantListData[i].restaurantId,
                                                                                                    "img": controller.restaurantListData[i].restaurantImg,
                                                                                                    "isLike": !isLike
                                                                                                  }
                                                                                                });
                                                                                              }
                                                                                              wishlistDataController.update();
                                                                                              // if (PreferenceUtils
                                                                                              //         .getUserId()
                                                                                              //     .isNotEmpty) {
                                                                                              if (wishlistDataController.wishListLocalData.containsKey(controller.restaurantListData[i].restaurantId!)) {
                                                                                                if (wishlistDataController.wishListLocalData[controller.restaurantListData[i].restaurantId]!["isLike"]) {
                                                                                                  // productAddToWishlistReqModel
                                                                                                  //         .productId =
                                                                                                  //     newArrivalData.id;
                                                                                                  // productAddToWishlistReqModel
                                                                                                  //         .userId =
                                                                                                  //     PreferenceUtils
                                                                                                  //         .getUserId();
                                                                                                  await wishListViewModel.wishList(action: "add_favourite", restaurantId: controller.restaurantListData[i].restaurantId);
                                                                                                } else {
                                                                                                  // removeWishlistReqModel
                                                                                                  //         .productId =
                                                                                                  //     newArrivalData.id;
                                                                                                  // removeWishlistReqModel
                                                                                                  //         .userId =
                                                                                                  //     PreferenceUtils
                                                                                                  //         .getUserId();
                                                                                                  await wishListViewModel.wishList(action: "add_favourite", restaurantId: controller.restaurantListData[i].restaurantId);
                                                                                                }
                                                                                              } else {
                                                                                                bool isLike = controller.restaurantListData[i].isFavourite == true ? true : false;
                                                                                                if (isLike == true) {
                                                                                                  // removeWishlistReqModel
                                                                                                  //         .productId =
                                                                                                  //     newArrivalData.id;
                                                                                                  // removeWishlistReqModel
                                                                                                  //         .userId =
                                                                                                  //     PreferenceUtils
                                                                                                  //         .getUserId();
                                                                                                  await wishListViewModel.wishList(action: "add_favourite", restaurantId: controller.restaurantListData[i].restaurantId);
                                                                                                } else {
                                                                                                  await wishListViewModel.wishList(action: "add_favourite", restaurantId: controller.restaurantListData[i].restaurantId);
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
                                                                                            child: SvgPicture.asset(wishlistDataController.wishListLocalData.containsKey(controller.restaurantListData[i].restaurantId)
                                                                                                ? wishlistDataController.wishListLocalData[controller.restaurantListData[i].restaurantId]!["isLike"] == true
                                                                                                    ? icon_red_heart
                                                                                                    : icon_white_heart
                                                                                                : controller.restaurantListData[i].isFavourite == false
                                                                                                    ? icon_white_heart
                                                                                                    : icon_red_heart));
                                                                                      },
                                                                                    ),
                                                                                  )),
                                                                              controller.restaurantListData[i].avg == null
                                                                                  ? SizedBox()
                                                                                  : Align(
                                                                                      alignment: Alignment.bottomRight,
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => RatingBarScreen(
                                                                                                  type: "dine-in",
                                                                                                  restoId: controller.restaurantListData[i].restaurantId!,
                                                                                                  restoName: controller.restaurantListData[i].restaurantName!,
                                                                                                ),
                                                                                              ));
                                                                                          // selectRatingBar(context);
                                                                                        },
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
                                                                                          margin: EdgeInsets.all(12.r),
                                                                                          decoration: homeratingboxDecoration,
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.min,
                                                                                            children: [
                                                                                              // 4.5
                                                                                              Text(controller.restaurantListData[i].avg ?? "", style: TextStyle(color: black_504f58, fontFamily: fontMavenProMedium, fontStyle: FontStyle.normal, fontSize: 12.sp), textAlign: TextAlign.left),
                                                                                              SizedBox(
                                                                                                width: 2.w,
                                                                                              ),
                                                                                              SvgPicture.asset(icon_small_rating_bar),
                                                                                              SizedBox(
                                                                                                width: 2.w,
                                                                                              ),
                                                                                              Text("(${controller.restaurantListData[i].ratingCount})", style: TextStyle(color: grey_77879e, fontFamily: fontMavenProMedium, fontStyle: FontStyle.normal, fontSize: 10.sp), textAlign: TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(12.r),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                // McDonald’s
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(controller.restaurantListData[i].restaurantName ?? "", style: TextStyle(color: black_504f58, fontFamily: fontMavenProProSemiBold, fontSize: 15.sp), textAlign: TextAlign.left),
                                                                                    isOneMonthComplete == 0
                                                                                        ? const SizedBox()
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
                                                                                                borderRadius: BorderRadius.circular(50)),
                                                                                            child: Padding(padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h), child: Text("New", style: TextStyle(color: Colors.white, fontFamily: fontMavenProMedium, fontSize: 12.sp), textAlign: TextAlign.left)),
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
                                                                                    controller.restaurantListData[i].restaurantLocationData == null
                                                                                        ? const SizedBox()
                                                                                        : Expanded(
                                                                                            child: Text("${controller.restaurantListData[i].restaurantLocationData!.area ?? ""}${controller.restaurantListData[i].restaurantLocationData!.area == null ? "" : ','} ${controller.restaurantListData[i].restaurantLocationData!.cityName} • ${controller.restaurantListData[i].distanceKm}Km",

                                                                                                ///"Sec 16, Dwarka, New Delhi ",
                                                                                                style: TextStyle(color: grey_5f6d7b, fontFamily: fontMavenProRegular, fontStyle: FontStyle.normal, fontSize: 12.sp),
                                                                                                textAlign: TextAlign.left),
                                                                                          ),
                                                                                    SizedBox(
                                                                                      width: 4.w,
                                                                                    ),
                                                                                    // Container(
                                                                                    //   width: 3.w,
                                                                                    //   height: 3.w,
                                                                                    //   decoration: const BoxDecoration(shape: BoxShape.circle, color: grey_5f6d7b),
                                                                                    // ),
                                                                                    // SizedBox(
                                                                                    //   width: 4.w,
                                                                                    // ),
                                                                                    // Text("${controller.restaurantListData[i].distanceKm}", style: TextStyle(color: grey_5f6d7b, fontFamily: fontMavenProRegular, fontStyle: FontStyle.normal, fontSize: 12.sp), textAlign: TextAlign.left),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 12.h,
                                                                                ),
                                                                                Row(
                                                                                  children: List.generate(
                                                                                    controller.restaurantListData[i].restaurantType!.length,
                                                                                    (index) => Row(
                                                                                      children: [
                                                                                        controller.restaurantListData[i].restaurantType![index] == 'dine-in'
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
                                                                                        Text(controller.restaurantListData[i].restaurantType![index], style: TextStyle(color: grey_5f6d7b, fontFamily: fontMavenProRegular, fontSize: 12.sp), textAlign: TextAlign.left),

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

                                                                                controller.restaurantListData[i].cuisine == null || controller.restaurantListData[i].cuisine!.isEmpty
                                                                                    ? const SizedBox()
                                                                                    : SizedBox(
                                                                                        height: 22.h,
                                                                                        child: ListView.builder(
                                                                                          scrollDirection: Axis.horizontal,
                                                                                          primary: false,
                                                                                          shrinkWrap: true,
                                                                                          itemCount: controller.restaurantListData[i].cuisine!.length,
                                                                                          itemBuilder: (context, index) => Container(
                                                                                            margin: EdgeInsets.only(right: 8.w),
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r), color: Color(0xfff6f6f6)),
                                                                                            child: // Chicken
                                                                                                Padding(
                                                                                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                                                                                              child: Text(controller.restaurantListData[i].cuisine![index], style: TextStyle(color: grey_77879e, fontFamily: fontMavenProRegular, fontSize: 12.sp), textAlign: TextAlign.center),
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
                                                                    controller.restaurantListData ==
                                                                                [] ||
                                                                            controller.restaurantListData[i].offersData ==
                                                                                []
                                                                        ? const SizedBox()
                                                                        : Column(
                                                                            children:
                                                                                List.generate(controller.restaurantListData[i].offersData!.length > 3 ? 3 : controller.restaurantListData[i].offersData!.length, (index) {
                                                                              return Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  SizedBox(height: 5.5),
                                                                                  Stack(
                                                                                    alignment: Alignment.center,
                                                                                    children: [
                                                                                      Align(alignment: Alignment.topLeft, child: Image.asset(icon_blue_strip, width: 210.w)),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 13.w,
                                                                                          ),
                                                                                          controller.restaurantListData[i].offersData![index].timeType == "All day" ? SvgPicture.asset(icon_offer_white) : SvgPicture.asset(icon_flash_offer),
                                                                                          SizedBox(
                                                                                            width: 4.w,
                                                                                          ),
                                                                                          Column(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              // 60% OFF- Takeaway
                                                                                              Text("${controller.restaurantListData[i].offersData![index].offerPercentage} OFF- ${controller.restaurantListData[i].offersData![index].offerType}", style: TextStyle(color: Colors.white, fontFamily: fontMavenProMedium, fontStyle: FontStyle.normal, fontSize: 12.sp), textAlign: TextAlign.left),

                                                                                              // Pick UP Between 5:30 - 7:00pm
                                                                                              controller.restaurantListData[i].offersData![index].offerType == "Takeaway" && controller.restaurantListData[i].offersData![index].timeType == "Time Limit"
                                                                                                  ? Text("Pick Up Between ${controller.restaurantListData[i].offersData![index].timePeriod!.start} - ${controller.restaurantListData[i].offersData![index].timePeriod!.end}", style: TextStyle(color: const Color(0xc9ffffff), fontFamily: fontMavenProRegular, fontSize: 10.sp), textAlign: TextAlign.left)
                                                                                                  : controller.restaurantListData[i].offersData![index].offerType == "Dine-in" && controller.restaurantListData[i].offersData![index].timeType == "Time Limit"
                                                                                                      ? Text("Arrive Between ${controller.restaurantListData[i].offersData![index].timePeriod!.start} - ${controller.restaurantListData[i].offersData![index].timePeriod!.end}", style: TextStyle(color: const Color(0xc9ffffff), fontFamily: fontMavenProRegular, fontSize: 10.sp), textAlign: TextAlign.left)
                                                                                                      : controller.restaurantListData[i].offersData![index].timeType == "All day"
                                                                                                          ? Text("Anytime Today", style: TextStyle(color: const Color(0xc9ffffff), fontFamily: fontMavenProRegular, fontSize: 10.sp), textAlign: TextAlign.left)
                                                                                                          : SizedBox()
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),

                                                                                  // SizedBox(
                                                                                  //   height: 3.h,
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
                                                      ),
                                                      if (controller
                                                              .isPageLoadAll ==
                                                          true)
                                                        SizedBox(
                                                          height:
                                                              Get.height / 2,
                                                          width: Get.width,
                                                          child:
                                                              const CircularIndicator(),
                                                        )
                                                    ],
                                                  ),
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // TabBarView(
                                    //     physics: const ScrollPhysics(),
                                    //     controller: _tabController,
                                    //     children: [
                                    //       SingleChildScrollView(
                                    //         child: Padding(
                                    //           padding:
                                    //               EdgeInsets.symmetric(horizontal: 16.w),
                                    //           child: Column(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment.start,
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Padding(
                                    //                 padding: EdgeInsets.symmetric(
                                    //                     vertical: 16.h),
                                    //                 child: Row(
                                    //                   children: [
                                    //                     // Restaurants near you
                                    //                     Expanded(
                                    //                       flex: 1,
                                    //                       child: Text(
                                    //                           "Restaurants near you",
                                    //                           style: TextStyle(
                                    //                               color: black_504f58,
                                    //                               fontFamily:
                                    //                                   fontMavenProBold,
                                    //                               fontSize: 16.sp,
                                    //                               letterSpacing: 0.5),
                                    //                           textAlign: TextAlign.left),
                                    //                     ),
                                    //
                                    //                     // Live offers
                                    //                     Text("Live offers ",
                                    //                         style: TextStyle(
                                    //                             color: grey_5f6d7b,
                                    //                             fontFamily:
                                    //                                 fontMavenProRegular,
                                    //                             fontSize: 14.sp),
                                    //                         textAlign: TextAlign.right),
                                    //                     SizedBox(
                                    //                       width: 6.w,
                                    //                     ),
                                    //
                                    //                     FlutterSwitch(
                                    //                       width: 40.0,
                                    //                       height: 23.0,
                                    //                       activeColor: green_5cb85c,
                                    //                       inactiveColor: grey_e2e3e5,
                                    //                       valueFontSize: 0.0,
                                    //                       toggleSize: 16.0,
                                    //                       value: statusOffer,
                                    //                       borderRadius: 15.0,
                                    //                       padding: 3.0,
                                    //                       showOnOff: true,
                                    //                       onToggle: (val) {
                                    //                         setState(() {
                                    //                           statusOffer = val;
                                    //                         });
                                    //                       },
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               GetBuilder<GetRestaurantListViewModel>(
                                    //                 builder: (controller) {
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.LOADING) {
                                    //                     return CircularIndicator();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.ERROR) {
                                    //                     return ServerError();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.COMPLETE) {
                                    //                     response = controller
                                    //                         .getRestaurantApiResponse
                                    //                         .data;
                                    //                   }
                                    //                   return response == null ||
                                    //                           response!.data == null ||
                                    //                           response!.data!.isEmpty
                                    //                       ? NoDataFound()
                                    //                       : OfferListCommonLayout(
                                    //                           response: response!);
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SingleChildScrollView(
                                    //         child: Padding(
                                    //           padding:
                                    //               EdgeInsets.symmetric(horizontal: 16.w),
                                    //           child: Column(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment.start,
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Padding(
                                    //                 padding: EdgeInsets.symmetric(
                                    //                     vertical: 16.h),
                                    //                 child: Row(
                                    //                   children: [
                                    //                     // Restaurants near you
                                    //                     Expanded(
                                    //                       flex: 1,
                                    //                       child: Text(
                                    //                           "Restaurants near you",
                                    //                           style: TextStyle(
                                    //                               color: black_504f58,
                                    //                               fontFamily:
                                    //                                   fontMavenProBold,
                                    //                               fontSize: 16.sp,
                                    //                               letterSpacing: 0.5),
                                    //                           textAlign: TextAlign.left),
                                    //                     ),
                                    //
                                    //                     // Live offers
                                    //                     Text("Live offers ",
                                    //                         style: TextStyle(
                                    //                             color: grey_5f6d7b,
                                    //                             fontFamily:
                                    //                                 fontMavenProRegular,
                                    //                             fontSize: 14.sp),
                                    //                         textAlign: TextAlign.right),
                                    //                     SizedBox(
                                    //                       width: 6.w,
                                    //                     ),
                                    //
                                    //                     FlutterSwitch(
                                    //                       width: 40.0,
                                    //                       height: 23.0,
                                    //                       activeColor: green_5cb85c,
                                    //                       inactiveColor: grey_e2e3e5,
                                    //                       valueFontSize: 0.0,
                                    //                       toggleSize: 16.0,
                                    //                       value: statusOffer,
                                    //                       borderRadius: 15.0,
                                    //                       padding: 3.0,
                                    //                       showOnOff: true,
                                    //                       onToggle: (val) {
                                    //                         setState(() {
                                    //                           statusOffer = val;
                                    //                         });
                                    //                       },
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               GetBuilder<GetRestaurantListViewModel>(
                                    //                 builder: (controller) {
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.LOADING) {
                                    //                     return CircularIndicator();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.ERROR) {
                                    //                     return ServerError();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.COMPLETE) {
                                    //                     response = controller
                                    //                         .getRestaurantApiResponse
                                    //                         .data;
                                    //                   }
                                    //                   return response == null ||
                                    //                           response!.data == null ||
                                    //                           response!.data!.isEmpty
                                    //                       ? NoDataFound()
                                    //                       : OfferListCommonLayout(
                                    //                           response: response!);
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       SingleChildScrollView(
                                    //         child: Padding(
                                    //           padding:
                                    //               EdgeInsets.symmetric(horizontal: 16.w),
                                    //           child: Column(
                                    //             mainAxisAlignment:
                                    //                 MainAxisAlignment.start,
                                    //             crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //             children: [
                                    //               Padding(
                                    //                 padding: EdgeInsets.symmetric(
                                    //                     vertical: 16.h),
                                    //                 child: Row(
                                    //                   children: [
                                    //                     // Restaurants near you
                                    //                     Expanded(
                                    //                       flex: 1,
                                    //                       child: Text(
                                    //                           "Restaurants near you",
                                    //                           style: TextStyle(
                                    //                               color: black_504f58,
                                    //                               fontFamily:
                                    //                                   fontMavenProBold,
                                    //                               fontSize: 16.sp,
                                    //                               letterSpacing: 0.5),
                                    //                           textAlign: TextAlign.left),
                                    //                     ),
                                    //
                                    //                     // Live offers
                                    //                     Text("Live offers ",
                                    //                         style: TextStyle(
                                    //                             color: grey_5f6d7b,
                                    //                             fontFamily:
                                    //                                 fontMavenProRegular,
                                    //                             fontSize: 14.sp),
                                    //                         textAlign: TextAlign.right),
                                    //                     SizedBox(
                                    //                       width: 6.w,
                                    //                     ),
                                    //
                                    //                     FlutterSwitch(
                                    //                       width: 40.0,
                                    //                       height: 23.0,
                                    //                       activeColor: green_5cb85c,
                                    //                       inactiveColor: grey_e2e3e5,
                                    //                       valueFontSize: 0.0,
                                    //                       toggleSize: 16.0,
                                    //                       value: statusOffer,
                                    //                       borderRadius: 15.0,
                                    //                       padding: 3.0,
                                    //                       showOnOff: true,
                                    //                       onToggle: (val) {
                                    //                         setState(() {
                                    //                           statusOffer = val;
                                    //                         });
                                    //                       },
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               GetBuilder<GetRestaurantListViewModel>(
                                    //                 builder: (controller) {
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.LOADING) {
                                    //                     return CircularIndicator();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.ERROR) {
                                    //                     return ServerError();
                                    //                   }
                                    //                   if (controller
                                    //                           .getRestaurantApiResponse
                                    //                           .status ==
                                    //                       Status.COMPLETE) {
                                    //                     response = controller
                                    //                         .getRestaurantApiResponse
                                    //                         .data;
                                    //                   }
                                    //                   return response == null ||
                                    //                           response!.data == null ||
                                    //                           response!.data!.isEmpty
                                    //                       ? NoDataFound()
                                    //                       : OfferListCommonLayout(
                                    //                           response: response!);
                                    //                 },
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       )
                                    //     ]
                                    //     // tabBodyWidgets,
                                    //     ),
                                  ),

                                  // SizedBox(
                                  //   height: 60.h,
                                  // )
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                },
              ),
              GetBuilder<GetRestaurantListViewModel>(
                builder: (controller) {
                  return orderListRes == null || orderListRes!.data == null
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Get.to(OrderDetailStatus(
                              orderId: orderListRes!.data!.orderId.toString(),
                            ));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(14.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.r),
                                topRight: Radius.circular(18.r),
                              ),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xffee92a2),
                                    Color(0xffe55488)
                                  ]),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                orderListRes!.data!.restaurantData!
                                                .restaurantImg ==
                                            null ||
                                        orderListRes!.data!.restaurantData!
                                                .restaurantImg ==
                                            ""
                                    ? const SizedBox()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        child: Image.network(
                                            height: Get.width * 0.1,
                                            width: Get.width * 0.09,
                                            fit: BoxFit.cover,
                                            "${orderListRes!.data!.restaurantData!.restaurantImg}")),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                      "${orderListRes!.data!.restaurantData!.restaurantName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: fontOverpassBold,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.left),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Pickup at: 9:00 PM
                                    Text(
                                        "Pickup at: ${orderListRes!.data!.time}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.left),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    orderListRes!.data!.orderStatus ==
                                            "PAYMENT_COMPLETED"
                                        ? SizedBox()
                                        : Text(
                                            "${orderListRes!.data!.orderStatus}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 14.sp),
                                            textAlign: TextAlign.left)
                                  ],
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                orderListRes!.data!.orderStatus ==
                                        "PAYMENT_COMPLETED"
                                    ? SizedBox()
                                    : SvgPicture.asset(
                                        icon_next_arrow,
                                        color: Colors.white,
                                        width: 24.w,
                                        height: 24.w,
                                      )
                              ],
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  selectSortBy(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
          return StatefulBuilder(builder:
              (BuildContext context, setModalState /*You can rename this!*/) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.r),
                      topRight: Radius.circular(13.r),
                    )),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13.r),
                              topRight: Radius.circular(13.r),
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Daily Opportunities
                                  // Title
                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Sort By",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProBold,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.center),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: SvgPicture.asset(
                                              icon_cancel,
                                              color: grey_77879e,
                                            ))
                                      ],
                                    ),
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
                                                  print(
                                                      'mySelectConsultation--${mySelectConsultation}');
                                                },
                                              );
                                              // setState(() {});
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
                                                    Text(onOfferModel[i].title,
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
                                            ),
                                          )),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                        top: 20.h,
                                        bottom: 30.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: CommonBorderButton(
                                                "Clear All".toUpperCase(),
                                                () async {
                                              isFilterApply = false;
                                              mySelectConsultation = 0;
                                              getRestaurantListViewModel
                                                  .pageNumber = 1;
                                              // getRestaurantListReqModel.action =
                                              //     "get_restaurant_list";
                                              Utility.sorting = "relevance";
                                              Utility.status =
                                                  activeTabIndex == 0
                                                      ? "distance"
                                                      : activeTabIndex == 1
                                                          ? "best-deals"
                                                          : "new";
                                              initData();
                                              // getRestaurantListReqModel.lat =
                                              //     PreferenceManagerUtils
                                              //         .getLatitude();
                                              // getRestaurantListReqModel.lang =
                                              //     PreferenceManagerUtils
                                              //         .getLongitude();
                                              // getRestaurantListReqModel
                                              //     .keyword = "";
                                              //
                                              // await getRestaurantListViewModel
                                              //     .restaurantList(
                                              //         body:
                                              //             getRestaurantListReqModel);
                                              Navigator.of(context).pop();
                                            }, red_dc3642, Colors.transparent,
                                                red_dc3642)),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: GetBuilder<
                                              GetRestaurantListViewModel>(
                                            builder: (controller) {
                                              return CommonRedButton(
                                                  "Apply".toUpperCase(),
                                                  () async {
                                                isFilterApply = false;
                                                getRestaurantListViewModel
                                                    .pageNumber = 1;
                                                Utility.sorting =
                                                    mySelectConsultation == 0
                                                        ? "relevance"
                                                        : mySelectConsultation ==
                                                                1
                                                            ? "rating-h-l"
                                                            : mySelectConsultation ==
                                                                    2
                                                                ? "cost-l-h"
                                                                : "cost-h-l";
                                                Utility.status =
                                                    activeTabIndex == 0
                                                        ? "distance"
                                                        : activeTabIndex == 1
                                                            ? "best-deals"
                                                            : "new";
                                                initData();

                                                /// api call
                                                // getRestaurantListReqModel
                                                //         .action =
                                                //     "get_restaurant_list";
                                                // getRestaurantListReqModel
                                                //         .sorting =
                                                //     mySelectConsultation == 0
                                                //         ? "relevance"
                                                //         : mySelectConsultation ==
                                                //                 1
                                                //             ? "rating-h-l"
                                                //             : mySelectConsultation ==
                                                //                     2
                                                //                 ? "cost-l-h"
                                                //                 : "cost-h-l";
                                                // getRestaurantListReqModel
                                                //         .status =
                                                //     activeTabIndex == 0
                                                //         ? "distance"
                                                //         : activeTabIndex == 1
                                                //             ? "best-deals"
                                                //             : "new";
                                                // getRestaurantListReqModel.lat =
                                                //     PreferenceManagerUtils
                                                //         .getLatitude();
                                                // getRestaurantListReqModel.lang =
                                                //     PreferenceManagerUtils
                                                //         .getLongitude();
                                                // getRestaurantListReqModel
                                                //     .keyword = "";
                                                //
                                                // await getRestaurantListViewModel
                                                //     .restaurantList(
                                                //         body:
                                                //             getRestaurantListReqModel);
                                                ///end

                                                // setModalState(() {
                                                //   isLoading = false;
                                                //   response =
                                                //       getRestaurantListViewModel
                                                //           .getRestaurantApiResponse
                                                //           .data;
                                                //
                                                //   print(
                                                //       'new res==${jsonEncode(response)}');

                                                Get.back();

                                                // });
                                                // if (getRestaurantListViewModel
                                                //         .getRestaurantApiResponse
                                                //         .status ==
                                                //     Status.COMPLETE) {

                                                // }
                                              }, red_dc3642);
                                            },
                                          ),
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

  List<String> selectedType = [];
  List<String> restoType = [];
  Filter filter = Filter();
  filterScreen() {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        String _status_percentage = '20';
        int _value_percentage = 5;
        return StatefulBuilder(
          builder: (context, setState) {
            return FractionallySizedBox(
              heightFactor: 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ToolbarWithTitleCancel(
                      title: "Filter",
                      onTap: () async {
                        print('on tap clicked');
                        setState(() {
                          selectedListCuisine.clear();
                          _status = '';
                          _status_percentage = '';
                          selectedListCategory.clear();
                          selectedType.clear();
                          filter.restaurantType = [];
                          filter.select = [];
                          filter.offerPercentage = "";
                          filter.averageCost = "";
                          filter.cuisine = [];
                          Utility.filter = filter;
                          isFilterApply = false;
                          Utility.filter = null;
                          print('filter is null==${Utility.filter}');
                          // getRestaurantListReqModel.action =
                          //     "get_restaurant_list";
                          Utility.sorting = "relevance";
                          Utility.status = activeTabIndex == 0
                              ? "distance"
                              : activeTabIndex == 1
                                  ? "best-deals"
                                  : "new";
                          initData();
                        });

                        Navigator.pop(context, false);
                      }),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 20.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /*Select Type*/
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: white_ffffff,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Color(0x40d3d1d8),
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  padding: EdgeInsets.only(
                                      left: 14.w, top: 14.w, bottom: 5.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // How was your food?
                                      Text("Select Type",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily:
                                                  fontMavenProProSemiBold,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                      // SizedBox(height: 14.h,),

                                      GridView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: 3.h,
                                                  mainAxisSpacing: 0.0,
                                                  crossAxisSpacing: 10.0),
                                          itemCount: onExtraSide.length,
                                          itemBuilder: (context, i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  setState(
                                                    () {
                                                      if (selectedType.contains(
                                                          onExtraSide[i]
                                                              .title)) {
                                                        selectedType.remove(
                                                            onExtraSide[i]
                                                                .title);
                                                      } else {
                                                        selectedType.add(
                                                            onExtraSide[i]
                                                                .title);
                                                      }
                                                      print(
                                                          '=======selectedType===${selectedType}');

                                                      // selectedType
                                                      //     .add(onExtraSide[i].title);
                                                      // print(
                                                      //     'selectedType----${selectedType}');
                                                      // if (selectedList.contains(
                                                      //     onExtraSide[i].title)) {
                                                      //   selectedList
                                                      //       .remove(onExtraSide[i].title);
                                                      // } else {
                                                      //   selectedList
                                                      //       .add(onExtraSide[i].title);
                                                      // }
                                                    },
                                                  );
                                                  // setState(() {
                                                  // final removedBrackets = selectedList.toString().substring(1, selectedList.toString().length - 1);
                                                  // final parts = removedBrackets.split(', ');
                                                  //
                                                  // var joined = parts.map((part) => "$part").join(', ');
                                                  //
                                                  // print(joined);
                                                  // MyConstant.strdays=joined;
                                                  // });
                                                },
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      SvgPicture.asset(
                                                        selectedType.contains(
                                                                onExtraSide[i]
                                                                    .title)
                                                            ? icon_selected_checkbox
                                                            : icon_unselected_checkbox,
                                                        width: 20.w,
                                                        height: 20.h,
                                                      ),
                                                      SizedBox(
                                                        width: 8.w,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 18),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                onExtraSide[i]
                                                                    .title,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      black_504f58,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontSize:
                                                                      14.sp,
                                                                  //overflow: TextOverflow.ellipsis
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    ],
                                  ),
                                ),
                                /*Select Category*/
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: white_ffffff,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Color(0x40d3d1d8),
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  padding: EdgeInsets.only(
                                      left: 14.w, top: 14.w, bottom: 14.h),
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // How was your food?
                                        Text("Select",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily:
                                                    fontMavenProProSemiBold,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.left),
                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        Wrap(
                                          children: [
                                            ...List.generate(
                                              onCategory.length,
                                              (index) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedListCategory
                                                        .contains(onCategory[
                                                            index])) {
                                                      selectedListCategory
                                                          .remove(onCategory[
                                                              index]);
                                                    } else {
                                                      selectedListCategory.add(
                                                          onCategory[index]);
                                                    }
                                                    print(
                                                        "Click checking=====${selectedListCategory}");
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 8.w, bottom: 8.h),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: selectedListCategory
                                                                .contains(
                                                                    onCategory[
                                                                        index])
                                                            ? red_dc3642
                                                            : grey_d9dde3),
                                                    color: selectedListCategory
                                                            .contains(
                                                                onCategory[
                                                                    index])
                                                        ? Color(0x14dc3642)
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14.w,
                                                      vertical: 5.h),
                                                  child: Text(
                                                    onCategory[index],
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14.sp),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ]),
                                ),
                                /*Offer Percentage Cost*/
                                Container(
                                  decoration: BoxDecoration(
                                      color: white_ffffff,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Color(0x40d3d1d8),
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  padding: EdgeInsets.all(14.r),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Average Cost for 2
                                          Text("Offer Percentage",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Cost:
                                              Text("Offer:",
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right),

                                              // 2500
                                              Text("${_value_percentage * 5}%",
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right)
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      SliderTheme(
                                        data: SliderThemeData(
                                          // here
                                          trackHeight: 6,
                                          thumbColor: Blue_5468ff,

                                          //    thumbShape: SliderThumbImage(customImage,context),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                  overlayRadius: 1),
                                          // thumbShape: const CircleThumbShape(thumbRadius: 20),
                                          trackShape: CustomTrackShape(),
                                        ),
                                        child: Slider(
                                            value:
                                                (_value_percentage.toDouble() *
                                                    5),
                                            min: 10.0,
                                            max: 50.0,
                                            // divisions: 8,
                                            // secondaryTrackValue: 0.5,
                                            activeColor: red_dc3642,
                                            inactiveColor: light_red_ffd7d7,
                                            label: 'Set volume value',
                                            onChanged: (double newValue) {
                                              setState(() {
                                                _value_percentage =
                                                    (newValue / 5).toInt();
                                                _status_percentage =
                                                    '${_value_percentage.toInt()}';
                                              });
                                            },
                                            semanticFormatterCallback:
                                                (double newValue) {
                                              return '${newValue.round()} dollars';
                                            }),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // 500
                                          Text("10%",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.right),

                                          Text("50%",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.right)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                /*Average Cost*/
                                Container(
                                  decoration: BoxDecoration(
                                      color: white_ffffff,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Color(0x40d3d1d8),
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  padding: EdgeInsets.all(14.r),
                                  margin: EdgeInsets.symmetric(vertical: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Average Cost for 2
                                          Text("Average Cost for 2",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              // Cost:
                                              Text("Cost:",
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right),

                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 12.w,
                                                height: 12.w,
                                                color: red_dc3642,
                                              ),
                                              Text("$_status",
                                                  style: TextStyle(
                                                      color: red_dc3642,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right)
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.h,
                                      ),
                                      SliderTheme(
                                        data: SliderThemeData(
                                          // here
                                          trackHeight: 6,
                                          thumbColor: Blue_5468ff,
                                          //    thumbShape: SliderThumbImage(customImage,context),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                                  overlayRadius: 1),
                                          // thumbShape: const CircleThumbShape(thumbRadius: 20),
                                          trackShape: CustomTrackShape(),
                                        ),
                                        child: Slider(
                                            value: _value.toDouble(),
                                            min: 500.0,
                                            max: 5000.0,
                                            activeColor: red_dc3642,
                                            inactiveColor: light_red_ffd7d7,
                                            label: 'Set volume value',
                                            onChanged: (double newValue) {
                                              setState(() {
                                                _value = newValue.toInt();
                                                _status = '${_value.toInt()}';
                                              });
                                            },
                                            semanticFormatterCallback:
                                                (double newValue) {
                                              return '${newValue.round()} dollars';
                                            }),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 12.w,
                                                height: 12.w,
                                                color: black_504f58,
                                              ),
                                              Text("500",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                icon_rupee_slim,
                                                width: 12.w,
                                                height: 12.w,
                                                color: black_504f58,
                                              ),
                                              Text("5000+",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.right),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                /*Select Cuisine*/
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: white_ffffff,
                                      boxShadow: [
                                        BoxShadow(
                                          // color: Color(0x40d3d1d8),
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(
                                            0,
                                            0,
                                          ),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.0,
                                        )
                                      ],
                                      // border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.r))),
                                  padding: EdgeInsets.only(
                                      left: 14.w, top: 14.w, bottom: 14.h),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // How was your food?
                                        Text("Cuisine",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily:
                                                    fontMavenProProSemiBold,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.left),

                                        SizedBox(
                                          height: 14.h,
                                        ),
                                        getRestaurantListViewModel.isMore ==
                                                false
                                            ? Wrap(
                                                children: [
                                                  ...List.generate(
                                                    6,
                                                    (index) => Wrap(
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (selectedListCuisine
                                                                      .contains(
                                                                          cuisineList[
                                                                              index])) {
                                                                    selectedListCuisine
                                                                        .remove(
                                                                            cuisineList[index]);
                                                                  } else {
                                                                    selectedListCuisine.add(
                                                                        cuisineList[
                                                                            index]);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8.w,
                                                                        bottom:
                                                                            8.h),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: selectedListCuisine
                                                                              .contains(cuisineList[index])
                                                                          ? red_dc3642
                                                                          : grey_d9dde3),
                                                                  color: selectedListCuisine.contains(
                                                                          cuisineList[
                                                                              index])
                                                                      ? const Color(
                                                                          0x14dc3642)
                                                                      : Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.r),
                                                                ),
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 14
                                                                            .w,
                                                                        vertical:
                                                                            5.h),
                                                                child: Text(
                                                                    cuisineList[
                                                                        index],
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
                                                                        fontSize:
                                                                            14.sp)),
                                                              ),
                                                            ),
                                                            if (index == 5)
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    getRestaurantListViewModel
                                                                            .isMore =
                                                                        true;
                                                                    print(
                                                                        'isMore====->>${getRestaurantListViewModel.isMore}');
                                                                  });
                                                                },
                                                                child: Text(
                                                                  'Add More',
                                                                  style: TextStyle(
                                                                      color:
                                                                          red_dc3642,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize:
                                                                          15.sp),
                                                                ),
                                                              )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Wrap(
                                                children: [
                                                  ...List.generate(
                                                    cuisineList.length,
                                                    (index) => GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (selectedListCuisine
                                                              .contains(
                                                                  cuisineList[
                                                                      index])) {
                                                            selectedListCuisine
                                                                .remove(
                                                                    cuisineList[
                                                                        index]);
                                                          } else {
                                                            selectedListCuisine
                                                                .add(
                                                                    cuisineList[
                                                                        index]);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 8.w,
                                                            bottom: 8.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: selectedListCuisine
                                                                      .contains(
                                                                          cuisineList[
                                                                              index])
                                                                  ? red_dc3642
                                                                  : grey_d9dde3),
                                                          color: selectedListCuisine
                                                                  .contains(
                                                                      cuisineList[
                                                                          index])
                                                              ? const Color(
                                                                  0x14dc3642)
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    14.w,
                                                                vertical: 5.h),
                                                        child: Text(
                                                            cuisineList[index],
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
                                                                fontSize:
                                                                    14.sp)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ]),
                                ),
                                /*Select Rating*/
                                // Container(
                                //   width: double.infinity,
                                //   decoration: cardboxDecoration,
                                //   margin: EdgeInsets.symmetric(vertical: 20.h),
                                //   padding: EdgeInsets.only(left: 14.w,top: 14.w,bottom: 14.h),
                                //   child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         // How was your food?
                                //         Text(
                                //             "Rating",
                                //             style:  TextStyle(
                                //                 color:  black_504f58,
                                //                 fontFamily: fontMavenProProSemiBold,
                                //                 fontSize: 15.sp
                                //             ),
                                //             textAlign: TextAlign.left
                                //         ),
                                //
                                //         SizedBox(height: 14.h,),
                                //         SizedBox(
                                //           height: 30,
                                //           child: ListView.separated(
                                //               scrollDirection: Axis.horizontal,
                                //               primary: false,
                                //               shrinkWrap: true,
                                //               separatorBuilder: (BuildContext context, int i) =>
                                //                   SizedBox(
                                //                     width: 14.w,
                                //                   ),
                                //
                                //               itemCount: onRating.length,
                                //               itemBuilder: (context, i) =>
                                //                     GestureDetector(
                                //                       onTap: () {
                                //                       setState(() {
                                //
                                //                         mySelectConsultation = i;
                                //                         selectedDay = ( onRating[i].title);
                                //                       });
                                //
                                //
                                //                       },
                                //                       child: Wrap(
                                //                       children: [Container(
                                //
                                //                         decoration: BoxDecoration(
                                //                             borderRadius: BorderRadius.circular(8.r),
                                //                             color:mySelectConsultation ==i ?Color(0x14dc3642):Colors.white,
                                //                             border: Border.all(
                                //                                 width: 1,
                                //                                 color:mySelectConsultation ==i ? red_dc3642:grey_d9dde3
                                //                             )
                                //                         ),
                                //                         padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 5.h),
                                //                         child: // All
                                //                         Center(
                                //                           child: Text(
                                //                               onRating[i].title,
                                //                               style:  TextStyle(
                                //                                   color:  black_504f58,
                                //                                   fontFamily: fontMavenProMedium,
                                //                                   fontSize: 14.sp
                                //                               ),
                                //                               textAlign: TextAlign.center
                                //                           ),
                                //                         ),
                                //                       ),],
                                //                       ),
                                //                     )
                                //             ),
                                //
                                //
                                //
                                //           ),
                                //
                                //
                                //       ]
                                //   ),
                                // ),

                                SizedBox(
                                  height: 30.h,
                                ),
                                CommonRedButton(strSubmit.toUpperCase(),
                                    () async {
                                  isFilterApply = true;
                                  // getRestaurantListReqModel.action =
                                  //     "get_restaurant_list";
                                  Utility.sorting = mySelectConsultation == 0
                                      ? "relevance"
                                      : mySelectConsultation == 1
                                          ? "rating-h-l"
                                          : mySelectConsultation == 2
                                              ? "cost-l-h"
                                              : "cost-h-l";
                                  Utility.status = activeTabIndex == 0
                                      ? "distance"
                                      : activeTabIndex == 1
                                          ? "best-deals"
                                          : "new";
                                  // getRestaurantListReqModel.lat =
                                  //     PreferenceManagerUtils.getLatitude();
                                  // getRestaurantListReqModel.lang =
                                  //     PreferenceManagerUtils.getLongitude();
                                  // getRestaurantListReqModel.keyword = "";
                                  filter.restaurantType = selectedType;
                                  filter.select = selectedListCategory;
                                  filter.offerPercentage = _status_percentage;
                                  filter.averageCost = _status;
                                  filter.cuisine = selectedListCuisine;
                                  Utility.filter = filter;
                                  initData();
                                  // await getRestaurantListViewModel
                                  //     .restaurantList(
                                  //         body: getRestaurantListReqModel);
                                  FocusScope.of(context).unfocus();
                                  Get.back();
                                }, red_dc3642),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 1.3;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
