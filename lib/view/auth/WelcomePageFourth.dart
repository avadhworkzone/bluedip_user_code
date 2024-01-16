import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';

class WelcomePageFourth extends StatefulWidget {
  const WelcomePageFourth({Key? key}) : super(key: key);

  @override
  State<WelcomePageFourth> createState() => _WelcomePageFourthState();
}

class _WelcomePageFourthState extends State<WelcomePageFourth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_ffffff,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 68.h,
          ),
          Center(
              child: Image.asset(
            wlcm_img,
            width: 300.w,
            height: 251.h,
            fit: BoxFit.fill,
          )),
          SizedBox(
            height: 36.h,
          ),
          Text("Tired of eating alone?",
              style: TextStyle(
                  color: black_504f58,
                  fontFamily: fontOverpassBold,
                  fontSize: 28.sp,
                  letterSpacing: 0.28),
              textAlign: TextAlign.left),
          SizedBox(
            height: 8.h,
          ),
          // Discover your city’s restaurants and dine with up to 50% off the total bill including drinks
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: Text(
                "oin the Bluedip community and make new foodie friends! Who knows, you might even find a food buddy for life!",
                style: TextStyle(
                    color: black_504f58,
                    fontFamily: fontMavenProRegular,
                    fontSize: 15.sp,
                    letterSpacing: 0.5,
                    height: 1.5),
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
