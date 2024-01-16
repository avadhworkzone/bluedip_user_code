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

import '../../Styles/my_strings.dart';
import '../../Widget/Textfield.dart';
import '../../Widget/back_button.dart';
import '../../Widget/card_box_shadow.dart';
import '../../Widget/green_ticket_widget.dart';
import '../../Widget/home_rating_box_shadow.dart';
import '../../Widget/search_bar.dart';
import '../../Widget/toolbar_with_title.dart';
import '../../Widget/toolbar_with_title_shadow.dart';
import '../profile/ChangeMobileNumberOtp.dart';
import '../order/RedeemOtpVerified.dart';
import '../../Widget/common_red_button.dart';
import '../../Widget/common_verify_red_button.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  String selectedDay = "";
  List<String> selectedListCategory = [];
  int mySelectConsultation = -1;
  List<CityListModel> onRating = [
    CityListModel("Jenny doe"),
    CityListModel("Roy"),
    CityListModel("Erika"),
    CityListModel("Julli"),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ToolbarWithTitleShadow("Select Contact"),
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
                      SearchBarWidget(
                        hintText: strSearch,
                        onSubmitted: (String) {},
                        onChanged: (String) {},
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: onRating.length,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedListCategory
                                  .contains(onRating[i].title)) {
                                selectedListCategory.remove(onRating[i].title);
                              } else {
                                selectedListCategory.add(onRating[i].title);
                              }
                            });
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 51.w,
                                      height: 51.h,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          img_girl,
                                          width: 51.w,
                                          height: 51.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14.w,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Jenny doe
                                          Text(onRating[i].title,
                                              style: TextStyle(
                                                  color: black_504f58,
                                                  fontFamily:
                                                      fontMavenProProSemiBold,
                                                  fontSize: 15.sp),
                                              textAlign: TextAlign.left),

                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text("Hello. how are you?",
                                              style: TextStyle(
                                                  color: grey_5f6d7b,
                                                  fontFamily:
                                                      fontMavenProRegular,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                    selectedListCategory
                                            .contains(onRating[i].title)
                                        ? SvgPicture.asset(icon_checkbox_circle)
                                        : SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  height: 0.5,
                                  color: divider_d4dce7,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                child: SizedBox(
                  width: 200.w,
                  child: CommonRedButton("Share".toUpperCase(), () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const ChangeMobileNumberOtp(),
                    //     ));
                  }, red_dc3642),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
