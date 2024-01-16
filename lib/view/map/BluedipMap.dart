import 'dart:ui';
import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/search_bar.dart';
import '../bottomsheets/BottomSheetLiveOffer.dart';
import '../bottomsheets/BottomSheetNoDeal.dart';
import '../bottomsheets/BottomSheetRestaurantOffer.dart';

class BluedipMap extends StatefulWidget {
  const BluedipMap({Key? key}) : super(key: key);

  @override
  State<BluedipMap> createState() => _BluedipMapState();
}

class _BluedipMapState extends State<BluedipMap> {
  bool statusOffer = false;
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = {};
  Set<Marker> Secondmarkers = {}; //markers for google map
  LatLng LiveLocation = LatLng(21.70169614020623, 72.98617247075632);
  LatLng PreviewLocation = LatLng(21.713084634924083, 72.98942245724739);
  LatLng NoDealLocation = LatLng(21.711496250990685, 72.9767019257142);
  LatLng carLocation = LatLng(21.70007128291212, 72.98769596539591);

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  late BitmapDescriptor icon_live;
  late BitmapDescriptor icon_preview;

  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 2.5),
      "assets/images/icon_live_now.png",
    );

    BitmapDescriptor markerbitmapsecond = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/icon_pre_now.png",
    );

    BitmapDescriptor markerbitmapthird = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/icon_no_live_deals.png",
    );

    // markers
    //     .addLabelMarker(LabelMarker(
    //   markerId: MarkerId(LiveLocation.toString()),
    //   position: LiveLocation,
    //   backgroundColor: Colors.green,
    //   label: '10',
    //   icon: markerbitmap,
    //   infoWindow: const InfoWindow(
    //     title: 'Live Offer',
    //     snippet: 'Start Marker',
    //   ),
    // ))
    //     .then(
    //   (value) {
    //     setState(() {});
    //   },
    // );

    markers.add(Marker(
        //add start location marker
        markerId: MarkerId(LiveLocation.toString()),
        position: LiveLocation, //position of marker
        infoWindow: const InfoWindow(
          title: 'Live Offer',
          snippet: 'Start Marker',
        ),
        icon: markerbitmap,
        onTap: () {
          selectLiveOffer(context);
        } //Icon for Marker
        ));

    // markers.add(Marker(
    //     //add start location marker
    //     markerId: MarkerId(PreviewLocation.toString()),
    //     position: PreviewLocation, //position of marker
    //     infoWindow: const InfoWindow(
    //       title: 'End Point ',
    //       snippet: 'End Marker',
    //     ),
    //     icon: markerbitmapsecond,
    //     onTap: () {
    //       selectRestaurantOffer(context);
    //     } //Icon for Marker
    //     ));

    // markers.add(Marker(
    //     //add start location marker
    //     markerId: MarkerId(NoDealLocation.toString()),
    //     position: NoDealLocation, //position of marker
    //     infoWindow: const InfoWindow(
    //       title: 'No Deal ',
    //       snippet: 'End Marker',
    //     ),
    //     icon: markerbitmapthird,
    //     onTap: () {
    //       selectNoDeal(context);
    //     } //Icon for Marker
    //     ));
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
                child: Row(
                  children: [
                    // Restaurants near you
                    Expanded(
                      flex: 1,
                      child: Text("Map",
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProBold,
                              fontSize: 20.sp,
                              letterSpacing: 0.5),
                          textAlign: TextAlign.left),
                    ),

                    // Live offers

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
                    SizedBox(
                      width: 6.w,
                    ),

                    Text("Live offers ",
                        style: TextStyle(
                            color: grey_5f6d7b,
                            fontFamily: fontMavenProRegular,
                            fontSize: 14.sp),
                        textAlign: TextAlign.right),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  GoogleMap(
                    //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition(
                      //innital position in map
                      target: LiveLocation, //initial position
                      zoom: 14.0, //initial zoom level
                    ),
                    markers: markers, //markers to show on map
                    mapType: MapType.terrain,
                    zoomControlsEnabled: false,
                    mapToolbarEnabled: false,
                    onMapCreated: (controller) {
                      //method called when map is created
                      setState(() {
                        mapController = controller;
                      });
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: SearchBarWidget(
                      hintText: strSearch,
                      onSubmitted: (String) {},
                      onChanged: (String) {},
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    offset: Offset(
                                      0.0,
                                      3.0,
                                    ),
                                    blurRadius: 7.0,
                                    spreadRadius: 0.0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 7.w,
                                    height: 7.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xfff86968)),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text("Live Now",
                                      style: TextStyle(
                                          color: Color(0xfff86968),
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 12.sp),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    width: 7.w,
                                    height: 7.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffeaa300)),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text("Pre-Now",
                                      style: TextStyle(
                                          color: Color(0xffeaa300),
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 12.sp),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Container(
                                    width: 7.w,
                                    height: 7.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff9da0a4)),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text("No Live Deals",
                                      style: TextStyle(
                                          color: Color(0xff9da0a4),
                                          fontFamily: fontMavenProRegular,
                                          fontSize: 12.sp),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Image.asset(
                            icon_live_location,
                            width: 55.w,
                            height: 55.h,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void selectLiveOffer(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            padding: EdgeInsets.only(top: 80.h),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.r),
                  topRight: Radius.circular(13.r),
                )),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        // Rectangle 4197
                        Center(
                          child: Container(
                              width: 71,
                              height: 5,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  color: grey_d9dde3)),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: const [BottomSheetLiveOffer()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      });
}

void selectRestaurantOffer(BuildContext context) {
  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            padding: EdgeInsets.only(top: 80.h),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.r),
                  topRight: Radius.circular(13.r),
                )),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                    width: 71,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: grey_d9dde3)),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: SvgPicture.asset(icon_arrow_left)),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: grey_d9dde3),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 5.h),
                                    child: // View Restaurant
                                        Text("View Restaurant",
                                            style: TextStyle(
                                                color: red_dc3642,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.left),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: const [BottomSheetRestaurantOffer()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      });
}

void selectNoDeal(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(

            // margin: EdgeInsets.only(top: 150.h),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.r),
                  topRight: Radius.circular(13.r),
                )),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13.r),
                      topRight: Radius.circular(13.r),
                    )),
                child: Column(
                  children: [BottomSheetNoDeal()],
                ),
              ),
            ));
      });
}
