import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/view/DeleteChatList.dart';
import 'package:bluedip_user/view/profile/profile_menu/FavouriteScreen.dart';
import 'package:bluedip_user/view/profile/profile_menu/OrderHistory.dart';
import 'package:bluedip_user/view/auth/OtpVerificationScreen.dart';
import 'package:bluedip_user/view/Popo.dart';
import 'package:bluedip_user/view/order/RedeemOffer.dart';
import 'package:bluedip_user/view/RestoDetailPageTest.dart';
import 'package:bluedip_user/view/food_buddy/SelectContact.dart';
import 'package:bluedip_user/view/auth/SignupDetailScreen.dart';
import 'package:bluedip_user/view/food_buddy/SwipeToDeleletList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth/WelcomeNewScreen.dart';
import 'food_buddy/AddReels.dart';
import 'ExpandebleWidget.dart';
import 'dine_in/RedeemDineInBookingDetail.dart';
import 'RedeemDineInBookingDetailInActive.dart';
import 'RedeemExpandOrderrtest.dart';
import 'RestoDetailPage.dart';
import 'select_location/SelecLocationList.dart';
import 'SliverAppBarStatus.dart';
import 'auth/WelcomeScreen.dart';
import 'splash/SplashScreen.dart';
import 'TestPage.dart';
import 'home/resto_details/RestoDetailScreen.dart';
import 'TestSilverAppbarExample.dart';
import 'TestSilverAppbarExampleSecond.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            Center(
              child: Text(
                "List of Screen",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: fontOverpassBold),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "1.Splash Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "2.Welcome Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const OtpVerificationScreen(),
                //     ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "3.OtpVerificationScreen Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupDetailScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "4.SignupDetailScreen Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelecLocationList(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "5.SelecLocationList Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "6.BottomNavigationScreen Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const RestoDetailPage(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "7.RestoDetailPage Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const RestoDetailPageTest(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "8.RestoDetailPageTest Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const SliverAppBarStatus(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "9.SliverAppBarStatus Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Popo(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "10.Popo Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => RedeemOffer(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "11.RedeemOffer Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderHistory(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "12.OrderHistory Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavouriteScreen(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "13.FavouriteScreen Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectContact(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "14.SelectContact Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteChatList(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "15.DeleteChatList Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwipeToDeleletList(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "16.SwipeToDeleletList Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestPage(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "17.TestPage Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => RestaurantDetailsScreen(),
                //     ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "17.TestPageSecond Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) =>  ImagePicker(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "18.ImagePicker Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RedeemDineInBookingDetail(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "19.RedeemDineInBookingDetail Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => RedeemDineInBookingDetailInActive(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "20.RedeemDineInBookingDetailInActive Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestSilverAppbarExample(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "21.TestSilverAppbarExample Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => TestSilverAppbarExampleSecond(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "21.TestSilverAppbarExampleSecond Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddReels(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "22.AddReels Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => RedeemExpandOrderrtest(),
            //         ));
            //   },
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            //     child: Text(
            //       "23.RedeemExpandOrderrtest Screen",
            //       style: TextStyle(
            //           color: Colors.black87,
            //           fontFamily: fontMavenProMedium,
            //           fontSize: 16.sp),
            //     ),
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpandebleWidget(),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                child: Text(
                  "24.ExpandebleWidget Screen",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: fontMavenProMedium,
                      fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
