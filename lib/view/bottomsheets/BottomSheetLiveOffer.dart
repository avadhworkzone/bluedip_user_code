import 'package:bluedip_user/Widget/back_button.dart';
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
import '../../Widget/common_red_button.dart';
import 'BottomSheetOpeningHours.dart';
import 'BottomSheetRestaurantOffer.dart';
import '../home/OffferListCommonLayout.dart';

class BottomSheetLiveOffer extends StatefulWidget {
  const BottomSheetLiveOffer({Key? key}) : super(key: key);

  @override
  State<BottomSheetLiveOffer> createState() => _BottomSheetLiveOfferState();
}

class _BottomSheetLiveOfferState extends State<BottomSheetLiveOffer> {
  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];

  List<CityListModel> onDealsModel = [];
  List<CityListModel> selectedList = [];

  @override
  void initState() {
    onDealsModel.clear();
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_mcd));
    onDealsModel.add(CityListModel(img_mcd));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onDealsModel.length >= 3
                  ? SizedBox(
                      height: 600.h,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        primary: false,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: 4.h,
                        ),
                        itemCount: onDealsModel.length,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context, false);
                            selectRestaurantOffer(context);
                          },
                          child: Stack(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: 16.h, left: 6.w),
                                decoration: cardboxDecoration,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.r),
                                              topRight: Radius.circular(10.r),
                                            ),
                                            child: Image.asset(
                                              onDealsModel[i].title,
                                              width: double.infinity,
                                              height: 168.h,
                                              fit: BoxFit.fill,
                                            )),
                                        Positioned(
                                            bottom: 110,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      setState(
                                                        () {
                                                          if (selectedList
                                                              .contains(
                                                                  onDealsModel[
                                                                      i])) {
                                                            selectedList.remove(
                                                                onDealsModel[
                                                                    i]);
                                                          } else {
                                                            selectedList.add(
                                                                onDealsModel[
                                                                    i]);
                                                          }
                                                        },
                                                      );
                                                    });
                                                  },
                                                  child: SvgPicture.asset(
                                                      selectedList.contains(
                                                              onDealsModel[i])
                                                          ? icon_red_heart
                                                          : icon_white_heart)),
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              selectRatingBar(context);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 7.h),
                                              margin: EdgeInsets.all(12.r),
                                              decoration:
                                                  homeratingboxDecoration,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  // 4.5
                                                  Text("4.5",
                                                      style: TextStyle(
                                                          color: black_504f58,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.left),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SvgPicture.asset(
                                                      icon_small_rating_bar),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  Text("(25+)",
                                                      style: TextStyle(
                                                          color: grey_77879e,
                                                          fontFamily:
                                                              fontMavenProMedium,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 10.sp),
                                                      textAlign: TextAlign.left)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(12.r),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // McDonald’s
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("McDonald’s",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProProSemiBold,
                                                      fontSize: 15.sp),
                                                  textAlign: TextAlign.left),
                                              i == 1
                                                  ? SizedBox()
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            colors: [
                                                              Color(0xffff8a9e),
                                                              Color(0xfff43f5e),
                                                            ],
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50)),
                                                      child: // Frame 34548
                                                          Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 4.h),
                                                        child: Text("New",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    fontMavenProMedium,
                                                                fontSize:
                                                                    12.sp),
                                                            textAlign:
                                                                TextAlign.left),
                                                      ),
                                                    )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          // Sec 16, Dwarka, New Delhi
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Sec 16, Dwarka, New Delhi ",
                                                  style: TextStyle(
                                                      color: grey_5f6d7b,
                                                      fontFamily:
                                                          fontMavenProRegular,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12.sp),
                                                  textAlign: TextAlign.left),
                                              Container(
                                                width: 3.w,
                                                height: 3.w,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
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
                                                  textAlign: TextAlign.left),
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
                                                      fontFamily:
                                                          fontMavenProRegular,
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
                                                      fontFamily:
                                                          fontMavenProRegular,
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
                                              itemBuilder: (context, i) =>
                                                  Container(
                                                margin:
                                                    EdgeInsets.only(right: 8.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.r),
                                                    color: Color(0xfff6f6f6)),
                                                child: // Chicken
                                                    Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 4.h),
                                                  child: Text(cityList[i].title,
                                                      style: TextStyle(
                                                          color: grey_77879e,
                                                          fontFamily:
                                                              fontMavenProRegular,
                                                          fontSize: 12.sp),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              i == 1
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 7.h,
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Image.asset(
                                                  icon_blue_strip,
                                                  width: 210.w,
                                                  fit: BoxFit.fill,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: 13.w,
                                                ),
                                                SvgPicture.asset(
                                                    icon_flash_offer),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // 60% OFF- Takeaway
                                                    Text("60% OFF- Takeaway",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left),

                                                    // Pick UP Between 5:30 - 7:00pm
                                                    Text(
                                                        "Pick Up Between 9:30 - 7:00pm",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xc9ffffff),
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 10.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Image.asset(
                                                  icon_blue_strip,
                                                  width: 210.w,
                                                  fit: BoxFit.fill,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: 13.w,
                                                ),
                                                SvgPicture.asset(
                                                    icon_flash_offer),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // 60% OFF- Takeaway
                                                    Text("40% OFF- Dine In",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left),

                                                    // Pick UP Between 5:30 - 7:00pm
                                                    Text(
                                                        "Arrive Between 12:30 - 7:00pm",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xc9ffffff),
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 10.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                                alignment: Alignment.topLeft,
                                                child: Image.asset(
                                                  icon_blue_strip,
                                                  width: 210.w,
                                                  fit: BoxFit.fill,
                                                )),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                SizedBox(
                                                  width: 13.w,
                                                ),
                                                SvgPicture.asset(
                                                    icon_offer_white),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // 60% OFF- Takeaway
                                                    Text("25% OFF- Takeaway",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left),

                                                    // Pick UP Between 5:30 - 7:00pm
                                                    Text("Anytime Today",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xc9ffffff),
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 10.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    )
                  : Wrap(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                            top: 4.h,
                          ),
                          itemCount: onDealsModel.length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              Navigator.pop(context, false);
                              selectRestaurantOffer(context);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 16.h, left: 6.w),
                                  decoration: cardboxDecoration,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.r),
                                                topRight: Radius.circular(10.r),
                                              ),
                                              child: Image.asset(
                                                onDealsModel[i].title,
                                                width: double.infinity,
                                                height: 168.h,
                                                fit: BoxFit.fill,
                                              )),
                                          Positioned(
                                              bottom: 110,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        setState(
                                                          () {
                                                            if (selectedList
                                                                .contains(
                                                                    onDealsModel[
                                                                        i])) {
                                                              selectedList.remove(
                                                                  onDealsModel[
                                                                      i]);
                                                            } else {
                                                              selectedList.add(
                                                                  onDealsModel[
                                                                      i]);
                                                            }
                                                          },
                                                        );
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                        selectedList.contains(
                                                                onDealsModel[i])
                                                            ? icon_red_heart
                                                            : icon_white_heart)),
                                              )),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                selectRatingBar(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 7.h),
                                                margin: EdgeInsets.all(12.r),
                                                decoration:
                                                    homeratingboxDecoration,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // 4.5
                                                    Text("4.5",
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    SvgPicture.asset(
                                                        icon_small_rating_bar),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text("(25+)",
                                                        style: TextStyle(
                                                            color: grey_77879e,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 10.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(12.r),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // McDonald’s
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("McDonald’s",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProProSemiBold,
                                                        fontSize: 15.sp),
                                                    textAlign: TextAlign.left),
                                                i == 1
                                                    ? SizedBox()
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                gradient:
                                                                    const LinearGradient(
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                  colors: [
                                                                    Color(
                                                                        0xffff8a9e),
                                                                    Color(
                                                                        0xfff43f5e),
                                                                  ],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50)),
                                                        child: // Frame 34548
                                                            Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
                                                                  vertical:
                                                                      4.h),
                                                          child: Text("New",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMavenProMedium,
                                                                  fontSize:
                                                                      12.sp),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ),
                                                      )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.h,
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
                                                    textAlign: TextAlign.left),
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
                                                    textAlign: TextAlign.left),
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
                                                        fontFamily:
                                                            fontMavenProRegular,
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
                                                        fontFamily:
                                                            fontMavenProRegular,
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: cityList.length,
                                                itemBuilder: (context, i) =>
                                                    Container(
                                                  margin: EdgeInsets.only(
                                                      right: 8.w),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                      color: Color(0xfff6f6f6)),
                                                  child: // Chicken
                                                      Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6.w,
                                                            vertical: 4.h),
                                                    child: Text(
                                                        cityList[i].title,
                                                        style: TextStyle(
                                                            color: grey_77879e,
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                i == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 7.h,
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset(
                                                    icon_blue_strip,
                                                    width: 210.w,
                                                    fit: BoxFit.fill,
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    width: 13.w,
                                                  ),
                                                  SvgPicture.asset(
                                                      icon_flash_offer),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // 60% OFF- Takeaway
                                                      Text("60% OFF- Takeaway",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.left),

                                                      // Pick UP Between 5:30 - 7:00pm
                                                      Text(
                                                          "Pick Up Between 9:30 - 7:00pm",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xc9ffffff),
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 10.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset(
                                                    icon_blue_strip,
                                                    width: 210.w,
                                                    fit: BoxFit.fill,
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    width: 13.w,
                                                  ),
                                                  SvgPicture.asset(
                                                      icon_flash_offer),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // 60% OFF- Takeaway
                                                      Text("40% OFF- Dine In",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.left),

                                                      // Pick UP Between 5:30 - 7:00pm
                                                      Text(
                                                          "Arrive Between 12:30 - 7:00pm",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xc9ffffff),
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 10.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Image.asset(
                                                    icon_blue_strip,
                                                    width: 210.w,
                                                    fit: BoxFit.fill,
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  SizedBox(
                                                    width: 13.w,
                                                  ),
                                                  SvgPicture.asset(
                                                      icon_offer_white),
                                                  SizedBox(
                                                    width: 4.w,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // 60% OFF- Takeaway
                                                      Text("25% OFF- Takeaway",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontSize: 12.sp),
                                                          textAlign:
                                                              TextAlign.left),

                                                      // Pick UP Between 5:30 - 7:00pm
                                                      Text("Anytime Today",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xc9ffffff),
                                                              fontFamily:
                                                                  fontMavenProRegular,
                                                              fontSize: 10.sp),
                                                          textAlign:
                                                              TextAlign.left)
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ],
    );
  }
}

void selectRestaurantOffer(BuildContext context) {
  List<CityListModel> cityList = [
    CityListModel("Burger"),
    CityListModel("Chicken"),
    CityListModel("Fast Food"),
  ];
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      context: context,
      builder: (
        BuildContext context,
      ) {
        return Container(
            padding: EdgeInsets.only(top: 80.h),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.r),
                  topRight: Radius.circular(13.r),
                )),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  )),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                    width: 71,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: grey_d9dde3)),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context, false);
                                      },
                                      child: SvgPicture.asset(icon_arrow_left)),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: grey_d9dde3),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 5.h),
                                    child: // View Restaurant
                                        Text("View Restaurant",
                                            style: TextStyle(
                                                color: red_dc3642,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 15.sp),
                                            textAlign: TextAlign.left),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: const [BottomSheetRestaurantOffer()],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      });
}
