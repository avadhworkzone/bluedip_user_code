import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/box_shadow_ticket.dart';
import '../../Widget/box_shadow_ticket_second.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetCallRestaurant extends StatefulWidget {
  const BottomSheetCallRestaurant({Key? key}) : super(key: key);

  @override
  State<BottomSheetCallRestaurant> createState() =>
      _BottomSheetCallRestaurantState();
}

class _BottomSheetCallRestaurantState extends State<BottomSheetCallRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Opportunities
              Center(
                child: Text("Didn’t Go ?",
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
              // Are you sure you would like to delete your Bluedip account?
              Center(
                child: Text(
                    "Haven’s Food has marked you as a no show foryour deal redeemed on the 13/2/2023. Is this correct?",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProRegular,
                        fontStyle: FontStyle.normal,
                        height: 1.5,
                        fontSize: 15.sp),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 30.h,
              ),
              /*bottom two buttons here*/
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CommonRedButton("I did attend".toUpperCase(), () {
                        Navigator.of(context).pop();
                      }, red_dc3642)),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      flex: 1,
                      child: CommonBorderButton("I didn’t attend".toUpperCase(),
                          () {
                        Navigator.of(context).pop();
                      }, red_dc3642, Colors.transparent, red_dc3642)),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),

              // This is just for our records and won’t affect your use of the app
              Text(
                  "This is just for our records and won’t affect your use of the app",
                  style: TextStyle(
                      color: grey_5f6d7b,
                      fontFamily: fontMavenProRegular,
                      fontSize: 12.sp),
                  textAlign: TextAlign.left)
            ],
          ),
        ),
      ],
    );
  }
}
