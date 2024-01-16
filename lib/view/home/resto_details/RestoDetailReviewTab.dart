import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Model/ReviewModel.dart';
import '../../../Styles/my_strings.dart';
import '../../../Widget/Textfield.dart';
import '../../../Widget/back_button.dart';
import '../../../Widget/search_bar.dart';
import '../../../Widget/toolbar_with_title.dart';
import '../../../Widget/common_red_button.dart';
import '../../../Widget/common_verify_red_button.dart';

class RestoDetailReviewTab extends StatefulWidget {
  const RestoDetailReviewTab({Key? key}) : super(key: key);

  @override
  State<RestoDetailReviewTab> createState() => _SRestoDetailReviewTabState();
}

class _SRestoDetailReviewTabState extends State<RestoDetailReviewTab> {
  List<ReviewModel> reviewList = [
    ReviewModel(Color(0xffffe896), "John Doe"),
    ReviewModel(Color(0xff96d3ff), "Jenny"),
    ReviewModel(Color(0xfface094), "Erik"),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: white_ffffff,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        // 4
                        Text("4",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontOverpassBold,
                                fontSize: 18.sp),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 4.h,
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          unratedColor: Color(0xffd4dce7),
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => SvgPicture.asset(
                            icon_small_rating_bar,
                            color: Color(0xffffc529),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),

                    Container(
                      width: 1,
                      height: 50,
                      color: divider_d4dce7,
                    ),

                    // 315 Ratings & 15reviews
                    Text("315 Ratings & \n15 reviews",
                        style: TextStyle(
                            color: grey_77879e,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                            height: 1.5),
                        textAlign: TextAlign.left)
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: divider_d4dce7,
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20.h),
                  itemCount: reviewList.length,
                  itemBuilder: (context, i) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: reviewList[i].color,
                            ),
                            child: // J
                                Center(
                              child: Text("J",
                                  style: TextStyle(
                                      color: black_504f58,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 15.sp),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // John Doe
                                Text(reviewList[i].time,
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProMedium,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text("11-02-2023",
                                    style: TextStyle(
                                        color: grey_77879e,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 12.sp),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 10.h,
                                ),

                                Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    style: TextStyle(
                                        color: grey_5f6d7b,
                                        fontFamily: fontMavenProRegular,
                                        fontSize: 14.sp,
                                        height: 1.5),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: Color(0xfff6f6f6),
                            ),
                            child: Row(
                              children: [
                                // 4.5
                                Text("4.5",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProProSemiBold,
                                        fontSize: 14.sp),
                                    textAlign: TextAlign.left),
                                SvgPicture.asset(
                                  icon_small_rating_bar,
                                  width: 16.w,
                                  height: 16.h,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                        color: divider_d4dce7,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
