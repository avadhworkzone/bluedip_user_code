import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_for_flutter/google_places_for_flutter.dart';
import 'package:location/location.dart' as loc1;
import 'package:location/location.dart';
import '../../../Styles/my_colors.dart';
import '../../../Styles/my_strings.dart';
import '../../../Widget/Textfield.dart';
import '../../../Widget/circular_progrss_indicator.dart';
import '../../../Widget/toolbar_with_title.dart';
import '../../../modal/apis/api_response.dart';
import '../../Styles/my_font.dart';
import '../../Widget/common_red_button.dart';
import '../../modal/apiModel/request_modal/get_user_location_req_model.dart';
import '../../modal/apiModel/response_modal/user_location_res_model.dart';
import '../../utils/enum_utils.dart';
import '../../utils/validation_utils.dart';
import '../../viewModel/location_view_model.dart';
import 'RestaurantLocation.dart';

class EditRestaurantLocation extends StatefulWidget {
  EditRestaurantLocation({Key? key, this.lat, this.lang, this.address})
      : super(key: key);
  double? lat;
  double? lang;
  String? address;

  @override
  State<EditRestaurantLocation> createState() => _EditRestaurantLocationState();
}

class _EditRestaurantLocationState extends State<EditRestaurantLocation> {
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

  GoogleMapController? _controller;
  loc1.Location currentLocation = loc1.Location();
  Marker? _markers;
  UserLocationReqModel reqModel = UserLocationReqModel();
  late BitmapDescriptor icon;
  double latitude = 0;
  double longitude = 0;
  bool isLoading = false;
  bool firstTime = false;
  var pinCode;
  var country;
  var cCode;
  var cityName;
  var state;
  var currentAddress;
  var area;
  LatLng? currentLatLng;
  StreamSubscription<LocationData>? locationSubscription;

  GetCityViewModel getCityViewModel = Get.find();
  UserLocationResModel? response;
  // GetRestaurantLocation? getRestaurantLocation;

  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 4.2, size: Size(30, 30)),
        "assets/images/icon_location_pin_map.png");
    if (mounted)
      setState(() {
        this.icon = icon;
      });
  }

  void getLocation({double? latit, double? longit}) async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
      firstTime = true;
      _addressController.text = '';
      _pincodeController.text = '';
    });

    await currentLocation.getLocation();
    latitude = widget.lat!;
    longitude = widget.lang!;
    locationSubscription =
        currentLocation.onLocationChanged.listen((loc1.LocationData loc) async {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latit ?? widget.lat!, longit ?? widget.lang!),
        zoom: 16.0,
      )));
      currentLatLng = LatLng(latit ?? latitude, longit ?? longitude);
      latitude = latit ?? latitude;
      longitude = longit ?? longitude;
      var addresses = await placemarkFromCoordinates(
          latit ?? latitude, longit ?? longitude);
      var first = addresses.first;
      pinCode = first.postalCode;
      currentAddress =
          "${first.street}, ${first.subLocality}, ${first.locality}, ${first.country}";
      country = first.country;
      cCode = first.isoCountryCode;
      cityName = first.locality;
      state = first.administrativeArea;
      area = first.subLocality;

      _markers = Marker(
          markerId: const MarkerId('Home'),
          icon: icon,
          position: LatLng(latit ?? latitude, longit ?? longitude));
      _pincodeController.text = pinCode;
      _addressController.text = latit == null ? widget.address : currentAddress;

      if (_addressController.text != "" && _pincodeController.text != "") {
        locationSubscription!.cancel();
      }
      isLoading = false;
      if (mounted) {
        setState(() {});
      }
    });
    // print('status===${status}');
  }

  Future<void> _updateMarker(
      double latitudeValue, double longitudeValue) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      firstTime = true;

      _addressController.text = '';
      _pincodeController.text = '';
      currentLatLng = LatLng(double.parse(latitudeValue.toString()),
          double.parse(longitudeValue.toString()));
      _markers = Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(latitudeValue, longitudeValue),
        icon: icon,
        infoWindow: const InfoWindow(title: 'Current Location'),
      );
      var addresses =
          await placemarkFromCoordinates(latitudeValue, longitudeValue);

      var first = addresses.first;
      pinCode = first.postalCode;
      currentAddress =
          "${first.street}, ${first.subLocality}, ${first.locality}, ${first.country}";
      country = first.country;
      cCode = first.isoCountryCode;
      cityName = first.locality;
      state = first.administrativeArea;
      area = first.subLocality;
      latitude = latitudeValue;
      longitude = longitudeValue;
      _pincodeController.text = pinCode;
      _addressController.text = currentAddress;
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _handleMapTap(LatLng tappedPoint) async {
    _updateMarker(tappedPoint.latitude, tappedPoint.longitude);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLocation();
      getIcons();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
    locationSubscription?.cancel();
  }
  // late BitmapDescriptor pinLocationIcon;
  //
  // void setCustomMapPin() async {
  //   pinLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(devicePixelRatio: 2.5),
  //       'assets/images/icon_location_pin_account.svg');
  // }

  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();

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
      // resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToolbarWithTitle("Edit Restaurant Location"),
          isLoading || currentLatLng == null
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            GoogleMap(
                              zoomControlsEnabled: true,
                              mapType: MapType.terrain,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: currentLatLng!,
                                zoom: 17.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller = controller;
                              },
                              onTap: (tappedPoint) {
                                _handleMapTap(tappedPoint);
                              },
                              markers: _markers != null
                                  ? Set<Marker>.of([_markers!])
                                  : {},
                            ),
                            SingleChildScrollView(
                              child: SearchGooglePlacesWidget(
                                placeType: PlaceType.address,
                                placeholder: 'Enter the address',
                                apiKey:
                                    'AIzaSyApn3-bC5KtY1mF-AxgiC-43V4qPak5CoI',
                                onSearch: (Place place) {},
                                onSelected: (Place place) async {
                                  var geolocation = await place.geolocation;

                                  var destinationCoordinates = LatLng(
                                      geolocation?.coordinates.latitude,
                                      geolocation?.coordinates.longitude);

                                  List<Placemark> place1 = [];
                                  List<Placemark> newPlace =
                                      await placemarkFromCoordinates(
                                          geolocation?.coordinates.latitude,
                                          geolocation?.coordinates.longitude);
                                  print(newPlace);
                                  if (!mounted) return;
                                  setState(() {
                                    place1 = newPlace;
                                    print('===${place1.first}');
                                  });
                                  getLocation(
                                      latit: geolocation?.coordinates.latitude,
                                      longit:
                                          geolocation?.coordinates.longitude);

                                  // setDestination(place);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: bg_f3f5f9,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12.r),
                                    topRight: Radius.circular(12.r))),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pin Code",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: fontMavenProMedium),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 6.h,
                                ),
                                loginTextformField("",
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    controller: _pincodeController,
                                    regularExpression:
                                        RegularExpression.digitsPattern,
                                    obscureText: true,
                                    onTap: () {},
                                    onChanged: (value) {},
                                    validationType: ValidationType.PNumber,
                                    inputLength: 6),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text("House Number, Building and Locality",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 14.sp,
                                        fontFamily: fontMavenProRegular),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 6.h,
                                ),
                                loginTextformField("",
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    controller: _addressController,
                                    obscureText: true,
                                    onChanged: (value) {},
                                    regularExpression:
                                        RegularExpression.address),
                                SizedBox(
                                  height: 40.h,
                                ),
                                GetBuilder<GetCityViewModel>(
                                  builder: (controller) {
                                    if (controller.getUserLocationApiResponse
                                            .status ==
                                        Status.LOADING) {
                                      return const CircularIndicator();
                                    }

                                    return CommonRedButton(strSave, () async {
                                      reqModel.action = 'add_user_location';
                                      reqModel.country = country;
                                      reqModel.countryCode = cCode;
                                      reqModel.cityName = cityName;
                                      reqModel.state = state;
                                      reqModel.lat = latitude.toString();
                                      reqModel.lang = longitude.toString();
                                      reqModel.pincode =
                                          _pincodeController.text;
                                      reqModel.address =
                                          _addressController.text;
                                      // reqModel.area = area;
                                      await getCityViewModel.userLocation(
                                          body: reqModel);
                                      if (controller.getUserLocationApiResponse
                                              .status ==
                                          Status.ERROR) {
                                        snackBar(title: "Server error");
                                        // Get.snackbar('', "Server error",
                                        //     snackPosition: SnackPosition.BOTTOM,
                                        //     colorText: Colors.white,
                                        //     backgroundColor: blue_3d56f0);
                                      }
                                      if (controller.getUserLocationApiResponse
                                              .status ==
                                          Status.COMPLETE) {
                                        response = controller
                                            .getUserLocationApiResponse.data;
                                        if (response!.status == true) {
                                          Get.offAll(
                                              const RestaurantLocation());
                                          // Get.offAll(LatestBottomNavigationScreen());
                                        } else {
                                          snackBar(
                                              title: '${response!.message}');
                                          // Get.snackbar(
                                          //     '', '${response!.message}',
                                          //     snackPosition:
                                          //         SnackPosition.BOTTOM,
                                          //     colorText: Colors.white,
                                          //     backgroundColor: blue_3d56f0);
                                        }
                                      }

                                      // await resModel.postRestaurantLocationViewModel();
                                    }, red_dc3642);
                                  },
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
                  ),
                ),
        ],
      ),
    ));
  }
  // setDestination(Place place) async {
  //   destination.value = place.description!;
  //   mapStatus.value = Constants.route;
  //   var geolocation = await place.geolocation;
  //   destinationCoordinates = LatLng(
  //       geolocation?.coordinates.latitude, geolocation?.coordinates.longitude);
  //   await drawRoute(destinationCoordinates);
  //   await addDestinationMarker(destinationCoordinates);
  //   getTotalDistanceAndTime(destinationCoordinates);
  // }
}
