import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bluedip_user/Widget/circular_progrss_indicator.dart';
import 'package:bluedip_user/modal/apiModel/request_modal/get_user_location_req_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/get_city_res_model.dart';
import 'package:bluedip_user/modal/apiModel/response_modal/user_location_res_model.dart';
import 'package:bluedip_user/modal/apis/api_response.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/auth/location_screen.dart';
import 'package:bluedip_user/view/dine_in/RedeemDineInBookingDetail.dart';
import 'package:bluedip_user/view/select_location/map_screen.dart';
import 'package:get/get.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_title.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../viewModel/location_view_model.dart';

class SelecLocationList extends StatefulWidget {
  const SelecLocationList({Key? key}) : super(key: key);

  @override
  State<SelecLocationList> createState() => _SelecLocationListState();
}

class _SelecLocationListState extends State<SelecLocationList> {
  GetCityViewModel getCityViewModel = Get.find();
  GetCityListResModel? response;
  // var country;
  // var countryCode;
  // var city;
  // var state;
  // var pinCode;
  // var address;
  // var lati;
  // var lang;

  bool locationLoader = false;
  var addresses;

  static const SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.light,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(overlayStyle);
      // checkGps();
      // _handleLocationPermission();
      getCityListApiCall();
    });
  }

  static String lat = '';
  static String long = '';
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  PermissionStatus? _permissionStatus;

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
        print('jweddd=fkrejnf');
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print('-----lat-----${position.latitude}');
        if (position.latitude == 0 && position.longitude == 0) {
          requestLocationPermission();
        } else {
          Get.to(MapScreen(
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

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat = position.latitude.toString();
    long = position.longitude.toString();
    Get.to(MapScreen(
      lat: lat,
      long: long,
    ));

    log("====lat=========${lat}");
    log("====long=========${long}");
  }

  ///get lat long based on city name
  Future<void> getCoordinates({
    required String cityName,
  }) async {
    // if (status.isGranted) {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR$error");
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
          reqModel.action = "add_user_location";
          reqModel.country = first.country;
          reqModel.countryCode = first.isoCountryCode;
          reqModel.cityName = first.locality;
          reqModel.state = first.administrativeArea;
          reqModel.address =
              '${first.street} ${cityName}, ${first.administrativeArea}, ${first.country}, ${first.postalCode}';
          reqModel.pincode = first.postalCode;
          reqModel.lat = latitude.toString();
          reqModel.lang = longitude.toString();
          await getCityViewModel.userLocation(body: reqModel);
          UserLocationResModel locationResponse =
              getCityViewModel.getUserLocationApiResponse.data;
          if (getCityViewModel.getUserLocationApiResponse.status ==
              Status.COMPLETE) {
            if (locationResponse.status == true) {
              await PreferenceManagerUtils.setIsLogin('true');
              await PreferenceManagerUtils.setLatitude(latitude.toString());
              await PreferenceManagerUtils.setLongitude(longitude.toString());
              await PreferenceManagerUtils.setCity(first.locality.toString());
              bottomViewModel.currentIndex = 0;

              Get.offAll(const BottomNavigationScreen());
            } else {
              snackBar(title: '${locationResponse.message}');
            }
          }
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

  UserLocationReqModel reqModel = UserLocationReqModel();
  getCityListApiCall() async {
    await getCityViewModel.getCityList();
  }

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       _handleLocationPermission();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     _handleLocationPermission();
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);

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
                                                  return CircularIndicator();
                                                }
                                                return GestureDetector(
                                                  onTap: () async {
                                                    await getCoordinates(
                                                            cityName: response!
                                                                .data![i]
                                                                .cityName!)
                                                        .then((value) async {});

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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        color: Colors.white,
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 20.h),
                                                        child: Text(
                                                            response!.data![i]
                                                                .cityName!,
                                                            style: TextStyle(
                                                                color:
                                                                    black_504f58,
                                                                fontFamily:
                                                                    fontMavenProRegular,
                                                                fontSize:
                                                                    15.sp),
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
      ),
    );
  }
}
