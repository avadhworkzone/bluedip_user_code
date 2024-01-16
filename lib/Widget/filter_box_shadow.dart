import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';

final filterboxDecoration = BoxDecoration(
    color: white_ffffff,
    boxShadow: const [
      BoxShadow(
        color: Color(0x40d3d1d8),
        offset: Offset(
          0,
          10,
        ),
        blurRadius: 30.0,
        spreadRadius: 0.0,
      )
    ],
    borderRadius: BorderRadius.all(Radius.circular(14.r)));

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
