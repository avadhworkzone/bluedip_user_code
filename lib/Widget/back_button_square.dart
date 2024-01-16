import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_icons.dart';

class back_button_square extends StatelessWidget {
  // const back_button(String strWhereFrom, {Key? key}) : super(key: key);
  // String strWhereFrom;
  // back_button(this.strWhereFrom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {Navigator.pop(context, false)},
        child: Container(
            width: 33.w,
            height: 33.h,
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r), color: white_ffffff),
            child: SvgPicture.asset(icon_arrow_left)));
  }
}
