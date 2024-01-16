import 'package:bluedip_user/Widget/card_box_shadow.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../Styles/my_colors.dart';
import '../Styles/my_font.dart';
import '../Styles/my_icons.dart';



class PaymentSummery extends StatefulWidget {
  const PaymentSummery({Key? key}) : super(key: key);

  @override
  State<PaymentSummery> createState() => _PaymentSummeryState();
}

class _PaymentSummeryState extends State<PaymentSummery> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: cardboxDecoration,
          padding: EdgeInsets.all(14.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Detail
              Text("Payment Summary".toUpperCase(),
                  style: TextStyle(
                      color: grey_77879e,
                      fontFamily: fontMavenProMedium,
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp),
                  textAlign: TextAlign.left),
              SizedBox(
                height: 14.h,
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Sub total",
                        style: TextStyle(
                            color: light_black_5f6d7b,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                        textAlign: TextAlign.left),
                  ),
                  Row(
                    children: [
                      Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,),
                      Text(
                          "300",
                          style:  TextStyle(
                              color:  black_504f58,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 14.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text("GST (5%)",
                            style: TextStyle(
                                color: light_black_5f6d7b,
                                fontWeight: FontWeight.w500,
                                fontFamily: fontMavenProMedium,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp),
                            textAlign: TextAlign.left),
                        SizedBox(width: 4.w,),
                        PopupMenuButton(
                            padding: EdgeInsets.all(0.0),
                            offset: const Offset(15, -80),
                            tooltip: "",
                            shadowColor: Color(0x60d3d1d8),
                            constraints:  new BoxConstraints(
                              maxHeight: 105.0,
                              maxWidth: 105.0,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                enabled: false,
                                  value: 1,
                                  height: 30,
                                  child:// Edit
                                  // CGST(2.5%)
                                  Text(
                                      "CGST(2.5%)",
                                      style:  TextStyle(
                                          color:  light_black_5f6d7b,
                                          fontFamily: fontMavenProMedium,

                                          fontSize: 12.sp
                                      ),
                                      textAlign: TextAlign.left
                                  )
                              ),
                              PopupMenuItem(
                                  enabled: false,
                                  value: 2,
                                  height: 30,
                                  child:// Edit
                                  Text(
                                      "SGST(2.5%)",
                                      style:  TextStyle(
                                          color:  light_black_5f6d7b,
                                          fontFamily: fontMavenProMedium,

                                          fontSize: 12.sp
                                      ),
                                      textAlign: TextAlign.left
                                  )
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                            child: SvgPicture.asset(icon_info_cirlce))
                      ],
                    ),
                  ),
                  // 250
                  Row(
                    children: [
                      Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,),
                      Text(
                          "15",
                          style:  TextStyle(
                              color:  black_504f58,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 14.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Packing Charges",
                        style: TextStyle(
                            color: light_black_5f6d7b,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                        textAlign: TextAlign.left),
                  ),
                  // 250
                  Row(
                    children: [
                      Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,),
                      Text(
                          "35",
                          style:  TextStyle(
                              color:  black_504f58,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 14.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 14.h,
              ),
              const DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: divider_d4dce7,
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              ),
              SizedBox(
                height: 14.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Grand Total",
                        style: TextStyle(
                            color: light_black_5f6d7b,
                            fontWeight: FontWeight.w500,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                        textAlign: TextAlign.left),
                  ),
                  // 250
                  Row(
                    children: [
                      Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,),
                      Text(
                          "350",
                          style:  TextStyle(
                              color:  black_504f58,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 14.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ],
              ),

              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Coupon Discount",
                        style: TextStyle(
                            color: green_5cb85c,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                        textAlign: TextAlign.left),
                  ),
                  // 250
                  Row(
                    children: [
                      Text(
                        "-",
                        style:  TextStyle(
                            color:  green_5cb85c,
                            fontFamily: fontMavenProProSemiBold,
                            fontSize: 14.sp
                        ),
                        textAlign: TextAlign.left
                    ),
                      Image.asset(icon_rupee_slim,width: 10.w,height: 10.h,color: green_5cb85c,),
                      Text(
                          "50",
                          style:  TextStyle(
                              color:  green_5cb85c,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 14.sp
                          ),
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text("Net Payable",
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProProSemiBold,
                            fontStyle: FontStyle.normal,
                            fontSize: 15.sp),
                        textAlign: TextAlign.left),
                  ),
                  // Paid
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w,vertical: 2.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Color(0x215cb85c)
                    ),
                    child: Text("PAID",
                        style: TextStyle(
                            color: green_5cb85c,
                            fontFamily: fontMavenProMedium,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp),
                        textAlign: TextAlign.right),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  // 250
                  Row(
                    children: [
                      Image.asset(icon_rupee_slim,width: 12.w,height: 12.h,),
                      Text(
                          "250",
                          style:  TextStyle(
                              color:  black_504f58,
                              fontFamily: fontMavenProProSemiBold,
                              fontSize: 15.sp
                          ),
                          textAlign: TextAlign.left
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
