import 'package:bluedip_user/Model/CityListModel.dart';
import 'package:bluedip_user/Styles/my_colors.dart';
import 'package:bluedip_user/Styles/my_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Styles/my_icons.dart';
import '../Styles/my_strings.dart';
import '../Widget/box_shadow_ticket.dart';
import '../Widget/box_shadow_ticket_second.dart';
import '../Widget/search_bar.dart';
import 'dine_in/RedeemDineInBookingDetail.dart';

class OrderHistoryDineinTab extends StatefulWidget {
  const OrderHistoryDineinTab({Key? key}) : super(key: key);

  @override
  State<OrderHistoryDineinTab> createState() => _OrderHistoryDineinTabState();
}

class _OrderHistoryDineinTabState extends State<OrderHistoryDineinTab> {
  List<CityListModel> dayList = [
    CityListModel("20% OFF"),
    CityListModel("20% OFF"),
  ];
  List<CityListModel> typeList = [
    CityListModel("Completed"),
    CityListModel("Cancelled"),
  ];

  bool isOrderListLayout = false;
  bool isNoOrderLayout = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg_fafbfb,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(
                hintText: strSearch,
                onSubmitted: (String) {},
                onChanged: (String) {},
              ),
              Visibility(
                visible: isNoOrderLayout,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isNoOrderLayout = false;
                      isOrderListLayout = true;
                    });
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Image.asset(
                          img_no_orders,
                          width: 170.w,
                          height: 152.h,
                          fit: BoxFit.fill,
                        )),
                        SizedBox(
                          height: 30.h,
                        ),
                        // No Orders
                        Text("No Orders",
                            style: TextStyle(
                                color: black_504f58,
                                fontFamily: fontMavenProBold,
                                fontSize: 16.sp),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: 10.h,
                        ),
                        // You don’t have any orders in your history
                        Text("You don’t have any orders in your history ",
                            style: TextStyle(
                                color: grey_77879e,
                                fontFamily: fontMavenProRegular,
                                fontSize: 12.sp),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isOrderListLayout,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    // Active Orders
                    Text("Active Booking",
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProBold,
                            fontSize: 16.sp),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 16.h,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: dayList.length,
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(bottom: 16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: boxDecorationTicket,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 14.w,
                                    right: 14.w,
                                    top: 14.h,
                                    bottom: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 20% OFF
                                    Text(dayList[i].title,
                                        style: TextStyle(
                                            color: red_dc3642,
                                            fontFamily: fontOverpassBold,
                                            fontSize: 18.sp),
                                        textAlign: TextAlign.left),

                                    // Offer valid between 12:30 - 7:00pm
                                    Text("Offer valid between \n12:30 - 7:00pm",
                                        style: TextStyle(
                                            color: black_504f58,
                                            fontFamily: fontMavenProRegular,
                                            fontSize: 12.sp,
                                            height: 1.5),
                                        textAlign: TextAlign.right)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(16.r),
                                              bottomRight:
                                                  Radius.circular(16.r)),
                                          color: bg_fafbfb),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        10)
                                                    .floor(),
                                                (index) => const SizedBox(
                                                      height: 1,
                                                      width: 4,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                divider_d9dde3),
                                                      ),
                                                    )));
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              bottomLeft:
                                                  Radius.circular(16.r)),
                                          color: bg_fafbfb),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: boxDecorationTicketSecond,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.h,
                                        left: 14.w,
                                        right: 14.w,
                                        bottom: 14.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.asset(
                                              img_ice_cream,
                                              width: 86.w,
                                              height: 86.h,
                                              fit: BoxFit.fill,
                                            )),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Heaven’s Food
                                            Text("Heaven’s Food",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProProSemiBold,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icon_location_pin_account,
                                                  width: 16.w,
                                                  height: 16.h,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text("Chanakyapuri, New Delhi",
                                                    style: TextStyle(
                                                        color: grey_77879e,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RedeemDineInBookingDetail(),
                                                    ));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: grey_d9dde3),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 4.h),
                                                child: // Track Order
                                                    Text("View Voucher",
                                                        style: TextStyle(
                                                            color: blue_007add,
                                                            fontFamily:
                                                                fontMavenProMedium,
                                                            fontSize: 14.sp),
                                                        textAlign:
                                                            TextAlign.left),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),

                    // Active Orders
                    Text("Previous Booking",
                        style: TextStyle(
                            color: black_504f58,
                            fontFamily: fontMavenProBold,
                            fontSize: 16.sp),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 16.h,
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: typeList.length,
                      itemBuilder: (context, i) => Padding(
                        padding: EdgeInsets.only(bottom: 16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: boxDecorationTicket,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 14.w,
                                    right: 14.w,
                                    top: 14.h,
                                    bottom: 5.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 20% OFF
                                    Text("20% OFF",
                                        style: TextStyle(
                                            color: red_dc3642,
                                            fontFamily: fontOverpassBold,
                                            fontSize: 18.sp),
                                        textAlign: TextAlign.left),

                                    // Completed
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6.r),
                                          color: i == 0
                                              ? green_5cb85c
                                              : red_dc3642),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 4.h),
                                      child: Text(typeList[i].title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: fontMavenProMedium,
                                              fontSize: 14.sp),
                                          textAlign: TextAlign.left),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(16.r),
                                              bottomRight:
                                                  Radius.circular(16.r)),
                                          color: bg_fafbfb),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return Flex(
                                            direction: Axis.horizontal,
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: List.generate(
                                                (constraints.constrainWidth() /
                                                        10)
                                                    .floor(),
                                                (index) => const SizedBox(
                                                      height: 1,
                                                      width: 5,
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                divider_d9dde3),
                                                      ),
                                                    )));
                                      }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                    width: 15.w,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.r),
                                              bottomLeft:
                                                  Radius.circular(16.r)),
                                          color: bg_fafbfb),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: boxDecorationTicketSecond,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 8.h,
                                        left: 14.w,
                                        right: 14.w,
                                        bottom: 14.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: Image.asset(
                                              img_ice_cream,
                                              width: 86.w,
                                              height: 86.h,
                                              fit: BoxFit.fill,
                                            )),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Heaven’s Food
                                            Text("Heaven’s Food",
                                                style: TextStyle(
                                                    color: black_504f58,
                                                    fontFamily:
                                                        fontMavenProProSemiBold,
                                                    fontSize: 15.sp),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  icon_location_pin_account,
                                                  width: 16.w,
                                                  height: 16.h,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text("Chanakyapuri, New Delhi",
                                                    style: TextStyle(
                                                        color: grey_77879e,
                                                        fontFamily:
                                                            fontMavenProMedium,
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.left)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),

                                            i == 0
                                                ? Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        icon_small_rating_bar,
                                                        width: 20.w,
                                                        height: 20.h,
                                                        color:
                                                            Color(0xffffc529),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      // 4.5
                                                      Text("4.5",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.center)
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        icon_yellow_rating_bar,
                                                        width: 20.w,
                                                        height: 20.h,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      // 4.5
                                                      Text("Add Review",
                                                          style: TextStyle(
                                                              color:
                                                                  black_504f58,
                                                              fontFamily:
                                                                  fontMavenProMedium,
                                                              fontSize: 14.sp),
                                                          textAlign:
                                                              TextAlign.center)
                                                    ],
                                                  )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
