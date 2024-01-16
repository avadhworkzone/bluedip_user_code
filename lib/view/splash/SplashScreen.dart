import 'dart:async';

import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/utils/shared_preference_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../auth/WelcomeNewScreen.dart';
import '../auth/WelcomeScreen.dart';
import '../bottom_bar/BottomNavigationScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // PreferenceManagerUtils.clearPreference();
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    PreferenceManagerUtils.getIsLogin() == "true"
        ? Get.off(BottomNavigationScreen())
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: red_dc3642, // navigation bar color
      statusBarColor: red_dc3642, // status bar color
      statusBarIconBrightness: Brightness.light, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return Scaffold(
      backgroundColor: red_dc3642,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Image.asset(
                  bluedip_app_icon,
                  width: 103.w,
                  height: 103.h,
                ),
                Text(strBluedip,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontOverpassBold,
                        fontSize: 28.sp,
                        letterSpacing: 0.28),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          const SpinKitCircle(
            color: Colors.white,
            size: 38,
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
