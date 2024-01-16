import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';
import '../utils/typedef_utils.dart';

class ToolbarWithTitleCancel extends StatelessWidget {
  final String? title;
  final OnTap? onTap;
  const ToolbarWithTitleCancel({super.key, this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h, left: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
              onTap: onTap,

              ///Navigator.pop(context, false),
              child: Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(icon_cancel),
                  ))),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            flex: 1,
            child: Text(
              title!,
              style: TextStyle(
                  fontFamily: fontOverpassBold,
                  color: black_504f58,
                  fontSize: 20.sp),
            ),
          ),
        ],
      ),
    );
  }
}
