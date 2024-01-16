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

class BottomSheetCancel extends StatefulWidget {
  const BottomSheetCancel({Key? key}) : super(key: key);

  @override
  State<BottomSheetCancel> createState() => _BottomSheetCancelState();
}

class _BottomSheetCancelState extends State<BottomSheetCancel> {
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
                child: Text("Are you sure you want to \nCancel Booking?",
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
                child: Text("You will loses great deal on dine in!",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProRegular,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.sp),
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
                      child: CommonRedButton(strNo.toUpperCase(), () {
                        Navigator.of(context).pop();
                      }, red_dc3642)),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      flex: 1,
                      child: CommonBorderButton("Cancel Booking".toUpperCase(),
                          () {
                        Navigator.of(context).pop();
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
