import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc1;
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_font.dart';
import '../../../Styles/my_icons.dart';
import '../../../modal/apis/api_response.dart';
import '../../../viewModel/bottom_view_model.dart';
import '../../Widget/box_shadow.dart';
import '../../modal/apiModel/response_modal/get_user_location_res_model.dart';
import '../../viewModel/location_view_model.dart';
import '../bottom_bar/BottomNavigationScreen.dart';
import 'EditRestaurantLocation.dart';

class RestaurantLocation extends StatefulWidget {
  const RestaurantLocation({Key? key}) : super(key: key);

  @override
  State<RestaurantLocation> createState() => _RestaurantLocationState();
}

class _RestaurantLocationState extends State<RestaurantLocation> {
  // bool isLoading = false;
  // GoogleMapController? mapController; //contrller for Google map
  // Set<Marker> markers = Set(); //markers for google map
  // LatLng showLocation = LatLng(27.7089427, 85.3086209);
  //
  // @override
  // void initState() {
  //   markers.add(Marker( //add marker on google map
  //     markerId: MarkerId(showLocation.toString()),
  //     position: showLocation, //position of marker
  //     infoWindow: InfoWindow( //popup info
  //       title: 'My Custom Title ',
  //       snippet: 'My Custom Subtitle',
  //     ),
  //     icon: BitmapDescriptor.defaultMarker, //Icon for Marker
  //   ));
  //
  //   //you can add more markers here
  //   super.initState();
  // }

  GetCityViewModel fetchUserLocation = Get.find();
  StreamSubscription? streamSubscription;
  GoogleMapController? _controller;
  GetUserLocationResModel? userLocationRes;
  loc1.Location currentLocation = loc1.Location();
  BottomViewModel bottomViewModel = Get.find();
  Marker? _markers;
  var country;
  var cityName;
  var state;
  var currentAddress;
  double latitude = 0;
  double longitude = 0;
  bool serviceStatus = false;
  late LocationPermission permission;
  bool hasPermission = false;
  LatLng? currentLatLng;
  late BitmapDescriptor icon;

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4.2, size: Size(30, 30)),
        "assets/images/icon_location_pin_map.png");
    setState(() {
      this.icon = icon;
    });
  }

  void getLocation() async {
    fetchUserLocation.isLoading = true;

    // var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((loc1.LocationData loc) async {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 16.0,
      )));
      currentLatLng = LatLng(double.parse(loc.latitude.toString()),
          double.parse(loc.longitude.toString()));
      print(loc.latitude);
      print(loc.longitude);
      latitude = loc.latitude!;
      longitude = loc.longitude!;
      var addresses = await placemarkFromCoordinates(
          loc.latitude ?? 0.0, loc.longitude ?? 0.0);
      // log('addresses=-----$addresses');
      var first = addresses.first;
      country = first.country;
      cityName = first.locality;
      state = first.administrativeArea;
      currentAddress =
          "${first.street}, ${first.subLocality}, ${first.locality}, ${first.country}, ${first.postalCode}";
      _markers = Marker(
          markerId: const MarkerId('Home'),
          icon: icon,
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0));

      setState(() {});
      fetchUserLocation.isLoading = false;
    });
  }

  @override
  void initState() {
    // requestLocationPermission();
    // checkGps();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        getResLoc();
        getIcons();
      }
    });
  }

  getResLoc() async {
    fetchUserLocation.isLoading = true;
    await fetchUserLocation.fetchUserLocation();

    if (fetchUserLocation.userLocationApiResponse.status == Status.COMPLETE) {
      userLocationRes = fetchUserLocation.userLocationApiResponse.data;
      if (userLocationRes!.data != null) {
        try {
          streamSubscription = currentLocation.onLocationChanged
              .listen((loc1.LocationData loc) async {
            _controller
                ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(
                  double.parse(userLocationRes!.data!.lat.toString()) ?? 0.0,
                  double.parse(userLocationRes!.data!.lang.toString()) ?? 0.0),
              zoom: 16.0,
            )));
            currentLatLng = LatLng(
                double.parse(userLocationRes!.data!.lat.toString()),
                double.parse(userLocationRes!.data!.lang.toString()));
            country = userLocationRes!.data!.country ?? "NA";
            cityName = userLocationRes!.data!.cityName ?? "NA";
            state = userLocationRes!.data!.state ?? 'NA';
            currentAddress =
                "${userLocationRes!.data!.address}, ${userLocationRes!.data!.pincode}";

            _markers = Marker(
                markerId: const MarkerId('Home'),
                icon: icon,
                position: LatLng(
                    double.parse(userLocationRes!.data!.lat.toString()) ?? 0.0,
                    double.parse(userLocationRes!.data!.lang.toString()) ??
                        0.0));

            setState(() {});

            fetchUserLocation.isLoading = false;
          });
        } catch (e) {
          print('Error subscribing to location updates: $e');
        }
      } else {
        print('else ma gyu');
        getLocation();
      }
    } else if (fetchUserLocation.userLocationApiResponse.status ==
        Status.ERROR) {
      print('there must be error');
      getLocation();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
    streamSubscription?.cancel();
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
      backgroundColor: bg_f3f5f9,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                    onTap: () {
                      bottomViewModel.currentIndex = 3;
                      Get.offAll(() => const BottomNavigationScreen());
                    },
                    child: Container(
                        width: 40.w,
                        height: 40.w,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: SvgPicture.asset(icon_arrow_left),
                        ))),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Restaurant Location",
                    style: TextStyle(
                        fontFamily: fontMavenProMedium,
                        color: black_504f58,
                        fontSize: 20.sp),
                  ),
                ),
              ],
            ),
          ),
          // ToolbarWithTitle("Restaurant Location"),
          fetchUserLocation.isLoading == true || currentLatLng == null
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(14.r),
                            decoration: boxDecoration,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 268.h,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14.r),
                                    child: GoogleMap(
                                      zoomControlsEnabled: true,
                                      mapType: MapType.terrain,
                                      zoomGesturesEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                          target: currentLatLng!, zoom: 17),
                                      //     const CameraPosition(
                                      //   target: LatLng(21.710274309571417,
                                      //       72.97339821197653),
                                      //   zoom: 17.0,
                                      // ),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controller = controller;
                                      },
                                      markers: _markers != null
                                          ? Set<Marker>.of([_markers!])
                                          : {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Store Location",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProBold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.left),
                                    GestureDetector(
                                      onTap: () {
                                        print('edit resto location');
                                        if (userLocationRes!.data != null) {
                                          Get.to(EditRestaurantLocation(
                                              lat: double.parse(userLocationRes!
                                                  .data!.lat
                                                  .toString()),
                                              lang: double.parse(
                                                  userLocationRes!.data!.lang
                                                      .toString()),
                                              address: userLocationRes!
                                                  .data!.address));
                                        } else {
                                          Get.to(EditRestaurantLocation(
                                            lat: latitude,
                                            lang: longitude,
                                            address: currentAddress,
                                          ));
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          border: Border.all(
                                              width: 1, color: red_dc3642),
                                        ),
                                        child: // EDIT
                                            Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.w, vertical: 6),
                                          child: Text("EDIT",
                                              style: TextStyle(
                                                  color: red_dc3642,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Plan
                                    Expanded(
                                      flex: 1,
                                      child: Text("Country",
                                          style: TextStyle(
                                              color: grey_969da8,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                    ),

                                    // Monthly
                                    Expanded(
                                      flex: 2,
                                      child: Text("${country}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     // Plan
                                //     Expanded(
                                //       flex: 1,
                                //       child: Text("Country Code",
                                //           style: TextStyle(
                                //               color: grey_969da8,
                                //               fontFamily: fontMavenProMedium,
                                //               fontStyle: FontStyle.normal,
                                //               fontSize: 14.sp),
                                //           textAlign: TextAlign.left),
                                //     ),
                                //
                                //     // Monthly
                                //     Expanded(
                                //       flex: 2,
                                //       child: Text("+91",
                                //           style: TextStyle(
                                //               color: black_354356,
                                //               fontFamily: fontMavenProMedium,
                                //               fontStyle: FontStyle.normal,
                                //               fontSize: 15.sp),
                                //           textAlign: TextAlign.left),
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Plan
                                    Expanded(
                                      flex: 1,
                                      child: Text("City",
                                          style: TextStyle(
                                              color: grey_969da8,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                    ),

                                    // Monthly
                                    Expanded(
                                      flex: 2,
                                      child: Text("${cityName}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Plan
                                    Expanded(
                                      flex: 1,
                                      child: Text("State/Region",
                                          style: TextStyle(
                                              color: grey_969da8,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                    ),

                                    // Monthly
                                    Expanded(
                                      flex: 2,
                                      child: Text("${state}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Plan
                                    Expanded(
                                      flex: 1,
                                      child: Text("Address",
                                          style: TextStyle(
                                              color: grey_969da8,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                    ),
                                    // Monthly
                                    Expanded(
                                      flex: 2,
                                      child: Text("${currentAddress}",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ],
      ),
    ));
  }
}
