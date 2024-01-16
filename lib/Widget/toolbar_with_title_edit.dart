import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';


class ToolbarWithTitleEdit extends StatelessWidget {
  final String title;
  VoidCallback? onCustomButtonPressed;
  ToolbarWithTitleEdit(this.title,this.onCustomButtonPressed);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10.h,bottom:10.h,left: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [

          GestureDetector(
              onTap: () => Navigator.pop(context, false),
              child: Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(icon_arrow_left),
                  ))),
          SizedBox(width: 20.w,),

          Expanded(
            flex: 1,
            child: Text(title,style: TextStyle(
              fontFamily: fontOverpassBold,color: black_504f58,fontSize: 20.sp
            ),),
          ),


          GestureDetector(
            onTap: onCustomButtonPressed,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 17.w,vertical: 6.h),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: blue_007add,
                  width: 1
                ),
              ),
              child: Text(
                  "EDIT",
                  style:  TextStyle(
                      color:  blue_007add,
                      fontFamily: fontMavenProMedium,
                      fontStyle:  FontStyle.normal,
                      fontSize: 15.sp
                  ),
                  textAlign: TextAlign.left
              ),
            ),
          )

        ],
      ),
    );
  }
}

