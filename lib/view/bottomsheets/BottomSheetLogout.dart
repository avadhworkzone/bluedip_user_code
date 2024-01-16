import 'package:bluedip_user/Widget/common_red_button.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';
import 'package:bluedip_user/view/auth/WelcomeScreen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/box_shadow_ticket.dart';
import '../../Widget/box_shadow_ticket_second.dart';
import '../../Widget/common_border_button.dart';

class BottomSheetLogout extends StatefulWidget {
  const BottomSheetLogout({Key? key}) : super(key: key);

  @override
  State<BottomSheetLogout> createState() => _BottomSheetLogoutState();
}

class _BottomSheetLogoutState extends State<BottomSheetLogout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.h,
              ),
              // Daily Opportunities
              Center(
                child: Text("Sign out from Bluedip",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontOverpassBold,
                        fontStyle: FontStyle.normal,
                        fontSize: 18.sp,
                        height: 1.5),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 6.h,
              ),
              // Ready(1)
              Text(
                  "Are you sure you would like to sign out of \nyour Bluedip account? ",
                  style: TextStyle(
                      color: black_504f58,
                      fontFamily: fontMavenProMedium,
                      fontStyle: FontStyle.normal,
                      fontSize: 15.sp),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 30.h,
              ),
              /*bottom two buttons here*/
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CommonRedButton(strNo.toUpperCase(), () {
                        Get.back();
                      }, red_dc3642)),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      flex: 1,
                      child: CommonBorderButton("Sign Out".toUpperCase(),
                          () async {
                        await PreferenceManagerUtils.clearPreference();
                        Get.offAll(const WelcomeScreen());
                      }, red_dc3642, Colors.transparent, red_dc3642)),
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
