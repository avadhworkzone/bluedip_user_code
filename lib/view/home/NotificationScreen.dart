import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../Model/CityListModel.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../Widget/toolbar_with_title_edit.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isBottomButton = false;

  List<CityListModel> dayList = [
    CityListModel("Today"),
    CityListModel("Yesterday"),
  ];

  List<CityListModel> offerList = [
    CityListModel("Notification Title"),
    CityListModel("Notification Title"),
  ];

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
          Container(
              decoration: BoxDecoration(
                //  color: white_ffffff,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2017191a),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5),
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: ToolbarWithTitle("Notifications")),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(16.r),
                      itemCount: dayList.length,
                      itemBuilder: (context, i) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dayList[i].title.toUpperCase(),
                              style: TextStyle(
                                  color: grey_5f6d7b,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 16.h,
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            primary: false,
                            shrinkWrap: true,
                            itemCount: offerList.length,
                            itemBuilder: (context, i) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    i == 1
                                        ? SizedBox()
                                        : Container(
                                            width: 7,
                                            height: 7,
                                            decoration: const BoxDecoration(
                                                color: red_dc3642,
                                                shape: BoxShape.circle),
                                          ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    // Notification Title
                                    Expanded(
                                      flex: 1,
                                      child: Text("Notification Title",
                                          style: TextStyle(
                                              color: black_504f58,
                                              fontFamily: fontMavenProBold,
                                              fontSize: 16.sp),
                                          textAlign: TextAlign.left),
                                    ),
                                    // 12:25 am
                                    Text("12:25 am",
                                        style: TextStyle(
                                            color: grey_969da8,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: fontMavenProRegular,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.sp),
                                        textAlign: TextAlign.right)
                                  ],
                                ),
                                SizedBox(
                                  height: 9.h,
                                ),
                                // Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                                Text(
                                    "Lorem Ipsum is simply dummy text of the \nprinting and typesetting industry.",
                                    style: TextStyle(
                                        color: black_504f58,
                                        fontFamily: fontMavenProRegular,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.sp),
                                    textAlign: TextAlign.left),
                                SizedBox(
                                  height: 16.h,
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: divider_d4dce7,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
