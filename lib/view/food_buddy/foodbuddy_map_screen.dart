import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/common_red_button.dart';
import '../../utils/Utility.dart';

class FoodBuddyMapScreen extends StatefulWidget {
  const FoodBuddyMapScreen({Key? key, this.lat, this.long}) : super(key: key);
  final String? lat;
  final String? long;

  @override
  State<FoodBuddyMapScreen> createState() => _FoodBuddyMapScreenState();
}

class _FoodBuddyMapScreenState extends State<FoodBuddyMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? currentLatLng;

  initData() async {
    await Geolocator.getCurrentPosition().then((currLocation) async {
      setState(() {
        currentLatLng =
            LatLng(double.parse(widget.lat!), double.parse(widget.long!));
      });
      var addresses = await placemarkFromCoordinates(
          double.parse(widget.lat!), double.parse(widget.long!));
      print('addresses-->>${addresses}');

      ///currLocation.longitude
      var first = addresses.first;
      Utility.country = first.country;
      Utility.country_code = first.isoCountryCode;
      Utility.city_name = first.locality;
      Utility.state = first.administrativeArea;
      Utility.pincode = first.postalCode;
      Utility.address =
          '${first.street} ${first.locality}, ${first.administrativeArea}, ${first.country}, ${first.postalCode}';
      Utility.lat = widget.lat ?? "";
      Utility.lang = widget.long ?? "";
      print('Utility.address-->>${Utility.address}');
      setState(() {});
    });
  }

  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLatLng == null
          ? const SizedBox()
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      // alignment: Alignment.center,
                      children: [
                        GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: currentLatLng!, zoom: 17),
                          // markers: _markers.toSet(),
                          zoomControlsEnabled: false,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          padding: const EdgeInsets.only(
                            top: 40.0,
                          ),
                          onCameraMove: (position) {
                            // _debouncer.run(() {
                            // setState(() {
                            // _isLoading = true;
                            // print('_markers.first===${_markers}');
                            // _markers.first = _markers.first
                            //     .copyWith(positionParam: position.target);

                            // lat = position.target.latitude;
                            // lng = position.target.longitude;
                            // printData("My Latitude : ",
                            //     position.target.latitude.toString());
                            // printData("My Longitude : ",
                            //     position.target.longitude.toString());

                            // getAddress(position.target.latitude,
                            //     position.target.longitude);
                            // });
                            //});
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: CommonRedButton(strSave.toUpperCase(), () async {
                      Get.back();

                      print('save utility address==>${Utility.address}');
                      // Get.offAll(() => const CreatePost());
                    }, red_dc3642),
                  ),
                ],
              ),
            ),
    );
  }
}
