import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
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

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
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
        backgroundColor: bg_fafbfb,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleShadow("Terms & Condition"),
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
                  child: Container(
                    decoration: cardboxDecoration,
                    padding: EdgeInsets.all(14.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Terms of Service",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontOverpassBold,
                                fontSize: 20.sp),
                            textAlign: TextAlign.left),
                        Text("Last updated 22/02/2023",
                            style: TextStyle(
                                color: grey_77879e,
                                fontFamily: fontMavenProRegular,
                                fontSize: 12.sp),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("What is Lorem Ipsum?",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProBold,
                                fontSize: 20.sp),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                            style: TextStyle(
                                color: grey_5f6d7b,
                                fontFamily: fontMavenProRegular,
                                fontSize: 15.sp,
                                height: 1.5),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text("Where does it come from?",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProBold,
                                fontSize: 20.sp),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500sLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dumm",
                            style: TextStyle(
                                color: grey_5f6d7b,
                                fontFamily: fontMavenProRegular,
                                fontSize: 15.sp,
                                height: 1.5),
                            textAlign: TextAlign.left),
                      ],
                    ),
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
