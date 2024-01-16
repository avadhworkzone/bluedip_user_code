import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/circular_progrss_indicator.dart';
import '../../Widget/common_red_button.dart';
import '../../modal/apiModel/request_modal/get_user_location_req_model.dart';
import '../../modal/apiModel/response_modal/user_location_res_model.dart';
import '../../modal/apis/api_response.dart';
import '../../utils/shared_preference_utils.dart';
import '../../utils/validation_utils.dart';
import '../../viewModel/bottom_view_model.dart';
import '../../viewModel/location_view_model.dart';
import '../bottom_bar/BottomNavigationScreen.dart';

class AddRestoLocation extends StatefulWidget {
  const AddRestoLocation(
      {Key? key,
      this.countryName,
      this.cityName,
      this.state,
      this.address,
      this.pinCode,
      this.countryCode,
      this.area,
      this.lat,
      this.lang})
      : super(key: key);
  final String? countryName;
  final String? cityName;
  final String? state;
  final String? address;
  final String? pinCode;
  final String? countryCode;
  final String? area;
  final String? lat;
  final String? lang;

  @override
  State<AddRestoLocation> createState() => _AddRestoLocationState();
}

class _AddRestoLocationState extends State<AddRestoLocation> {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  // TextEditingController areaController = TextEditingController();
  GetCityViewModel getCityViewModel = Get.find();
  BottomViewModel bottomViewModel = Get.find();
  UserLocationReqModel reqModel = UserLocationReqModel();
  // AddRestoLocationReqModel reqModel = AddRestoLocationReqModel();

  @override
  void initState() {
    getLocationData();
    // TODO: implement initState
    super.initState();
  }

  getLocationData() {
    addressController.text = widget.address ?? "";
    countryController.text = widget.countryName ?? "";
    cityController.text = widget.cityName ?? "";
    stateController.text = widget.state ?? "";
    pinCodeController.text = widget.pinCode ?? "";
    // areaController.text = widget.area == "" ? 'N/A' : widget.area!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                back_button(),
                SizedBox(
                  width: 16.3.w,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Add Location',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: black_504f58,
                        fontFamily: fontMavenProMedium),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Country',
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProProSemiBold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp)),
                        SizedBox(height: 5.w),
                        loginTextformField("",
                            regularExpression:
                                RegularExpression.alphabetSpacePattern,
                            controller: countryController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 15.w),
                        // Text('${widget.countryName}'),
                        Text('City',
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProProSemiBold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp)),
                        SizedBox(height: 5.w),
                        loginTextformField("",
                            regularExpression:
                                RegularExpression.alphabetSpacePattern,
                            controller: cityController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 15.w),
                        // Text('Area',
                        //     style: TextStyle(
                        //         color: black_504f58,
                        //         fontFamily: fontMavenProProSemiBold,
                        //         fontStyle: FontStyle.normal,
                        //         fontSize: 15.sp)),
                        // SizedBox(height: 5.w),
                        // loginTextformField(widget.area ?? 'N/A',
                        //     regularExpression:
                        //         RegularExpression.alphabetSpacePattern,
                        //     controller: areaController,
                        //     keyboardType: TextInputType.text,
                        //     textInputAction: TextInputAction.next),
                        // SizedBox(height: 15.w),
                        // Text('${widget.cityName}'),
                        Text('State',
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProProSemiBold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp)),
                        SizedBox(height: 5.w),
                        loginTextformField("",
                            regularExpression:
                                RegularExpression.alphabetSpacePattern,
                            controller: stateController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 15.w),
                        // Text('${widget.state}'),
                        Text('Address',
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProProSemiBold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp)),
                        SizedBox(height: 5.w),
                        loginTextformField("",
                            regularExpression: RegularExpression.address,
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 15.w),
                        Text('Pincode',
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProProSemiBold,
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp)),
                        SizedBox(height: 5.w),
                        loginTextformField("",
                            regularExpression: RegularExpression.digitsPattern,
                            inputLength: 6,
                            controller: pinCodeController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next),
                        SizedBox(height: 45.w),
                        CommonRedButton(strContinue.toUpperCase(), () async {
                          reqModel.action = "add_user_location";
                          reqModel.country = countryController.text;
                          reqModel.countryCode = widget.countryCode;
                          reqModel.cityName = cityController.text;
                          reqModel.state = stateController.text;
                          reqModel.address = addressController.text;
                          reqModel.pincode = pinCodeController.text;
                          reqModel.lat = widget.lat;
                          reqModel.lang = widget.lang;
                          await getCityViewModel.userLocation(body: reqModel);
                          UserLocationResModel response =
                              getCityViewModel.getUserLocationApiResponse.data;
                          if (getCityViewModel
                                  .getUserLocationApiResponse.status ==
                              Status.COMPLETE) {
                            if (response.status == true) {
                              await PreferenceManagerUtils.setIsLogin('true');
                              await PreferenceManagerUtils.setLatitude(
                                  widget.lat.toString());
                              await PreferenceManagerUtils.setLongitude(
                                  widget.lang.toString());
                              await PreferenceManagerUtils.setCity(
                                  cityController.text.toString());
                              bottomViewModel.currentIndex = 0;

                              Get.offAll(const BottomNavigationScreen());
                            } else {
                              snackBar(title: '${response.message}');
                            }
                          }
                        }, red_dc3642)
                        // Text('${widget.pinCode}'),
                      ],
                    ),
                  ),
                  GetBuilder<GetCityViewModel>(
                    builder: (controller) {
                      if (controller.getUserLocationApiResponse.status ==
                              Status.LOADING ||
                          controller.getUserLocationApiResponse.status ==
                              Status.LOADING) {
                        return const CircularIndicator();
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
