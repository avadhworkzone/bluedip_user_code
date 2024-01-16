import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/toolbar_with_title_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Styles/my_strings.dart';
import '../../../Widget/Textfield.dart';
import '../../../Widget/back_button.dart';
import '../../../Widget/search_bar.dart';
import '../../../Widget/toolbar_with_title.dart';
import '../../../Widget/common_red_button.dart';
import '../../../Widget/common_verify_red_button.dart';

class SelecLocationListProfile extends StatefulWidget {
  const SelecLocationListProfile({Key? key}) : super(key: key);

  @override
  State<SelecLocationListProfile> createState() =>
      _SelecLocationListProfileState();
}

class _SelecLocationListProfileState extends State<SelecLocationListProfile> {
  List<CityListModel> cityList = [
    CityListModel("Vadodara"),
    CityListModel("Surat"),
    CityListModel("Bharuch"),
    CityListModel("Valsad"),
    CityListModel("Rajkot"),
    CityListModel("Vadodara"),
    CityListModel("Surat"),
    CityListModel("Bharuch"),
    CityListModel("Valsad"),
    CityListModel("Rajkot"),
    CityListModel("Vadodara"),
    CityListModel("Surat"),
    CityListModel("Bharuch"),
    CityListModel("Valsad"),
    CityListModel("Rajkot"),
  ];

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
            ToolbarWithTitleShadow(strSelectLocation),
            const Divider(
              height: 1,
              thickness: 1,
              color: divider_d4dce7,
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
                      SearchBarWidget(
                        hintText: strSearch,
                        onSubmitted: (String) {},
                        onChanged: (String) {},
                      ),

                      SizedBox(
                        height: 20.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            top: 20.h,
                          ),
                          itemCount: cityList.length,
                          itemBuilder: (context, i) => // text
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BottomNavigationScreen(),
                                      ));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(bottom: 20.h),
                                      child: Text(cityList[i].title,
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProRegular,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
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
                              ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
