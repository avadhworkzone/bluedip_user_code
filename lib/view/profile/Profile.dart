import 'dart:io';

import 'package:bluedip_user/Model/HoursModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/common_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_user_detail_res_model.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/profile/profile_menu/FavouriteScreen.dart';
import 'package:bluedip_user/view/profile/profile_menu/OrderHistory.dart';
import 'package:bluedip_user/view/select_location/SelecLocationList.dart';
import 'package:bluedip_user/viewModel/auth_view_model.dart';
import 'package:bluedip_user/viewModel/user_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';
import '../../modal/apis/api_response.dart';
import '../auth/WelcomeScreen.dart';
import '../auth/location_screen.dart';
import '../bottomsheets/BottomSheetLogout.dart';
import '../bottomsheets/BottomSheetSupport.dart';
import 'ProfileDetail.dart';
import 'RestaurantLocation.dart';
import 'profile_menu/TermsAndCondition.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  List<HoursModel> accountList = [
    HoursModel(icon_location_pin_map_red, "Location"),
    HoursModel(icon_favorite_red, "Favourite"),
    HoursModel(icon_order_red, "Orders"),
    HoursModel(icon_play_start_red, "Tour of Bluedip"),
    HoursModel(icon_support_red, "Help & Support"),
    HoursModel(icon_terms_condition_red, "Terms & Conditions"),
    HoursModel(icon_delete_red, "Delete Account"),
    HoursModel(icon_log_out_red, "Log Out"),
  ];
  AuthViewModel authViewModel = AuthViewModel();
  UserDetailViewModel userDetailViewModel = Get.find();
  GetUserDetailResModel? response;

  getUserDetailApi() async {
    await userDetailViewModel.getUserDetail();
    if (userDetailViewModel.userDetailApiResponse.status == Status.COMPLETE) {
      response = userDetailViewModel.userDetailApiResponse.data;
    }
  }

  @override
  void initState() {
    getUserDetailApi();
    // TODO: implement initState
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

    return SafeArea(
        child: Scaffold(
      backgroundColor: bg_fafbfb,
      body: GetBuilder<UserDetailViewModel>(
        builder: (controller) {
          if (controller.userDetailApiResponse.status == Status.LOADING) {
            return const CircularIndicator();
          }
          if (controller.userDetailApiResponse.status == Status.ERROR) {
            return const ServerError();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0017191a),
                      offset: Offset(
                        0.0,
                        3.0,
                      ),
                      blurRadius: 21.0,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                child: Text("Profile",
                    style: TextStyle(
                        color: black_504f58,
                        fontWeight: FontWeight.w700,
                        fontFamily: fontOverpassBold,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.sp),
                    textAlign: TextAlign.left),
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
                        GestureDetector(
                          onTap: () async {
                            await Get.to(() => const ProfileDetail())
                                ?.then((value) => setState(() {}));
                          },
                          child: Container(
                            decoration: cardboxDecoration,
                            padding: EdgeInsets.all(14.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                response!.data!.userImg == "" ||
                                        response!.data!.userImg == null
                                    ? Image.asset(
                                        bluedip_app_icon,
                                        width: 92.w,
                                        height: 92.h,
                                        fit: BoxFit.fill,
                                      )
                                    : CircleAvatar(
                                        radius: 27.w,
                                        backgroundImage: NetworkImage(
                                          "${response!.data!.userImg}",
                                        ),
                                      ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          PreferenceManagerUtils.getUserName()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.center),
                                      const SizedBox(height: 5),
                                      Text("${response!.data!.emailId ?? ""}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.center),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(icon_next_arrow)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        /*Listview Layout*/
                        Container(
                          decoration: cardboxDecoration,
                          padding: EdgeInsets.only(
                              left: 14.w, right: 14.w, top: 12.h, bottom: 24.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: accountList.length,
                                  //   padding: EdgeInsets.only(bottom: 10),
                                  itemBuilder: (context, i) => Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (i == 0) {
                                                requestLocationPermission();
                                                // Get.to(() =>
                                                //     const SelecLocationList());

                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           SelecLocationListProfile(),
                                                //     ));
                                              } else if (i == 2) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const OrderHistory(),
                                                    ));
                                              } else if (i == 6) {
                                                selectDelete(context);
                                              } else if (i == 7) {
                                                selectLogout(context);
                                              } else if (i == 1) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          FavouriteScreen(),
                                                    ));
                                              } else if (i == 4) {
                                                selectSupport(context);
                                              } else if (i == 5) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TermsAndCondition(),
                                                    ));
                                              }
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 40.w,
                                                    height: 40.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(11.r),
                                                        color: bg_fafbfb),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(9.r),
                                                      child: SvgPicture.asset(
                                                          accountList[i].day),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 21.w,
                                                  ),
                                                  // Restaurant Hours
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            accountList[i].time,
                                                            style: TextStyle(
                                                                color:
                                                                    black_504f58,
                                                                fontFamily:
                                                                    fontMavenProMedium,
                                                                fontSize:
                                                                    15.sp),
                                                            textAlign:
                                                                TextAlign.left),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        i == 0
                                                            ? Text(
                                                                response!
                                                                        .data!
                                                                        .restaurantLocationData!
                                                                        .address ??
                                                                    "",
                                                                style: TextStyle(
                                                                    color:
                                                                        grey_5f6d7b,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontFamily:
                                                                        fontMavenProRegular,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontSize:
                                                                        12.sp),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left)
                                                            : SizedBox()
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          i == accountList.length - 1
                                              ? SizedBox()
                                              : Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 12.h,
                                                    ),
                                                    const Divider(
                                                      thickness: 0.5,
                                                      height: 0.5,
                                                      indent: 60,
                                                      color: divider_d4dce7,
                                                    ),
                                                  ],
                                                )
                                        ],
                                      )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // App vr. 1.221.11
                        Center(
                          child: Text("App vr. 1.221.11",
                              style: TextStyle(
                                  color: grey_77879e,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.left),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));
  }

  void selectDelete(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
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
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            // Daily Opportunities
                            Center(
                              child: Text("Delete Bluedip Account",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontOverpassBold,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 18.sp,
                                      height: 1.5),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            // Are you sure you would like to delete your Bluedip account?
                            Center(
                              child: Text(
                                  "Are you sure you would like to delete \nyour Bluedip account?",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProMedium,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.sp),
                                  textAlign: TextAlign.center),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            /*bottom two buttons here*/
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: CommonRedButton(
                                        strCancel.toUpperCase(), () {
                                      Get.back();
                                    }, red_dc3642)),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: CommonBorderButton(
                                        "Delete".toUpperCase(), () async {
                                      await authViewModel.deleteUserViewModel();

                                      CommonResModel res = authViewModel
                                          .deleteUserApiResponse.data;

                                      if (authViewModel
                                              .deleteUserApiResponse.status ==
                                          Status.COMPLETE) {
                                        if (res.status == true) {
                                          await PreferenceManagerUtils
                                              .clearPreference();
                                          Get.offAll(
                                              () => const WelcomeScreen());
                                        } else {
                                          snackBar(title: res.message);
                                        }
                                      }
                                    }, red_dc3642, Colors.transparent,
                                        red_dc3642)),
                              ],
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void selectLogout(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (
          BuildContext context,
        ) {
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
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13)),
                  child: Column(
                    children: [BottomSheetLogout()],
                  ),
                ),
              ));
        });
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
}

Future<void> requestLocationPermission() async {
  final permissionStatus = await Permission.location.status;
  print('permissionStatus:=>$permissionStatus');
  if (await Permission.location.request().isGranted ||
      await Permission.locationWhenInUse.request().isGranted) {
    try {
      await Geolocator.getCurrentPosition();
      Get.to(() => const RestaurantLocation());
      // await PreferenceManagerUtils.setLatitude(position.latitude);
      // await PreferenceManagerUtils.setLongitude(position.longitude);
    } on Exception catch (e) {
      print('LOCATION ERROR :=>$e');
    }
  } else if (await Permission.location.status.isDenied) {
    if (Platform.isAndroid) {
      await Get.to(() => const LocationSettingScreen());
    } else {
      requestLocationPermission();
    }
  } else {
    if (Platform.isAndroid) {
      await Get.to(() => const LocationSettingScreen());
    } else {
      requestLocationPermission();
    }
  }
}
