import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button.dart';
import '../Widget/circular_progrss_indicator.dart';
import '../Widget/search_bar.dart';
import '../Widget/toolbar_with_title.dart';
import '../Widget/common_red_button.dart';
import '../Widget/common_verify_red_button.dart';
import '../modal/apiModel/response_modal/get_city_res_model.dart';
import '../modal/apis/api_response.dart';
import '../utils/Utility.dart';

import '../viewModel/location_view_model.dart';
import 'auth/location_screen.dart';
import 'food_buddy/foodbuddy_map_screen.dart';
import 'select_location/map_screen.dart';

class SelecLocationCreatePost extends StatefulWidget {
  const SelecLocationCreatePost({Key? key}) : super(key: key);

  @override
  State<SelecLocationCreatePost> createState() =>
      _SelecLocationCreatePostState();
}

class _SelecLocationCreatePostState extends State<SelecLocationCreatePost> {
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  GetCityListResModel? response;
  GetCityViewModel getCityViewModel = Get.find();
  bool locationLoader = false;
  var addresses;

  checkGps() async {
    var location = await Permission.location.request();
    log("LOCATION PERMISSION $location");
    if (location.isPermanentlyDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      openAppSettings().then((value) async {
        log("STATUS vale ${value}");

        if (value == false) {
          var status = await Permission.location.request();
        }
      });
    } else if (location.isGranted) {
      serviceStatus = await Geolocator.isLocationServiceEnabled();
      if (serviceStatus) {
        permission = await Geolocator.checkPermission();

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // showSnackBar(
            //     message: "Location permissions are denied",
            //     snackColor: ColorUtils.red);
          } else if (permission == LocationPermission.deniedForever) {
            // showSnackBar(
            //     message: "Location permissions are permanently denied",
            //     snackColor: ColorUtils.red);
          } else {
            hasPermission = true;
          }
        } else {
          hasPermission = true;
        }
        if (hasPermission) {
          location1();
        }
      } else {
        snackBar(title: "GPS Service is not enabled, turn on GPS location");
      }
    }
  }

  Future<void> location1() async {
    var permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        if (position.latitude == 0 && position.longitude == 0) {
          requestLocationPermission();
        } else {
          Get.to(FoodBuddyMapScreen(
            lat: position.latitude.toString(),
            long: position.longitude.toString(),
          ));
        }

        // await PreferenceManagerUtils.setLatitude(position.latitude);
        // await PreferenceManagerUtils.setLongitude(position.longitude);
      }
    } on Exception catch (e) {
      print('LOCATION ERROR :==>$e');
    }
  }

  Future<void> requestLocationPermission() async {
    final permissionStatus = await Permission.location.status;
    print('permissionStatus:=>$permissionStatus');
    if (await Permission.location.request().isGranted ||
        await Permission.locationWhenInUse.request().isGranted) {
      try {
        final position = await Geolocator.getCurrentPosition();
        Get.to(MapScreen(
          lat: position.latitude.toString(),
          long: position.longitude.toString(),
        ));
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

  Future<void> getCoordinates({
    required String cityName,
  }) async {
    // if (status.isGranted) {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    setState(() {
      locationLoader = true;
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      try {
        List<Location> locations = await locationFromAddress(cityName);

        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;
        addresses = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        print('address====${addresses}');
        // .then((value) async {
        if (addresses == null) {
          snackBar(title: 'try again');
        } else {
          var first = addresses.first;
          setState(() {
            locationLoader = false;
          });

          Utility.country = first.country;
          Utility.country_code = first.isoCountryCode;
          Utility.city_name = first.locality;
          Utility.state = first.administrativeArea;
          Utility.address =
              '${first.street} ${cityName}, ${first.administrativeArea}, ${first.country}, ${first.postalCode}';
          Utility.pincode = first.postalCode;
          Utility.lat = latitude.toString();
          Utility.lang = longitude.toString();
        }

        // });

        ///currLocation.longitude

        // country = first.country;
        // countryCode = first.isoCountryCode;
        // city = first.locality;
        // state = first.administrativeArea;
        // pinCode = first.postalCode;
        // address =
        //     '${first.street} ${cityName}, ${state}, ${country}, ${pinCode}';
        // lati = latitude;
        // lang = longitude;

        print('-------Latitude: $latitude, -------Longitude: $longitude');
      } catch (e) {
        setState(() {
          locationLoader = false;
        });
        print('Error: $e');
        snackBar(title: '${e} , Please try after some time');
      }
    });

    // } else if (status.isDenied) {
    //   print('Location permission is denied');
    // } else if (status.isPermanentlyDenied) {
    //   print('Location permission is permanently denied');
    // }
  }

  getCityListApiCall() async {
    await getCityViewModel.getCityList();
  }

  @override
  void initState() {
    getCityListApiCall();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: white_ffffff,
        body: GetBuilder<GetCityViewModel>(
          builder: (controller) {
            if (controller.getCityApiResponse.status == Status.LOADING) {
              return CircularIndicator();
            }
            if (controller.getCityApiResponse.status == Status.ERROR) {
              return Text('No Data');
            }
            if (controller.getCityApiResponse.status == Status.COMPLETE) {
              response = controller.getCityApiResponse.data;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolbarWithTitle(strSelectLocation),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: divider_d4dce7,
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
                          SearchBarWidget(
                            hintText: strSearch,
                            onSubmitted: (String) {},
                            onChanged: (String) {},
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(8.r),
                            color: red_dc3642,
                            //color of dotted/dash line
                            strokeWidth: 1,
                            //thickness of dash/dots
                            dashPattern: [4, 3],
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.w, horizontal: 12.h),
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: SvgPicture.asset(
                                            icon_warning_rectangle),
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      // This post will only be valid for 24 hours.
                                      Text(
                                          "This location will refer to the city where \nyou are looking to discover delicious food \nplaces with your Food Buddy.",
                                          style: TextStyle(
                                              color: red_dc3642,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp,
                                              height: 1.5),
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                )),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          InkWell(
                            onTap: () {
                              checkGps();
                              // getLocation();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // text
                                  Text("Use current location",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProMedium,
                                          fontSize: 15.sp,
                                          letterSpacing: 0.5),
                                      textAlign: TextAlign.left),
                                  SvgPicture.asset(icon_near_me_navigation),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: divider_d4dce7,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // text
                          Text("Select City".toUpperCase(),
                              style: TextStyle(
                                  color: grey_77879e,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          response?.data == null || response!.data!.isEmpty
                              ? const Text('No Data')
                              : locationLoader == true
                                  ? const CircularIndicator()
                                  : ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      primary: false,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(
                                        top: 20.h,
                                      ),
                                      itemCount: response!.data!.length,
                                      itemBuilder: (context, i) => // text
                                          GetBuilder<GetCityViewModel>(
                                            builder: (controller) {
                                              if (controller
                                                          .getUserLocationApiResponse
                                                          .status ==
                                                      Status.LOADING ||
                                                  controller
                                                          .getUserLocationApiResponse
                                                          .status ==
                                                      Status.LOADING) {
                                                return const CircularIndicator();
                                              }
                                              return GestureDetector(
                                                onTap: () async {
                                                  await getCoordinates(
                                                          cityName: response!
                                                              .data![i]
                                                              .cityName!)
                                                      .then((value) async {
                                                    Get.back();
                                                  });

                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const BottomNavigationScreen(),
                                                  //     ));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      width: double.infinity,
                                                      padding: EdgeInsets.only(
                                                          bottom: 20.h),
                                                      child: Text(
                                                          response!.data![i]
                                                              .cityName!,
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 15.sp),
                                                          textAlign:
                                                              TextAlign.left),
                                                    ),
                                                    const Divider(
                                                      height: 1,
                                                      thickness: 1,
                                                      color: divider_d4dce7,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
