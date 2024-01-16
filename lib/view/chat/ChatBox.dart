import 'dart:async';

import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:bluedip_user/Styles/my_icons.dart';
import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
import 'package:bluedip_user/Widget/toolbar_chat.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:readmore/readmore.dart';

import '../../Styles/my_strings.dart';
import '../../Widget/common_border_button.dart';
import '../../Widget/common_red_button.dart';
import '../bottomsheets/BottomSheetDelete.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: white_ffffff, // status bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.light, //navigation bar icons' color
    ));
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarColor: Colors.white, // status bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: white_ffffff,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1017191a),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5),
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h, left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context, false),
                        child: Container(
                            width: 40.w,
                            height: 40.w,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(icon_arrow_left),
                            ))),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 38.w,
                      height: 38.h,
                      child: CircleAvatar(
                        radius: 50,
                        child: Image.asset(
                          img_girl,
                          width: 38.w,
                          height: 38.h,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chat",
                            style: TextStyle(
                                fontFamily: fontMavenProProSemiBold,
                                color: black_504f58,
                                fontSize: 15.sp),
                          ),
                          // Online
                          Text("Online",
                              style: TextStyle(
                                  color: green_5cb85c,
                                  fontFamily: fontMavenProMedium,
                                  fontSize: 12.sp),
                              textAlign: TextAlign.left)
                        ],
                      ),
                    ),
                    PopupMenuButton(
                        offset: const Offset(-10, 15),
                        enabled: true,
                        onSelected: (result) {
                          if (result == 0) {
                            selectReport(context);
                          } else if (result == 1) {
                            selectBlockUser(context);
                          }
                        },
                        shadowColor: Color(0x60d3d1d8),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                height: 30,
                                value: 0,
                                onTap: () {},
                                child: // Edit
                                    Text("Report",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.left),
                              ),
                              PopupMenuItem(
                                value: 1,
                                height: 30,
                                child: // Edit
                                    Text("Block",
                                        style: TextStyle(
                                            color: red_dc3642,
                                            fontFamily: fontMavenProMedium,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.left),
                              ),
                            ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        child: SvgPicture.asset(
                          icon_menu,
                          color: grey_5f6d7b,
                          width: 24.w,
                          height: 24.h,
                        )),
                    SizedBox(
                      width: 12.w,
                    ),
                  ],
                ),
              ),
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
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                                color: bg_fafbfb),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 8.h),
                            child: Text("20 December 2021",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontMavenProMedium,
                                    fontSize: 12.sp),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),

                        /*Receiver Layout*/
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("You",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.right),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(0.r),
                                          topLeft: Radius.circular(8.r),
                                          bottomRight: Radius.circular(8.r),
                                          bottomLeft: Radius.circular(8.r),
                                        ),
                                        color: blue_007add),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    child: // Hi , How are u today?
                                        Text("Hi , How are u  today?",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: fontMavenProMedium,
                                                fontSize: 14.sp),
                                            textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              SizedBox(
                                width: 34.w,
                                height: 34.h,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    img_girl1,
                                    width: 34.w,
                                    height: 34.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        /*Sender Layout*/
                        Padding(
                          padding: EdgeInsets.only(right: 50.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 34.w,
                                height: 34.h,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    img_girl,
                                    width: 34.w,
                                    height: 34.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jenny doe",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.right),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.r),
                                          topLeft: Radius.circular(0.r),
                                          bottomRight: Radius.circular(8.r),
                                          bottomLeft: Radius.circular(8.r),
                                        ),
                                        color: Color(0xfff9f9f9)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    child: // Hi , How are u today?
                                        Text(
                                            "I’m doing well. Is it anything that \nI can help with?",
                                            style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp,
                                            ),
                                            textAlign: TextAlign.left),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        /*Sender Layout*/
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 34.w,
                              height: 34.h,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  img_girl,
                                  width: 34.w,
                                  height: 34.h,
                                  fit: BoxFit.fill,
                                ),
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
                                  Text("Jenny doe",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.right),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        width: 1,
                                        color: grey_d9dde3,
                                        //   strokeAlign:StrokeAlign.inside
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 20.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 12.h),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 37.w,
                                                height: 37.h,
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Image.asset(
                                                    img_men,
                                                    width: 37.w,
                                                    height: 37.h,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6.w,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // John Doe
                                                    Text("John Doe",
                                                        style: TextStyle(
                                                            color: black_504f58,
                                                            fontFamily:
                                                                fontMavenProBold,
                                                            fontSize: 14.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Text(
                                                        "New Delhi, 31.11.2022",
                                                        style: TextStyle(
                                                            color: grey_5f6d7b,
                                                            fontFamily:
                                                                fontMavenProRegular,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 7.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xff276fe9),
                                                        Color(0xff568aef),
                                                      ],
                                                    )),
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      icon_notifcation_food_buddy,
                                                      color: white_ffffff,
                                                      width: 16.w,
                                                      height: 16.h,
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    // Chat
                                                    Text("Chat",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontSize: 12.sp),
                                                        textAlign:
                                                            TextAlign.left)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Image.asset(
                                              img_pizza_food_buddy,
                                              width: double.infinity,
                                              height: 168.h,
                                              fit: BoxFit.fill,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12.r),
                                              child: SvgPicture.asset(
                                                  icon_share_post),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 12.w,
                                              right: 12.w,
                                              top: 12.h,
                                              bottom: 16.h),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Let’s eat hungers
                                              Text("Let’s eat hungers",
                                                  style: TextStyle(
                                                      color: black_504f58,
                                                      fontFamily:
                                                          fontMavenProBold,
                                                      fontSize: 14.sp),
                                                  textAlign: TextAlign.left),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              // Username Lorem ipsum dolor sit ametconsectetur adipiscing elit, sed do eiusmod tempor...more
                                              ReadMoreText(
                                                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                                trimLines: 2,
                                                colorClickableText:
                                                    black_504f58,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: 'more',
                                                trimExpandedText: 'less',
                                                lessStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    color: blue_007add),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    color: grey_5f6d7b),
                                                moreStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontFamily:
                                                        fontMavenProRegular,
                                                    color: blue_007add),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /*Sender Layout*/
                        Padding(
                          padding: EdgeInsets.only(right: 64.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 34.w,
                                height: 34.h,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    img_girl,
                                    width: 34.w,
                                    height: 34.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jenny doe",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.right),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(8.r),
                                            topLeft: Radius.circular(0.r),
                                            bottomRight: Radius.circular(8.r),
                                            bottomLeft: Radius.circular(8.r),
                                          ),
                                          color: Color(0xfff9f9f9)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 12.h),
                                      child: // Hi , How are u today?
                                          // Typing...
                                          Text("Typing...",
                                              style: TextStyle(
                                                  color: blue_007add,
                                                  fontFamily:
                                                      fontMavenProMedium,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.left)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("You",
                                      style: TextStyle(
                                          color: black_504f58,
                                          fontFamily: fontMavenProProSemiBold,
                                          fontSize: 15.sp),
                                      textAlign: TextAlign.right),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  SizedBox(
                                    width: 34.w,
                                    height: 34.h,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        img_girl1,
                                        width: 34.w,
                                        height: 34.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                    width: 1,
                                    color: grey_d9dde3,
                                    //   strokeAlign:StrokeAlign.inside
                                  ),
                                ),
                                margin: EdgeInsets.only(right: 40.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w, vertical: 12.h),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 37.w,
                                            height: 37.h,
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Image.asset(
                                                img_men,
                                                width: 37.w,
                                                height: 37.h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // John Doe
                                                Text("John Doe",
                                                    style: TextStyle(
                                                        color: black_504f58,
                                                        fontFamily:
                                                            fontMavenProBold,
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.left),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text("New Delhi, 31.11.2022",
                                                    style: TextStyle(
                                                        color: grey_5f6d7b,
                                                        fontFamily:
                                                            fontMavenProRegular,
                                                        fontSize: 12.sp),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 7.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.r),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff276fe9),
                                                    Color(0xff568aef),
                                                  ],
                                                )),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icon_notifcation_food_buddy,
                                                  color: white_ffffff,
                                                  width: 16.w,
                                                  height: 16.h,
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                // Chat
                                                Text("Chat",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 12.sp),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Image.asset(
                                          img_pizza_food_buddy,
                                          width: double.infinity,
                                          height: 168.h,
                                          fit: BoxFit.fill,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(12.r),
                                          child:
                                              SvgPicture.asset(icon_share_post),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 12.w,
                                          right: 12.w,
                                          top: 12.h,
                                          bottom: 16.h),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Let’s eat hungers
                                          Text("Let’s eat hungers",
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily: fontMavenProBold,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.left),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          // Username Lorem ipsum dolor sit ametconsectetur adipiscing elit, sed do eiusmod tempor...more
                                          ReadMoreText(
                                            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                            trimLines: 2,
                                            colorClickableText: black_504f58,
                                            trimMode: TrimMode.Line,
                                            trimCollapsedText: 'more',
                                            trimExpandedText: 'less',
                                            lessStyle: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: fontMavenProRegular,
                                                color: blue_007add),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: fontMavenProRegular,
                                                color: grey_5f6d7b),
                                            moreStyle: TextStyle(
                                                fontSize: 12.sp,
                                                fontFamily: fontMavenProRegular,
                                                color: blue_007add),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: grey_d9dde3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        // controller: titleController,
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProRegular,
                            fontSize: 14.sp),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 21.h),
                          hintText: "Type your message here...",
                          hintStyle: TextStyle(
                              color: grey_77879e,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    Image.asset(
                      icon_blue_send,
                      width: 34.w,
                      height: 34.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void selectReport(BuildContext context) {
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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          // Daily Opportunities
                          Center(
                            child: Text("Report This Account",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontOverpassBold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.sp,
                                    height: 1.5),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          // Are you sure you would like to delete your Bluedip account?
                          Center(
                            child: Text(
                                "Are you sure you would like to report this \nBluedip account?",
                                style: TextStyle(
                                    color: grey_5f6d7b,
                                    fontFamily: fontMavenProMedium,
                                    fontStyle: FontStyle.normal,
                                    height: 1.5,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          /*bottom two buttons here*/
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: CommonBorderButton(
                                      strCancel.toUpperCase(), () {
                                    Navigator.of(context).pop(false);
                                  }, red_dc3642, Colors.transparent,
                                      red_dc3642)),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: CommonRedButton("Report".toUpperCase(),
                                      () {
                                    Navigator.of(context).pop(false);
                                  }, red_dc3642)),
                            ],
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}

void selectBlockUser(BuildContext context) {
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
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          // Daily Opportunities
                          Center(
                            child: Text("Block This Account",
                                style: TextStyle(
                                    color: black_504f58,
                                    fontFamily: fontOverpassBold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18.sp,
                                    height: 1.5),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          // Are you sure you would like to delete your Bluedip account?
                          Center(
                            child: Text(
                                "Are you sure you would like to Block this \nBluedip account?",
                                style: TextStyle(
                                    color: grey_5f6d7b,
                                    fontFamily: fontMavenProMedium,
                                    fontStyle: FontStyle.normal,
                                    height: 1.5,
                                    fontSize: 14.sp),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          /*bottom two buttons here*/
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: CommonBorderButton(
                                      strCancel.toUpperCase(), () {
                                    Navigator.of(context).pop(false);
                                  }, red_dc3642, Colors.transparent,
                                      red_dc3642)),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: CommonRedButton("Block".toUpperCase(),
                                      () {
                                    Navigator.of(context).pop(false);
                                  }, red_dc3642)),
                            ],
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}
