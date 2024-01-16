import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';

class GreenTicketWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String type;
  GreenTicketWidget(
      {required this.title, required this.subtitle, required this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 136.h,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/img_ticket_green_png.png",
            ),
          )),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 20.h),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 20% OFF
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                    color: green_5cb85c,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: fontOverpassBold,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 35.sp),
                                text: title),
                            TextSpan(
                                style: TextStyle(
                                    color: green_5cb85c,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: fontMavenProRegular,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 15.sp),
                                text: "\nOFF")
                          ])),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(type.toUpperCase(),
                              style: TextStyle(
                                  color: red_dc3642,
                                  fontFamily: fontMavenProMedium,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left)
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pizza Hut
                          Text("Pizza Hut",
                              style: TextStyle(
                                  color: black_504f58,
                                  fontFamily: fontOverpassBold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text("5 Deals Left",
                              style: TextStyle(
                                  color: red_dc3642,
                                  fontFamily: fontMavenProProSemiBold,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp),
                              textAlign: TextAlign.left),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text("The Total Order Incl.Drinks ",
                              style: TextStyle(
                                  color: grey_77879e,
                                  fontFamily: fontMavenProRegular,
                                  fontSize: 14.sp,
                                  height: 1.5),
                              textAlign: TextAlign.left),
                          // On ₹300 Min bill Amount
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                    color: grey_77879e,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp,
                                    height: 1.5),
                                text: "On "),
                            TextSpan(
                                style: TextStyle(
                                    color: grey_504f58,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp),
                                text: "₹300 "),
                            TextSpan(
                                style: TextStyle(
                                    color: grey_77879e,
                                    fontFamily: fontMavenProRegular,
                                    fontSize: 14.sp),
                                text: "Min bill Amount")
                          ]))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        // Stack(
        //   alignment: Alignment.center,
        //   children: [
        //     SvgPicture.asset(
        //       img_ticket_green,
        //       width: MediaQuery.of(context).size.width,
        //      //height: 136.h,
        //       fit: BoxFit.fill,
        //     ),
        //     Container(
        //       margin: const EdgeInsets.all(14.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Expanded(
        //             flex:1,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 // 20% OFF
        //                 RichText(
        //                     text: TextSpan(children: [
        //                       TextSpan(
        //                           style:  TextStyle(
        //                               color: green_5cb85c,
        //                               fontWeight: FontWeight.w700,
        //                               fontFamily: fontOverpassBold,
        //                               fontStyle: FontStyle.normal,
        //                               fontSize: 35.sp),
        //                           text: title),
        //                       TextSpan(
        //                           style:  TextStyle(
        //                               color: green_5cb85c,
        //                               fontWeight: FontWeight.w400,
        //                               fontFamily: fontMavenProRegular,
        //                               fontStyle: FontStyle.normal,
        //                               fontSize: 15.sp),
        //                           text: "\nOFF")
        //                     ])),
        //                 SizedBox(height: 10.h,),
        //                 Text(
        //                     type.toUpperCase(),
        //                     style:  TextStyle(
        //                         color:  red_dc3642,
        //                         fontFamily: fontMavenProMedium,
        //                         fontStyle:  FontStyle.normal,
        //                         fontSize: 14.sp
        //                     ),
        //                     textAlign: TextAlign.left
        //                 )
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding:  EdgeInsets.only(right: 6.w),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 // Pizza Hut
        //                 Text(
        //                     "Pizza Hut",
        //                     style:  TextStyle(
        //                         color:  black_504f58,
        //                         fontFamily: fontOverpassBold,
        //                         fontStyle:  FontStyle.normal,
        //                         fontSize: 16.sp
        //                     ),
        //                     textAlign: TextAlign.left
        //                 ),
        //                 SizedBox(height: 4.h,),
        //                 Text(
        //                     "5 Deals Left",
        //                     style:  TextStyle(
        //                         color:  red_dc3642,
        //                         fontFamily: fontMavenProProSemiBold,
        //                         fontStyle:  FontStyle.normal,
        //                         fontSize: 14.sp
        //                     ),
        //                     textAlign: TextAlign.left
        //                 ),
        //                SizedBox(height: 4.h,),
        //                 Text(
        //                     "The Total Order Incl.Drinks ",
        //                     style:  TextStyle(
        //                         color:  grey_77879e,
        //                         fontFamily: fontMavenProRegular,
        //                         fontSize: 14.sp,
        //                         height: 1.5
        //                     ),
        //                     textAlign: TextAlign.left
        //                 ),
        //                 // On ₹300 Min bill Amount
        //                 RichText(
        //                     text: TextSpan(
        //                         children: [
        //                           TextSpan(
        //                               style:  TextStyle(
        //                                   color:  grey_77879e,
        //                                   fontFamily: fontMavenProRegular,
        //                                   fontSize: 14.sp,
        //                                   height: 1.5
        //                               ),
        //                               text: "On "),
        //                           TextSpan(
        //                               style:  TextStyle(
        //                                   color:  grey_504f58,
        //                                   fontFamily: fontMavenProRegular,
        //                                   fontSize: 14.sp
        //                               ),
        //                               text: "₹300 "),
        //                           TextSpan(
        //                               style:  TextStyle(
        //                                   color:  grey_77879e,
        //                                   fontFamily: fontMavenProRegular,
        //                                   fontSize: 14.sp
        //                               ),
        //                               text: "Min bill Amount")
        //                         ]
        //                     )
        //                 )
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            SvgPicture.asset(icon_clock_blue),
            SizedBox(
              width: 4.w,
            ),
            // Valid Anytime Today
            Text(subtitle,
                style: TextStyle(
                    color: blue_007add,
                    fontFamily: fontMavenProMedium,
                    fontSize: 14.sp),
                textAlign: TextAlign.left)
          ],
        ),
      ],
    );
  }
}
