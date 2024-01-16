import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Model/ReviewModel.dart';
import '../../../Styles/my_strings.dart';
import '../../../Widget/Textfield.dart';
import '../../../Widget/back_button.dart';
import '../../../Widget/card_box_shadow.dart';
import '../../../Widget/search_bar.dart';
import '../../../Widget/toolbar_with_title.dart';
import '../../../Widget/common_red_button.dart';
import '../../../Widget/common_verify_red_button.dart';

class RestoDetailAmenitiesTab extends StatefulWidget {
  const RestoDetailAmenitiesTab({Key? key}) : super(key: key);

  @override
  State<RestoDetailAmenitiesTab> createState() =>
      _RestoDetailAmenitiesTabState();
}

class _RestoDetailAmenitiesTabState extends State<RestoDetailAmenitiesTab> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers = {};

  late Uint8List markerIcon;
  late BitmapDescriptor icon;
  late BitmapDescriptor customIcon;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      // const ImageConfiguration(devicePixelRatio: 8.2,size: Size(30, 30)),
      "assets/images/icon_location_pin_map.png",
    );
    setState(() {
      this.icon = icon;
    });
  }

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      _controller
          ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
        zoom: 16.0,
      )));
      print(loc.latitude);
      print(loc.longitude);

      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            icon: icon,
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // getLocation();
      // getIcons();
    });
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 14.w, right: 14.w, top: 20.h, bottom: 20.h),
                  decoration: cardboxDecoration,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CUISINE
                      Text("CUISINE",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 8.h,
                      ),

                      Text("Biryani, South Indian, Japanese, Fast Food",
                          style: TextStyle(
                              color: grey_5f6d7b,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("ESTABLISHMENT TYPE",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            icon_takeaway_png,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          // Takeaway
                          Text("Takeaway",
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          SizedBox(
                            width: 22.w,
                          ),

                          Image.asset(
                            icon_dinein_png,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          // Takeaway
                          Text("Dine-in",
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("AVERAGE COST",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            icon_cash_money_payments_png,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Image.asset(
                            icon_rupee_slim,
                            width: 9.w,
                            height: 9.h,
                            color: grey_5f6d7b,
                          ),

                          // Takeaway
                          Text("500 for 2",
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text("FEATURES & FACILITIES",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Image.asset(
                                  icon_air_hall,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text("Ac Hall",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Image.asset(
                                  icon_wifi,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text("Wifi",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Image.asset(
                                  icon_car_parking,
                                  width: 16.w,
                                  height: 16.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text("Car Parking",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            icon_live_tv,
                            width: 16.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          // Takeaway
                          Text("Live Screening",
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: cardboxDecoration,
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
                            initialCameraPosition: const CameraPosition(
                              target:
                                  LatLng(21.710274309571417, 72.97339821197653),
                              zoom: 18.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                            },
                            markers: _markers,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      // I-212 DDA Flats, Naraina Vihar
                      Text("I-212 DDA Flats, Naraina Vihar",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 15.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 14.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Store Location
                          Text("099128313131",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.sp),
                              textAlign: TextAlign.left),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(width: 1, color: blue_007add),
                            ),
                            child: // EDIT
                                Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18.w, vertical: 6),
                              child: Text("CALL",
                                  style: TextStyle(
                                      color: blue_007add,
                                      fontFamily: fontMavenProMedium,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.sp),
                                  textAlign: TextAlign.left),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
