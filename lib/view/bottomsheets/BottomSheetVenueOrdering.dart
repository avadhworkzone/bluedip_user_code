import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetVenueOrdering extends StatefulWidget {
  const BottomSheetVenueOrdering({Key? key}) : super(key: key);

  @override
  State<BottomSheetVenueOrdering> createState() =>
      _BottomSheetVenueOrderingState();
}

class _BottomSheetVenueOrderingState extends State<BottomSheetVenueOrdering> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              img_venue_ordering,
              width: double.infinity,
              height: 190.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          // This venue is set up for Bluedip In App Ordering.
          Text("This venue is set up for Bluedip In \nApp Ordering.",
              style: TextStyle(
                  color: black_504f58,
                  fontFamily: fontOverpassBold,
                  height: 1.5,
                  fontSize: 18.sp),
              textAlign: TextAlign.center),

          // You can order and pay through a digital menu with the deal already applied to your order.
          Text(
              "You can order and pay through a digital \nmenu with the deal already applied \nto your order.",
              style: TextStyle(
                  color: black_504f58,
                  fontFamily: fontMavenProRegular,
                  height: 1.5,
                  fontSize: 14.sp),
              textAlign: TextAlign.center),
          SizedBox(
            height: 30.h,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: CommonBorderButton("Close".toUpperCase(), () {
                  Navigator.pop(context, false);
                }, red_dc3642, white_ffffff, red_dc3642),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                flex: 2,
                child: CommonRedButton("OK, Continue".toUpperCase(), () {
                  Navigator.pop(context, false);
                }, red_dc3642),
              ),
            ],
          )
        ],
      ),
    );
  }
}
