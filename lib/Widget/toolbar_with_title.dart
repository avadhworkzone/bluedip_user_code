import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';

class ToolbarWithTitle extends StatelessWidget {
  final String title;
  ToolbarWithTitle(this.title);
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



        ],
      ),
    );
  }
}

