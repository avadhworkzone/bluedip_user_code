import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';



class CookingInstruction extends StatefulWidget {
  const CookingInstruction({Key? key}) : super(key: key);

  @override
  State<CookingInstruction> createState() => _CookingInstructionState();
}

class _CookingInstructionState extends State<CookingInstruction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: cardboxDecoration,
          padding: EdgeInsets.all(14.r),
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Detail
              Text("Cooking Instructions".toUpperCase(),
                  style: TextStyle(
                      color: grey_77879e,
                      fontFamily: fontMavenProMedium,
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 10.h,
              ),
              // Make it little spicy
              Text("Make it little spicy",
                  style: TextStyle(
                      color: black_504f58,
                      fontWeight: FontWeight.w500,
                      fontFamily: fontMavenProMedium,
                      fontStyle: FontStyle.normal,
                      fontSize: 15.sp),
                  textAlign: TextAlign.left)
            ],
          ),
        ),
      ],
    );
  }
}
