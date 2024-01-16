import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/get_resturent_list_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_resturent_list_res_model.dart';
import 'package:bluedip_user/view/home/resto_details/RestoDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../Widget/circular_progrss_indicator.dart';
import '../../../modal/apis/api_response.dart';
import '../../../utils/shared_preference_utils.dart';
import '../../../viewModel/get_restaurent_list_view_model.dart';

class NewDeals extends StatefulWidget {
  const NewDeals({Key? key}) : super(key: key);

  @override
  State<NewDeals> createState() => _NewDealsState();
}

class _NewDealsState extends State<NewDeals> {
  bool statusOffer = false;

  bool isNew = true;
  int myposition = 1;
  GetRestaurantListReqModel getRestaurantListReqModel =
      GetRestaurantListReqModel();
  GetRestaurantListViewModel getRestaurantListViewModel = Get.find();
  GetRestaurantListResModel? response;

  getRestaurantListApiCall() async {
    getRestaurantListReqModel.action = "get_restaurant_list";
    getRestaurantListReqModel.sorting = "relevance";
    getRestaurantListReqModel.status = "new";
    getRestaurantListReqModel.lat = PreferenceManagerUtils.getLatitude();
    getRestaurantListReqModel.lang = PreferenceManagerUtils.getLongitude();
    getRestaurantListReqModel.keyword = "";
    await getRestaurantListViewModel.restaurantList(
        body: getRestaurantListReqModel);
  }

  @override
  void initState() {
    getRestaurantListApiCall();
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
        backgroundColor: white_ffffff,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    children: [
                      // Restaurants near you
                      Expanded(
                        flex: 1,
                        child: Text("New Deals for you",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProBold,
                                fontSize: 16.sp,
                                letterSpacing: 0.5),
                            textAlign: TextAlign.left),
                      ),

                      // Live offers
                      Text("Live offers ",
                          style: TextStyle(
                              color: grey_5f6d7b,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          textAlign: TextAlign.right),
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
                          });
                        },
                      ),
                    ],
                  ),
                ),
                GetBuilder<GetRestaurantListViewModel>(
                  builder: (controller) {
                    if (controller.getRestaurantApiResponse.status ==
                        Status.LOADING) {
                      return CircularIndicator();
                    }
                    if (controller.getRestaurantApiResponse.status ==
                        Status.ERROR) {
                      return ServerError();
                    }
                    if (controller.getRestaurantApiResponse.status ==
                        Status.COMPLETE) {
                      response = controller.getRestaurantApiResponse.data;
                    }
                    return response == null ||
                            response!.data == null ||
                            response!.data!.restaurantList!.isEmpty
                        ? const NoDataFound()
                        : const SizedBox();
                    // OfferListCommonLayout(response: response!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
