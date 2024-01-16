import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetMoreOption extends StatefulWidget {
  const BottomSheetMoreOption({Key? key}) : super(key: key);

  @override
  State<BottomSheetMoreOption> createState() => _BottomSheetMoreOptionState();
}

class _BottomSheetMoreOptionState extends State<BottomSheetMoreOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SvgPicture.asset(icon_cancel_square),
                SizedBox(
                  width: 11.w,
                ),
                // Cancel Booking
                Text("Cancel Booking",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProMedium,
                        fontSize: 15.sp),
                    textAlign: TextAlign.left)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SvgPicture.asset(icon_call_restaurant),
                SizedBox(
                  width: 11.w,
                ),
                // Cancel Booking
                Text("Call Restaurant",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProMedium,
                        fontSize: 15.sp),
                    textAlign: TextAlign.left)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SvgPicture.asset(icon_view_menu),
                SizedBox(
                  width: 11.w,
                ),
                // Cancel Booking
                Text("View Menu",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProMedium,
                        fontSize: 15.sp),
                    textAlign: TextAlign.left)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SvgPicture.asset(icon_locate_restaurant),
                SizedBox(
                  width: 11.w,
                ),
                // Cancel Booking
                Text("Locate Restaurant",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProMedium,
                        fontSize: 15.sp),
                    textAlign: TextAlign.left)
              ],
            ),
          )
        ],
      ),
    );
  }
}
