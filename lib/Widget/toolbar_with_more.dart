import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';

class ToolbarWithTitleMore extends StatelessWidget {
  final String title;
  final String icon;
  ToolbarWithTitleMore(this.title,this.icon,);
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
          
          PopupMenuButton(
              offset: const Offset(-10, 15),
              shadowColor: Color(0x60d3d1d8),
              itemBuilder: (context) => [
                PopupMenuItem(
                  height: 30,
                  value: 0,
                  onTap: ()  {},
                  child: // Edit
                  Text("Report",
                      style: TextStyle(
                          color:
                          black_504f58,
                          fontFamily:
                          fontMavenProMedium,
                          fontSize: 14.sp),
                      textAlign:
                      TextAlign.left),
                ),
                PopupMenuItem(
                  value: 0,
                  height: 30,
                  onTap: ()  {},
                  child: // Edit
                  Text("Block",
                      style: TextStyle(
                          color:
                          red_dc3642,
                          fontFamily:
                          fontMavenProMedium,
                          fontSize: 14.sp),
                      textAlign:
                      TextAlign.left),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(12),
              ),
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10),
              child: SvgPicture.asset(icon,color: grey_5f6d7b,width: 24.w,height: 24.h,)),
          SizedBox(width: 15.w,)



        ],
      ),
    );
  }
}

