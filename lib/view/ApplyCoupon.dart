import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:bluedip_user/Widget/toolbar_with_title_shadow.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Model/HoursModel.dart';
import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button.dart';
import '../Widget/search_bar.dart';
import '../Widget/toolbar_with_search.dart';
import '../Widget/toolbar_with_title.dart';
import 'bottomsheets/BottomSheetBestDeal.dart';
import 'RedeemOfferDetailPage.dart';
import '../Widget/common_red_button.dart';
import '../Widget/common_verify_red_button.dart';

class ApplyCoupon extends StatefulWidget {
  const ApplyCoupon({Key? key}) : super(key: key);

  @override
  State<ApplyCoupon> createState() => _ApplyCouponState();
}

class _ApplyCouponState extends State<ApplyCoupon> {
  bool isOfferLayout = false;
  bool isDown = true;
  bool isUp = false;

  bool isOfferLayoutSecond = false;
  bool isDownSecond = true;
  bool isUpSecond = false;
  final List<League> data = <League>[
    League(
        'GET10',
        <Club>[
          Club("Offer applicable for selected users.", 0),
          Club("Minimum order Rs.500", 0),
          Club("Maximum discount Rs.100", 0),
        ],
        false),
    League(
        'GET20',
        <Club>[
          Club("Offer applicable for selected users.", 0),
          Club("Minimum order Rs.500", 0),
          Club("Maximum discount Rs.100", 0),
        ],
        false),
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
        backgroundColor: bg_fafbfb,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleShadow("Apply Coupon"),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.h, horizontal: 14.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.r),
                            color: Colors.white,
                            border: Border.all(width: 1, color: grey_d9dde3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {},
                                onSubmitted: (value) {},
                                autofocus: false,
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 15.sp),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "Enter coupon code here",
                                  hintStyle: TextStyle(
                                      color: grey_77879e,
                                      fontFamily: fontMavenProMedium,
                                      fontSize: 15.sp),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            Text("Apply",
                                style: TextStyle(
                                    color: blue_007add,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 15.sp),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                      // Best Offers
                      Text("Best Offers".toUpperCase(),
                          style: TextStyle(
                              color: grey_77879e,
                              fontWeight: FontWeight.w500,
                              fontFamily: fontMavenProMedium,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 20.h,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) => data[
                                    index]
                                .listClubs
                                .isNotEmpty
                            ? Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: cardboxDecoration,
                                child: Column(
                                  children: [
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.all(0.r),
                                        dense: true,
                                        horizontalTitleGap: 0.0,
                                        minLeadingWidth: 0,
                                        child: ExpansionTile(
                                          iconColor: grey_77879e,
                                          collapsedIconColor: grey_77879e,

                                          onExpansionChanged: (value) {
                                            setState(() {
                                              data[index].isExpandArrow = value;
                                            });
                                          },
                                          //  trailing: isExpanded? SvgPicture.asset(icon_down_arrow_expand) : SvgPicture.asset(icon_down_arrow_expand),
                                          trailing: AnimatedRotation(

                                              /// you can use different widget for animation
                                              turns: data[index].isExpandArrow
                                                  ? .5
                                                  : 0,
                                              duration: const Duration(
                                                  milliseconds: 1),
                                              // alignment: Alignment.bottomRight,
                                              child: SvgPicture.asset(
                                                icon_down_arrow_expand,
                                                width: 16.w,
                                                height: 16.h,
                                              ) // your svgImage here
                                              ),

                                          // trailing: Icon(
                                          //   Icons.keyboard_arrow_down,
                                          //   color: Colors.green,
                                          // ),

                                          key: PageStorageKey<League>(
                                              data[index]),
                                          tilePadding:
                                              EdgeInsets.only(right: 16.w),
                                          title: Padding(
                                            padding: EdgeInsets.only(
                                                left: 14.w,
                                                top: 14.h,
                                                bottom: 6.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  icon_offer_pink_png,
                                                  width: 24,
                                                  height: 24,
                                                ),
                                                SizedBox(
                                                  width: 6.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("10% OFF up to",
                                                        style: TextStyle(
                                                            color: grey_504f58,
                                                            fontFamily:
                                                                fontMavenProBold,
                                                            fontSize: 16.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                                    SizedBox(
                                                      height: 14.h,
                                                    ),
                                                    Text(data[index].TvTitle,
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontSize: 14.sp)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          children: data[index]
                                              .listClubs
                                              .asMap()
                                              .entries
                                              .map(
                                            (pos) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    16.w),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 10
                                                                              .h),
                                                                  child:
                                                                      Container(
                                                                    width: 4,
                                                                    height: 4,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color:
                                                                            grey_77879e),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 8.w,
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                      data[index]
                                                                          .listClubs[pos
                                                                              .key]
                                                                          .tvLable,
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          fontFamily:
                                                                              fontMavenProRegular,
                                                                          color:
                                                                              grey_5f6d7b,
                                                                          height:
                                                                              1.5)),
                                                                ),

                                                                //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                              ],
                                                            ),
                                                            data[index].listClubs.length -
                                                                        1 !=
                                                                    pos.key
                                                                ? SizedBox(
                                                                    height: 12,
                                                                  )
                                                                : SizedBox(
                                                                    height: 20)
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0x0c007add),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(14.r),
                                            bottomLeft: Radius.circular(14.r)),
                                      ),
                                      padding: EdgeInsets.all(14.r),
                                      child: Text("Apply".toUpperCase(),
                                          style: TextStyle(
                                              color: blue_007add,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  ListTile(
                                    title: Text(data[index].TvTitle,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            // fontFamily: fontOverpassBold,
                                            color: black_504f58)),
                                  ),
                                  // Divider(
                                  //   height: 1,
                                  //   thickness: 1,
                                  //   color: grey_969da8,
                                  // ),
                                ],
                              ),
                        itemCount: data.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class League {
  String TvTitle;
  bool isExpandArrow = false;
  List<Club> listClubs;

  League(this.TvTitle, this.listClubs, this.isExpandArrow);
}

class Club {
  int count;

  String tvLable;

  Club(this.tvLable, this.count);
}
