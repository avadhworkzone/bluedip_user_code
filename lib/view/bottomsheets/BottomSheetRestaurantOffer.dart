import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Model/CityListModel.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/box_shadow_ticket.dart';
import '../../Widget/box_shadow_ticket_second.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/home_rating_box_shadow.dart';
import 'BottomSheetOpeningHours.dart';
import '../../Widget/common_red_button.dart';
import 'BottomSheetReddem20.dart';
import 'BottomSheetReddem40.dart';

class BottomSheetRestaurantOffer extends StatefulWidget {
  const BottomSheetRestaurantOffer({Key? key}) : super(key: key);

  @override
  State<BottomSheetRestaurantOffer> createState() =>
      _BottomSheetRestaurantOfferState();
}

class _BottomSheetRestaurantOfferState
    extends State<BottomSheetRestaurantOffer> {
  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];

  List<CityListModel> cityList2 = [
    CityListModel("50% off - Takeaway"),
    CityListModel("40% off - Dine In"),
    CityListModel("40% off - Dine In"),
  ];

  bool isNoDealLayout = true;
  bool isOfferListLayout = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cityList2.length >= 3
                  ? SizedBox(
                      height: 580.h,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Image.asset(
                                        img_pizza_hut,
                                        width: double.infinity,
                                        height: 168.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: SvgPicture.asset(icon_red_heart),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // McDonald’s
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pizza Hut",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontOverpassBold,
                                                      fontSize: 18.sp,
                                                      letterSpacing: 0.18),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              // Sec 16, Dwarka, New Delhi
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Sec 16, Dwarka, New Delhi ",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  Container(
                                                    width: 3.w,
                                                    height: 3.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: grey_5f6d7b),
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Text("2.5km",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.w, vertical: 8.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color: Color(0xfff6f6f6)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  // 4.5
                                                  Text("4.5",
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SvgPicture.asset(
                                                    icon_small_rating_bar,
                                                    width: 14.w,
                                                    height: 14.h,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text("(25+)",
                                                  style: TextStyle(
                                                      color: grey_77879e,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(
                                      height: 12.h,
                                    ),

                                    Row(
                                      children: [
                                        Image.asset(
                                          icon_takeaway_png,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        // Takeaway
                                        Text("Takeaway",
                                            style: TextStyle(
                                                color: grey_5f6d7b,
                                                fontFamily: fontMavenProRegular,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),

                                        SizedBox(
                                          width: 12.w,
                                        ),

                                        Image.asset(
                                          icon_dinein_png,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        // Takeaway
                                        Text("Dine-in",
                                            style: TextStyle(
                                                color: grey_5f6d7b,
                                                fontFamily: fontMavenProRegular,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 8.h,
                                    ),

                                    SizedBox(
                                      height: 22.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: cityList.length,
                                        itemBuilder: (context, i) => Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: Color(0xfff6f6f6)),
                                          child: // Chicken
                                              Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w, vertical: 4.h),
                                            child: Text(cityList[i].title,
                                                style: TextStyle(
                                                    color: grey_77879e,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 14.h,
                                    ),

                                    Row(
                                      children: [
                                        // Now Open
                                        Text("Now Open",
                                            style: TextStyle(
                                                color: green_5cb85c,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),

                                        SizedBox(
                                          width: 8.w,
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              selectHours(context);
                                            },
                                            child: Row(
                                              children: [
                                                Text("Close 10:00 PM",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 12.sp),
                                                    textAlign: TextAlign.left),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                SvgPicture.asset(
                                                  icon_down_arrow,
                                                  width: 5.w,
                                                  height: 5.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        Image.asset(
                                          icon_rupee_slim,
                                          width: 9.w,
                                          height: 9.h,
                                        ),
                                        // 500 for 2
                                        Text("500 for 2",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left)
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: divider_d4dce7,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text("Offers".toUpperCase(),
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            Visibility(
                              visible: isNoDealLayout,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNoDealLayout = false;
                                    isOfferListLayout = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 21.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24.h,
                                          ),
                                          Image.asset(
                                            img_no_deals,
                                            width: 165.w,
                                            height: 80.h,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(" Oops! No Deals Available",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: fontOverpassBold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.sp),
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          // Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to b
                                          Text(
                                              "Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to be notified when they post their next deal.",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  height: 1.5,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.center),

                                          SizedBox(
                                            height: 24.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: divider_d4dce7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isOfferListLayout,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20.h),
                                itemCount: cityList2.length,
                                itemBuilder: (context, i) => GestureDetector(
                                  onTap: () {
                                    if (i == 1) {
                                      Navigator.pop(context, false);
                                      selectRedeem40(context);
                                    } else {
                                      Navigator.pop(context, false);
                                      selectVenueOrdering(context);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14.r),
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    decoration: cardboxDecoration,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              icon_flash_offer,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(cityList2[i].title,
                                                      style: TextStyle(
                                                          color: red_dc3642,
                                                          fontFamily:
                                                              fontMavenProBold,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 16.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  // Offer valid between 12:30 - 7:00pm
                                                  Text(
                                                      "Offer valid between 12:30 - 7:00pm",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  i == 1
                                                      ? Row(
                                                          children: [
                                                            // 10 Deals Left
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  "Sold out",
                                                                  style: TextStyle(
                                                                      color:
                                                                          grey_77879e,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize: 12
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(12
                                                                            .r),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        divider_d4dce7,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r)),
                                                                child: // Redeem
                                                                    Text(
                                                                        "None Left",
                                                                        style: TextStyle(
                                                                            color:
                                                                                grey_77879e,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            fontSize: 14
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.center),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            // 10 Deals Left
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  "10 Deals Left",
                                                                  style: TextStyle(
                                                                      color:
                                                                          black_504f58,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize: 12
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(12
                                                                            .r),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: [
                                                                            Color(0xffff8a9e),
                                                                            Color(0xfff43f5e),
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.r)),
                                                                child: // Redeem
                                                                    Text(
                                                                        "Redeem",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            fontSize: 14
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.center),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Wrap(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: Image.asset(
                                        img_pizza_hut,
                                        width: double.infinity,
                                        height: 168.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: SvgPicture.asset(icon_red_heart),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // McDonald’s
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pizza Hut",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontOverpassBold,
                                                      fontSize: 18.sp,
                                                      letterSpacing: 0.18),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              // Sec 16, Dwarka, New Delhi
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      "Sec 16, Dwarka, New Delhi ",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  Container(
                                                    width: 3.w,
                                                    height: 3.w,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: grey_5f6d7b),
                                                  ),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Text("2.5km",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.w, vertical: 8.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color: Color(0xfff6f6f6)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  // 4.5
                                                  Text("4.5",
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SvgPicture.asset(
                                                    icon_small_rating_bar,
                                                    width: 14.w,
                                                    height: 14.h,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text("(25+)",
                                                  style: TextStyle(
                                                      color: grey_77879e,
                                                      fontFamily:
                                                          fontMavenProMedium,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(
                                      height: 12.h,
                                    ),

                                    Row(
                                      children: [
                                        Image.asset(
                                          icon_takeaway_png,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        // Takeaway
                                        Text("Takeaway",
                                            style: TextStyle(
                                                color: grey_5f6d7b,
                                                fontFamily: fontMavenProRegular,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),

                                        SizedBox(
                                          width: 12.w,
                                        ),

                                        Image.asset(
                                          icon_dinein_png,
                                          width: 14.w,
                                          height: 14.h,
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        // Takeaway
                                        Text("Dine-in",
                                            style: TextStyle(
                                                color: grey_5f6d7b,
                                                fontFamily: fontMavenProRegular,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 8.h,
                                    ),

                                    SizedBox(
                                      height: 22.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: cityList.length,
                                        itemBuilder: (context, i) => Container(
                                          margin: EdgeInsets.only(right: 8.w),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color: Color(0xfff6f6f6)),
                                          child: // Chicken
                                              Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w, vertical: 4.h),
                                            child: Text(cityList[i].title,
                                                style: TextStyle(
                                                    color: grey_77879e,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    fontSize: 12.sp),
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 14.h,
                                    ),

                                    Row(
                                      children: [
                                        // Now Open
                                        Text("Now Open",
                                            style: TextStyle(
                                                color: green_5cb85c,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left),

                                        SizedBox(
                                          width: 8.w,
                                        ),

                                        Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                            onTap: () {
                                              selectHours(context);
                                            },
                                            child: Row(
                                              children: [
                                                Text("Close 10:00 PM",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 12.sp),
                                                    textAlign: TextAlign.left),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                SvgPicture.asset(
                                                  icon_down_arrow,
                                                  width: 5.w,
                                                  height: 5.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        Image.asset(
                                          icon_rupee_slim,
                                          width: 9.w,
                                          height: 9.h,
                                        ),
                                        // 500 for 2
                                        Text("500 for 2",
                                            style: TextStyle(
                                                color: black_504f58,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 12.sp),
                                            textAlign: TextAlign.left)
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: divider_d4dce7,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Text("Offers".toUpperCase(),
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.left),
                            Visibility(
                              visible: isNoDealLayout,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isNoDealLayout = false;
                                    isOfferListLayout = true;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 21.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 24.h,
                                          ),
                                          Image.asset(
                                            img_no_deals,
                                            width: 165.w,
                                            height: 80.h,
                                            fit: BoxFit.fill,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Text(" Oops! No Deals Available",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: fontOverpassBold,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.sp),
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          // Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to b
                                          Text(
                                              "Sorry, there are no live deals right now... In the meantime you can favourite Coventry's Pantry to be notified when they post their next deal.",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  height: 1.5,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.center),

                                          SizedBox(
                                            height: 24.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: divider_d4dce7,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isOfferListLayout,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                primary: false,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(top: 20.h),
                                itemCount: cityList2.length,
                                itemBuilder: (context, i) => GestureDetector(
                                  onTap: () {
                                    if (i == 1) {
                                      Navigator.pop(context, false);
                                      selectRedeem40(context);
                                    } else {
                                      Navigator.pop(context, false);
                                      selectVenueOrdering(context);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(14.r),
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    decoration: cardboxDecoration,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              icon_flash_offer,
                                              width: 22.w,
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(cityList2[i].title,
                                                      style: TextStyle(
                                                          color: red_dc3642,
                                                          fontFamily:
                                                              fontMavenProBold,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 16.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  // Offer valid between 12:30 - 7:00pm
                                                  Text(
                                                      "Offer valid between 12:30 - 7:00pm",
                                                      style: TextStyle(
                                                          color: grey_5f6d7b,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 14.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  i == 1
                                                      ? Row(
                                                          children: [
                                                            // 10 Deals Left
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  "Sold out",
                                                                  style: TextStyle(
                                                                      color:
                                                                          grey_77879e,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize: 12
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(12
                                                                            .r),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        divider_d4dce7,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12.r)),
                                                                child: // Redeem
                                                                    Text(
                                                                        "None Left",
                                                                        style: TextStyle(
                                                                            color:
                                                                                grey_77879e,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            fontSize: 14
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.center),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            // 10 Deals Left
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  "10 Deals Left",
                                                                  style: TextStyle(
                                                                      color:
                                                                          black_504f58,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      fontSize: 12
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(12
                                                                            .r),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: [
                                                                            Color(0xffff8a9e),
                                                                            Color(0xfff43f5e),
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.r)),
                                                                child: // Redeem
                                                                    Text(
                                                                        "Redeem",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontFamily:
                                                                                fontMavenProMedium,
                                                                            fontSize: 14
                                                                                .sp),
                                                                        textAlign:
                                                                            TextAlign.center),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

void selectHours(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            margin: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                    bottomRight: Radius.circular(13.r),
                    bottomLeft: Radius.circular(13.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13)),
                    child: Column(
                      children: [BottomSheetOpeningHours()],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CommonBorderButton(
                      "Close".toUpperCase(),
                      () => Navigator.pop(context, false),
                      Colors.white,
                      Colors.white,
                      red_dc3642),
                ],
              ),
            ));
      });
}

void selectRedeem20(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: BoxDecoration(
                color: white_ffffff,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: const [BottomSheetReddem20()],
              ),
            ));
      });
}

void selectRedeem40(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: BoxDecoration(
                color: white_ffffff,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.r),
                    topRight: Radius.circular(18.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: const [BottomSheetReddem40()],
              ),
            ));
      });
}

void selectVenueOrdering(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: BoxDecoration(
                color: white_ffffff,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r))),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            img_venue_png,
                            width: double.infinity,
                            height: 190.h,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                            "This venue is set up for Bluedip In \nApp Ordering.",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontOverpassBold,
                                height: 1.5,
                                fontSize: 18.sp),
                            textAlign: TextAlign.center),
                        Text(
                            "You can order and pay through a digital \nmenu with the deal already applied \nto your order.",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProRegular,
                                height: 1.5,
                                fontSize: 14.sp),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child:
                                  CommonBorderButton("Close".toUpperCase(), () {
                                Navigator.pop(context, false);
                              }, red_dc3642, white_ffffff, red_dc3642),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              flex: 2,
                              child: CommonRedButton(
                                  "OK, Continue".toUpperCase(), () {
                                Navigator.pop(context, false);
                                selectRedeem20(context);
                              }, red_dc3642),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}
