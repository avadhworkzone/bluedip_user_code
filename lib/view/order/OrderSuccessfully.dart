import 'package:bluedip_user/Styles/my_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_icons.dart';
import '../bottom_bar/BottomNavigationScreen.dart';
import '../../Widget/common_red_button.dart';

class OrderSuccessfully extends StatefulWidget {
  const OrderSuccessfully({Key? key}) : super(key: key);

  @override
  State<OrderSuccessfully> createState() => _OrderSuccessfullyState();
}

class _OrderSuccessfullyState extends State<OrderSuccessfully> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.white, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, false);
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(icon_cancel),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(img_sucess_order,width: 175.w,height: 164.h,fit: BoxFit.cover,),
                  Lottie.network(
                    'https://assets4.lottiefiles.com/packages/lf20_lp7qD9RDx1.json',
                    width: 200.w,
                    height: 187.h,
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  // Payment Successful!
                  Text("Order Successfully \nPlaced!",
                      style: TextStyle(
                          color: black_504f58,
                          fontFamily: fontOverpassBold,
                          fontSize: 28.sp),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 30.h,
                  ),
                  // (Txn Id: 123654789)
                  Text("(Txn Id: 123654789)",
                      style: TextStyle(
                          color: grey_77879e,
                          fontFamily: fontMavenProRegular,
                          fontSize: 13.sp),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 20.h,
                  ),

                  // Order ID: 123654789dcsa
                  Text("Order ID: 123654789dcsa",
                      style: TextStyle(
                          color: black_504f58,
                          fontFamily: fontMavenProMedium,
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp),
                      textAlign: TextAlign.left)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            child: CommonRedButton("OK".toUpperCase(), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationScreen(),
                  ));
            }, red_dc3642),
          ),
        ],
      ),
    ));
  }
}
