import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';

final boxDecorationTicketInActive = BoxDecoration(
    color:Color(0xfff0f0f0),
    border: Border.all(
        width: 1,
        color: Color(0xfff0f0f0),
     style: BorderStyle.solid,
      strokeAlign: BorderSide.strokeAlignInside

    ),
    // boxShadow: [
    //   BoxShadow(
    //     color: Color(0x40d3d1d8),
    //     offset: Offset(
    //       0.0,
    //       20.0,
    //     ),
    //     blurRadius: 30.0,
    //     spreadRadius: 0.0,
    //   )
    // ],
  borderRadius: BorderRadius.only(topRight: Radius.circular(12.r),topLeft: Radius.circular(12.r)),);

// final selectboxDecoration = BoxDecoration(
//     border: Border.all(color: bg_btn_199a8e, width: 1),
//     color: Colors.white,
//     boxShadow: [
//       BoxShadow(
//         color: shadow_0x0f041d42,
//         offset: Offset(
//           0.0,
//           3.0,
//         ),
//         blurRadius: 21.0,
//         spreadRadius: 0.0,
//       )
//     ],
//     borderRadius: BorderRadius.all(Radius.circular(14.r)));
