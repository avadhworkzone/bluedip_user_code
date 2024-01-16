import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';

class BottomSheetSupport extends StatefulWidget {
  const BottomSheetSupport({Key? key}) : super(key: key);

  @override
  State<BottomSheetSupport> createState() => _BottomSheetSupportState();
}

class _BottomSheetSupportState extends State<BottomSheetSupport> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 20, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Opportunities
              Text("Support",
                  style: TextStyle(
                      color: black_504f58,
                      fontFamily: fontMavenProBold,
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.r),
                        color: Color(0xfff3f5f9)),
                    child: Padding(
                      padding: EdgeInsets.all(9.r),
                      child: SvgPicture.asset(
                        icon_phone_call,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  // Restaurant Hours
                  Text("Call us",
                      style: TextStyle(
                          color: black_504f58,
                          fontFamily: fontMavenProMedium,
                          fontSize: 15.sp),
                      textAlign: TextAlign.left)
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.r),
                        color: Color(0xfff3f5f9)),
                    child: Padding(
                      padding: EdgeInsets.all(9.r),
                      child: SvgPicture.asset(
                        icon_email,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  // Restaurant Hours
                  Text("Mail us",
                      style: TextStyle(
                          color: black_504f58,
                          fontFamily: fontMavenProMedium,
                          fontSize: 15.sp),
                      textAlign: TextAlign.left)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
