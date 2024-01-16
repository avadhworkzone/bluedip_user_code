import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';

class ToolbarChat extends StatelessWidget {
  final String title;
  ToolbarChat(this.title);
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          color: white_ffffff,
        boxShadow: [
          BoxShadow(
            color: Color(0x1017191a),
            blurRadius: 8.0,
            offset: Offset(0.0, 5),
            spreadRadius: 0.0,
          )
        ],
      ),
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
          SizedBox(width: 10.w,),
          SizedBox(
            width: 38.w,
            height: 38.h,
            child: CircleAvatar(
              radius: 50,
              child: Image.asset(
                img_girl,
                width: 38.w,
                height: 38.h,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(width: 12.w,),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(
                  fontFamily: fontMavenProProSemiBold,color: black_504f58,fontSize: 15.sp
                ),),
                // Online
                Text(
                    "Online",
                    style:  TextStyle(
                        color:  green_5cb85c,
                        fontFamily: fontMavenProMedium,
                        fontSize: 12.sp
                    ),
                    textAlign: TextAlign.left
                )
              ],
            ),
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
              child: SvgPicture.asset(icon_menu,color: grey_5f6d7b,width: 24.w,height: 24.h,)),

          SizedBox(width: 12.w,),

        ],
      ),
    );
  }
}

