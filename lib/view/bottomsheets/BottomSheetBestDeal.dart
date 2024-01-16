import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetBestDeal extends StatefulWidget {
  const BottomSheetBestDeal({Key? key}) : super(key: key);

  @override
  State<BottomSheetBestDeal> createState() => _BottomSheetBestDealState();
}

class _BottomSheetBestDealState extends State<BottomSheetBestDeal> {
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
              img_best_deal,
              width: double.infinity,
              height: 190.h,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          // Best Deals!
          Text("Best Deals!",
              style: TextStyle(
                  color: red_dc3642,
                  fontFamily: fontOverpassBold,
                  fontSize: 28.sp),
              textAlign: TextAlign.center),
          SizedBox(
            height: 24.h,
          ),

          // You can order and pay through a digital menu with the deal already applied to your order.
          Text(
              "Our app uses dynamic pricing to offer you the most competitive prices at all times. Keep an eye out for special deals and discounts!",
              style: TextStyle(
                  color: black_504f58,
                  fontFamily: fontMavenProRegular,
                  height: 1.7,
                  fontSize: 15.sp),
              textAlign: TextAlign.center),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            width: 210.w,
            child: CommonRedButton("OK, Continue".toUpperCase(), () {
              Navigator.pop(context, false);
            }, red_dc3642),
          ),
        ],
      ),
    );
  }
}
