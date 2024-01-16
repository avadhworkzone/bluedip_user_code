import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Styles/my_colors.dart';

final redboxDecoration = BoxDecoration(
    color: red_dc3642,
    boxShadow: const [
      BoxShadow(
        color: red_shadow_8cdc3642,
        offset: Offset(
          0.0,
          4.0,
        ),
        blurRadius: 15.0,
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
