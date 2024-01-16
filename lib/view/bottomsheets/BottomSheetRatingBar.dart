import 'package:bluedip_user/Styles/my_strings.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../home/RatingBarScreen.dart';
import '../../Widget/common_red_button.dart';

class BottomSheetRatingBar extends StatefulWidget {
  const BottomSheetRatingBar({Key? key}) : super(key: key);

  @override
  State<BottomSheetRatingBar> createState() => _BottomSheetRatingBarState();
}

class _BottomSheetRatingBarState extends State<BottomSheetRatingBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 20, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Pizza Hut
                Row(
                  children: [
                    SizedBox(
                      width: 25.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Pizza Hut".toUpperCase(),
                          style: TextStyle(
                              color: black_504f58,
                              fontFamily: fontMavenProMedium,
                              fontSize: 14.sp),
                          textAlign: TextAlign.center),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: SvgPicture.asset(icon_cancel)),
                    SizedBox(
                      width: 15.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                // How was your food?
                Text("How was your food?",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProBold,
                        fontSize: 16.sp),
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 14.h,
                ),
                RatingBar(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: Color(0xffd4dce7),
                  glowColor: Color(0xffd4dce7),
                  itemCount: 5,
                  itemSize: 35,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  ratingWidget: RatingWidget(
                      full: SvgPicture.asset(icon_small_rating_bar,
                          width: 20, height: 20),
                      // full: const Icon(Icons.star, color:yellow_FFC800),
                      half: SvgPicture.asset(icon_small_rating_bar,
                          width: 20, height: 20),
                      // half: const Icon(Icons.star_half, color:yellow_FFC800,),
                      empty: SvgPicture.asset(icon_star_border,
                          width: 20, height: 20)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 30.h,
                ),
                // SizedBox(
                //   width: 210.w,
                //   child: CommonRedButton(strContinue.toUpperCase(), () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const RatingBarScreen(),
                //         ));
                //   }, red_dc3642),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
