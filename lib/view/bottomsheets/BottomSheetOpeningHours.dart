import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Model/HoursModel.dart';
import '../../Styles/my_colors.dart';
import '../../Styles/my_font.dart';
import '../../Styles/my_icons.dart';

class BottomSheetOpeningHours extends StatefulWidget {
  const BottomSheetOpeningHours({Key? key}) : super(key: key);

  @override
  State<BottomSheetOpeningHours> createState() =>
      _BottomSheetOpeningHoursState();
}

class _BottomSheetOpeningHoursState extends State<BottomSheetOpeningHours> {
  List<HoursModel> hoursList = [
    HoursModel("Sunday", "10:00 AM - 11:00 PM"),
    HoursModel("Monday", "Closed"),
    HoursModel("Tuesday", "10:00 AM - 11:00 PM"),
    HoursModel("Wednesday", "10:00 AM - 11:00 PM"),
    HoursModel("Thursday", "10:00 AM - 11:00 PM"),
    HoursModel("Friday", "10:00 AM - 11:00 PM"),
    HoursModel("Saturday", "10:00 AM - 11:00 PM"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Opportunities
              // Title
              Center(
                child: Text("Opening Hours",
                    style: TextStyle(
                        color: black_504f58,
                        fontFamily: fontMavenProBold,
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp),
                    textAlign: TextAlign.center),
              ),

              SizedBox(
                height: 24.h,
              ),

              const Divider(
                height: 1,
                thickness: 1,
                color: divider_d4dce7,
              ),

              ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                itemCount: hoursList.length,
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.only(bottom: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sunday
                      Text(hoursList[i].day,
                          style: TextStyle(
                              color: grey_5f6d7b,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          textAlign: TextAlign.left),

                      // 10:00 AM - 11:00 PM
                      Text(hoursList[i].time,
                          style: TextStyle(
                              color: grey_504f58,
                              fontFamily: fontMavenProRegular,
                              fontSize: 14.sp),
                          textAlign: TextAlign.right)
                    ],
                  ),
                ),
              )

              // ListView.builder(
              //   scrollDirection: Axis.vertical,
              //   primary: false,
              //   shrinkWrap: true,
              //   padding: EdgeInsets.only(top: 10,),
              //   itemCount: offerList.length,
              //   itemBuilder: (context, i) =>   GestureDetector(
              //     onTap: () {
              //       setState(() {
              //         mySelectConsultation = i;
              //         if(i==2){
              //           isReasonLayout = true;
              //         }else{
              //           isReasonLayout = false;
              //         }
              //       });
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 16,top: 11,bottom: 11),
              //       child: Container(
              //         color: Colors.white,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             SvgPicture.asset(mySelectConsultation ==i ?icon_selected_radio:icon_unselected_radio),
              //             SizedBox(width: 12.w,),
              //             // Value Selected
              //             Text(
              //                 offerList[i].title,
              //                 style:  TextStyle(
              //                     color:  black_354356,
              //                     fontWeight: FontWeight.w500,
              //                     fontFamily: fontMavenProMedium,
              //                     fontStyle:  FontStyle.normal,
              //                     fontSize: 15.sp
              //                 ),
              //                 textAlign: TextAlign.left
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   )
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
