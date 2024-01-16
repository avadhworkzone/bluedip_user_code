import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Styles/my_strings.dart';
import '../Widget/Textfield.dart';
import '../Widget/back_button.dart';
import '../Widget/green_ticket_widget.dart';
import '../Widget/search_bar.dart';
import '../Widget/toolbar_with_title.dart';
import '../Widget/toolbar_with_title_shadow.dart';
import 'order/RedeemOtpVerified.dart';
import '../Widget/common_red_button.dart';
import '../Widget/common_verify_red_button.dart';

class DineInRedeemOffer extends StatefulWidget {
  const DineInRedeemOffer({Key? key}) : super(key: key);

  @override
  State<DineInRedeemOffer> createState() => _DineInRedeemOfferState();
}

class _DineInRedeemOfferState extends State<DineInRedeemOffer> {
  final List<League> data = <League>[
    League(
        'How to redeem',
        <Club>[
          Club(
              icon_diamond,
              "Enter your details below and hit redeem to receive your voucher",
              0),
          Club(
              icon_diamond,
              "Arrive at the venue at the booking time and show your voucher on arrival",
              0),
          Club(
              icon_diamond,
              "The restaurant will deduct the% from the total bill at the end of your meal",
              0),
        ],
        false),
  ];

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _specialReqController = TextEditingController();
  final _guestController = TextEditingController();
  String starttime = "10 : 15 AM";
  // String? selectedTimeSlot;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTimeSecond = TimeOfDay.now();

  Duration duration = const Duration(hours: 1, minutes: 00);

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleShadow("Redeem Offer"),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GreenTicketWidget(
                              title: '40%',
                              subtitle: 'Valid Anytime Today',
                              type: "Dine-In"),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: divider_d4dce7,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0.r),
                      itemBuilder: (BuildContext context, int index) => data[
                                  index]
                              .listClubs
                              .isNotEmpty
                          ? Column(
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
                                          duration:
                                              const Duration(milliseconds: 1),
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
                                      children: data[index]
                                          .listClubs
                                          .asMap()
                                          .entries
                                          .map(
                                        (pos) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:
                                                                          10.h),
                                                              child: SvgPicture
                                                                  .asset(
                                                                data[index]
                                                                    .listClubs[
                                                                        pos.key]
                                                                    .icon,
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
                                                                      fontSize:
                                                                          14.sp,
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
                                                        data[index]
                                                                        .listClubs
                                                                        .length -
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 30.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(strFullName,
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 6.h,
                          ),
                          loginTextformField(
                            "Enter your full name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _nameController,
                            obscureText: true,
                            onChanged: (value) {},
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          // Title
                          Text("Mobile Number",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          SizedBox(
                            height: 6.h,
                          ),
                          loginTextformField(
                            "Enter your mobile number",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _mobileController,
                            obscureText: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          // Title
                          Text("Number of Guests",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          SizedBox(
                            height: 6.h,
                          ),
                          loginTextformField(
                            "Enter number of guest",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _guestController,
                            obscureText: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          // Title
                          Text("Select Booking Time",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          SizedBox(
                            height: 6.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              selectTimePicker(context);
                              // setState(() {
                              //   _selectTime(context);
                              // });
                            },
                            child: Container(
                              padding: EdgeInsets.all(14.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.r),
                                border:
                                    Border.all(color: grey_d9dde3, width: 1),
                              ),
                              child: // Detail
                                  Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(starttime,
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.sp,
                                            overflow: TextOverflow.ellipsis),
                                        textAlign: TextAlign.left),
                                  ),
                                  SvgPicture.asset(icon_clock_time_grey)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text("Special Request",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),

                          SizedBox(
                            height: 6.h,
                          ),
                          loginTextformField(
                            "If you have any special request",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: _specialReqController,
                            obscureText: true,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            height: 40.h,
                          ),

                          CommonRedButton("Continue To Order".toUpperCase(),
                              () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => RedeemOtpVerified(
                            //         id: 0,
                            //       ),
                            //     ));
                          }, red_dc3642),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectTimePicker(BuildContext context) {
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
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Daily Opportunities
                                  // Title
                                  Center(
                                    child: Text("Select Time",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProBold,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.center),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            SizedBox(
                              height: 180.h,
                              child: CupertinoDatePicker(
                                //  initialDateTime: starttime,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: false,
                                // This is called when the user changes the time.
                                onDateTimeChanged: (DateTime newTime) {
                                  DateTime dateTime =
                                      DateTime.parse(newTime.toString());
                                  String yourDateTime =
                                      DateFormat('h:mm a').format(dateTime);
                                  setState(() => starttime = yourDateTime);
                                },
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: divider_d4dce7,
                            ),

                            // Cancel
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, false);
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text("Confirm".toUpperCase(),
                                        style: TextStyle(
                                            color: Blue_5468ff,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: fontMavenProMedium,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 15.sp),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: // Cancel
                            Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("Cancel".toUpperCase(),
                              style: TextStyle(
                                  color: blue_3653f6,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.center),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
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
