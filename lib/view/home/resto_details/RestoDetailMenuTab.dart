import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:dotted_line/dotted_line.dart';
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

class RestoDetailMenuTab extends StatefulWidget {
  const RestoDetailMenuTab({Key? key}) : super(key: key);

  @override
  State<RestoDetailMenuTab> createState() => _RestoDetailMenuTabState();
}

class _RestoDetailMenuTabState extends State<RestoDetailMenuTab> {
  final List<League> data = <League>[
    League(
      'Starters',
      <Club>[
        Club(icon_veg_second, "Bloddy Mary", 0),
        Club(icon_non_veg_second, "Chicken Tikka", 0),
      ],
      false,
    ),
    League(
        'Burrito Stars',
        <Club>[
          Club(icon_veg_second, "Bloddy Mary", 0),
          Club(icon_non_veg_second, "Chicken Tikka", 0),
        ],
        false),
    League(
        'Main Course',
        <Club>[
          Club(icon_veg_second, "Bloddy Mary", 0),
          Club(icon_non_veg_second, "Chicken Tikka", 0),
        ],
        false),
    League(
        'Fast Food',
        <Club>[
          Club(icon_veg_second, "Bloddy Mary", 0),
          Club(icon_non_veg_second, "Chicken Tikka", 0),
        ],
        false),
  ];

  bool isCounter = false;
  var isExpanded = false;

  late FocusNode focusNode;
  late FocusNode focusedItem;

  void initState() {
    focusNode = new FocusNode();

    // listen to focus changes
    focusNode.addListener(
        () => print('focusNode updated: hasFocus: ${focusNode.hasFocus}'));
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  // bool _isExpanded = false;
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
        resizeToAvoidBottomInset: true,
        backgroundColor: white_ffffff,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 20.h,
              ),

              Container(
                margin: EdgeInsets.only(right: 16.w, left: 16.w),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Color(0xfffcfcfd),
                    border: Border.all(width: 1, color: grey_d9dde3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      icon_search,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        enabled: true,
                        onChanged: (value) {
                          () {};
                        },
                        onSubmitted: (value) {
                          () {};
                        },
                        autofocus: false,
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProMedium,
                            fontSize: 15.sp),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Search",
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
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w),
              //   child: SearchBar(
              //     hintText: strSearch,
              //     onSubmitted: (String) {},
              //     onChanged: (String) {},
              //   ),
              // ),
              SizedBox(
                height: 10.h,
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(0.r),
                itemBuilder: (BuildContext context, int index) => data[index]
                        .listClubs
                        .isNotEmpty
                    ? Column(
                        children: [
                          Theme(
                            data: Theme.of(context)
                                .copyWith(dividerColor: Colors.transparent),
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
                                trailing: AnimatedRotation(

                                    /// you can use different widget for animation
                                    turns: data[index].isExpandArrow ? .5 : 0,
                                    duration: const Duration(milliseconds: 1),
                                    child: SvgPicture.asset(
                                        icon_down_arrow_expand) // your svgImage here
                                    ),

                                // trailing: Icon(
                                //   Icons.keyboard_arrow_down,
                                //   color: Colors.green,
                                // ),

                                key: PageStorageKey<League>(data[index]),
                                tilePadding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 0.h),
                                title: Text(data[index].TvTitle,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: fontOverpassBold,
                                        color: black_504f58)),
                                children:
                                    data[index].listClubs.asMap().entries.map(
                                  (pos) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w),
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
                                                          MainAxisSize.max,
                                                      children: [
                                                        SvgPicture.asset(
                                                          data[index]
                                                              .listClubs[
                                                                  pos.key]
                                                              .icon,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  data[index]
                                                                      .listClubs[pos
                                                                          .key]
                                                                      .tvLable,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontFamily:
                                                                          fontMavenProMedium,
                                                                      color:
                                                                          black_504f58)),
                                                              SizedBox(
                                                                height: 6.h,
                                                              ),
                                                              Text(
                                                                  "Crunchy corn chips topped ",
                                                                  style: TextStyle(
                                                                      color:
                                                                          grey_5f6d7b,
                                                                      fontFamily:
                                                                          fontMavenProRegular,
                                                                      fontSize: 12
                                                                          .sp),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        Row(
                                                          children: [
                                                            Image.asset(
                                                              icon_rupee_slim,
                                                              width: 10.w,
                                                              height: 10.h,
                                                              color:
                                                                  grey_77879e,
                                                            ),
                                                            Text(
                                                              "300",
                                                              style: TextStyle(
                                                                color:
                                                                    grey_77879e,
                                                                fontFamily:
                                                                    fontMavenProMedium,
                                                                fontSize: 12.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.w,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  icon_rupee_slim,
                                                                  width: 10.w,
                                                                  height: 10.h,
                                                                  color:
                                                                      green_5cb85c,
                                                                ),
                                                                Text("250",
                                                                    style: TextStyle(
                                                                        color:
                                                                            green_5cb85c,
                                                                        fontFamily:
                                                                            fontMavenProProSemiBold,
                                                                        fontSize: 15
                                                                            .sp),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right)
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        //    club==1?SizedBox():SvgPicture.asset(icon_check_filled,width: 20.w,height: 20.h,)
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        data[index]
                                                                        .listClubs
                                                                        .length -
                                                                    1 !=
                                                                pos.key
                                                            ? Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: 34
                                                                            .w),
                                                                    child:
                                                                        const DottedLine(
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      lineLength:
                                                                          double
                                                                              .infinity,
                                                                      lineThickness:
                                                                          1.0,
                                                                      dashLength:
                                                                          2.0,
                                                                      dashColor:
                                                                          divider_d9dde3,
                                                                      dashRadius:
                                                                          0.0,
                                                                      dashGapLength:
                                                                          2.0,
                                                                      dashGapColor:
                                                                          Colors
                                                                              .transparent,
                                                                      dashGapRadius:
                                                                          0.0,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                                        data[index]
                                                                        .listClubs
                                                                        .length -
                                                                    1 !=
                                                                pos.key
                                                            ? SizedBox(
                                                                height: 16,
                                                              )
                                                            : SizedBox(
                                                                height: 4)
                                                      ],
                                                    )
                                                  ],
                                                ),
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
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: divider_d9dde3,
                          ),
                        ],
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
  String icon;
  String tvLable;

  Club(this.icon, this.tvLable, this.count);
}
