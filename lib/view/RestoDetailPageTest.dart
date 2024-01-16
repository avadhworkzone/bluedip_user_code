// import 'dart:async';
// import 'dart:math';
//
// import 'package:bluedip_user/Model/CityListModel.dart';
// import 'package:bluedip_user/Styles/my_colors.dart';
// import 'package:bluedip_user/Styles/my_font.dart';
// import 'package:bluedip_user/Styles/my_icons.dart';
// import 'package:bluedip_user/view/bottom_bar/BottomNavigationScreen.dart';
// import 'package:bluedip_user/view/auth/SignupDetailScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../Styles/my_strings.dart';
// import '../Widget/Textfield.dart';
// import '../Widget/back_button.dart';
// import '../Widget/back_button_square.dart';
// import '../Widget/common_border_button.dart';
// import '../Widget/search_bar.dart';
// import '../Widget/toolbar_with_title.dart';
//
// import 'bottomsheets/BottomSheetOpeningHours.dart';
// import 'home/resto_details/RestoDetailMenuTab.dart';
// import 'home/resto_details/RestoDetailOfferTab.dart';
// import 'home/resto_details/RestoDetailReviewTab.dart';
// import '../Widget/common_red_button.dart';
// import '../Widget/common_verify_red_button.dart';
//
// class RestoDetailPageTest extends StatefulWidget {
//   const RestoDetailPageTest({Key? key}) : super(key: key);
//
//   @override
//   State<RestoDetailPageTest> createState() => _RestoDetailPageState();
// }
//
// class _RestoDetailPageState extends State<RestoDetailPageTest>
//     with TickerProviderStateMixin {
//   List<CityListModel> cityList = [
//     CityListModel("Burger"),
//     CityListModel("Chicken"),
//     CityListModel("Fast Food"),
//   ];
//
//   TabController? tabController;
//   int activeIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 4, vsync: this);
//     tabController!.addListener(() {
//       activeIndex = tabController!.index;
//     });
//   }
//
//   @override
//   void dispose() {
//     tabController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       systemNavigationBarColor: Colors.transparent, // navigation bar color
//       statusBarColor: Colors.transparent, // status bar color
//       statusBarIconBrightness: Brightness.dark, // status bar icons' color
//       systemNavigationBarIconBrightness:
//           Brightness.light, //navigation bar icons' color
//     ));
//     return Scaffold(
//       backgroundColor: white_ffffff,
//       body: NestedScrollView(
//         headerSliverBuilder: (context, value) {
//           return [
//             SliverToBoxAdapter(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           Image.asset(
//                             img_pizza_hut,
//                             width: double.infinity,
//                             height: 250.h,
//                             fit: BoxFit.fill,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: 40.h, left: 24.w, right: 20.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 back_button_square(),
//                                 SvgPicture.asset(icon_red_heart)
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16.r),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // McDonald’s
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 1,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text("Pizza Hut",
//                                           style: TextStyle(
//                                               color: black_504f58,
//                                               fontFamily: fontOverpassBold,
//                                               fontSize: 18.sp,
//                                               letterSpacing: 0.18),
//                                           textAlign: TextAlign.left),
//                                       SizedBox(
//                                         height: 4.h,
//                                       ),
//                                       // Sec 16, Dwarka, New Delhi
//                                       Text("Sec 16, Dwarka, New Delhi - 2.5km",
//                                           style: TextStyle(
//                                               color: grey_5f6d7b,
//                                               fontFamily: fontMavenProRegular,
//                                               fontStyle: FontStyle.normal,
//                                               fontSize: 12.sp),
//                                           textAlign: TextAlign.left),
//                                     ],
//                                   ),
//                                 ),
//                                 Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         // 4.5
//                                         Text("4.5",
//                                             style: TextStyle(
//                                                 color: black_504f58,
//                                                 fontFamily: fontMavenProMedium,
//                                                 fontSize: 14.sp),
//                                             textAlign: TextAlign.left),
//                                         SizedBox(
//                                           width: 2.w,
//                                         ),
//                                         SvgPicture.asset(
//                                           icon_small_rating_bar,
//                                           width: 14.w,
//                                           height: 14.h,
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 3.h,
//                                     ),
//                                     Text("(25+)",
//                                         style: TextStyle(
//                                             color: grey_77879e,
//                                             fontFamily: fontMavenProMedium,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.left)
//                                   ],
//                                 )
//                               ],
//                             ),
//
//                             SizedBox(
//                               height: 12.h,
//                             ),
//
//                             Row(
//                               children: [
//                                 Image.asset(
//                                   icon_takeaway_png,
//                                   width: 14.w,
//                                   height: 14.h,
//                                 ),
//                                 SizedBox(
//                                   width: 4.w,
//                                 ),
//                                 // Takeaway
//                                 Text("Takeaway",
//                                     style: TextStyle(
//                                         color: grey_5f6d7b,
//                                         fontFamily: fontMavenProRegular,
//                                         fontSize: 12.sp),
//                                     textAlign: TextAlign.left),
//
//                                 SizedBox(
//                                   width: 12.w,
//                                 ),
//
//                                 Image.asset(
//                                   icon_dinein_png,
//                                   width: 14.w,
//                                   height: 14.h,
//                                 ),
//                                 SizedBox(
//                                   width: 4.w,
//                                 ),
//                                 // Takeaway
//                                 Text("Dine-in",
//                                     style: TextStyle(
//                                         color: grey_5f6d7b,
//                                         fontFamily: fontMavenProRegular,
//                                         fontSize: 12.sp),
//                                     textAlign: TextAlign.left),
//                               ],
//                             ),
//
//                             SizedBox(
//                               height: 8.h,
//                             ),
//
//                             SizedBox(
//                               height: 20.h,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 primary: false,
//                                 shrinkWrap: true,
//                                 itemCount: cityList.length,
//                                 itemBuilder: (context, i) => Container(
//                                   margin: EdgeInsets.only(right: 8.w),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5.r),
//                                       color: Color(0xfff6f6f6)),
//                                   child: // Chicken
//                                       Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 6.w, vertical: 2.h),
//                                     child: Text(cityList[i].title,
//                                         style: TextStyle(
//                                             color: grey_77879e,
//                                             fontFamily: fontMavenProRegular,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.center),
//                                   ),
//                                 ),
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: 12.h,
//                             ),
//
//                             Row(
//                               children: [
//                                 // Now Open
//                                 Text("Now Open",
//                                     style: TextStyle(
//                                         color: green_5cb85c,
//                                         fontFamily: fontMavenProMedium,
//                                         fontSize: 12.sp),
//                                     textAlign: TextAlign.left),
//
//                                 SizedBox(
//                                   width: 8.w,
//                                 ),
//
//                                 Expanded(
//                                   flex: 1,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       selectHours(context);
//                                     },
//                                     child: Row(
//                                       children: [
//                                         Text("Close 10:00 PM",
//                                             style: TextStyle(
//                                                 color: black_504f58,
//                                                 fontFamily: fontMavenProMedium,
//                                                 fontSize: 12.sp),
//                                             textAlign: TextAlign.left),
//                                         SizedBox(
//                                           width: 2.w,
//                                         ),
//                                         SvgPicture.asset(
//                                           icon_down_arrow,
//                                           width: 5.w,
//                                           height: 5.h,
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                                 Image.asset(
//                                   icon_rupee_slim,
//                                   width: 9.w,
//                                   height: 9.h,
//                                 ),
//                                 // 500 for 2
//                                 Text("500 for 2",
//                                     style: TextStyle(
//                                         color: black_504f58,
//                                         fontFamily: fontMavenProMedium,
//                                         fontSize: 12.sp),
//                                     textAlign: TextAlign.left)
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Divider(
//                         height: 1,
//                         thickness: 1,
//                         color: divider_d4dce7,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 // margin: EdgeInsets.only(left: 32.w,right: 0.w),
//                 height: 35.h,
//                 color: Colors.white,
//                 width: double.infinity,
//                 child: TabBar(
//                   padding: EdgeInsets.only(left: 16.w, right: 16.w),
//                   labelPadding: EdgeInsets.zero,
//                   isScrollable: true,
//                   labelColor: Colors.white,
//
//                   unselectedLabelColor: grey_969da8,
//                   controller: tabController,
//                   indicatorSize: TabBarIndicatorSize.label,
//                   indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6.r),
//                       color: blue_007add),
//                   tabs: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 14.w),
//                       child: const Tab(
//                         child: Text("Offers"),
//                       ),
//                     ),
//                     Tab(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 14.w),
//                         child: const Text("Menu"),
//                       ),
//                     ),
//                     Tab(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 14.w),
//                         child: const Text("Review"),
//                       ),
//                     ),
//                     Tab(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 14.w),
//                         child: const Text("Amenities"),
//                       ),
//                     ),
//                   ],
//                   // indicatorWeight: 10,
//                   labelStyle: TextStyle(
//                       fontSize: 15.sp,
//                       fontFamily: fontMavenProMedium), //For Selected tab
//                   unselectedLabelStyle: TextStyle(
//                       fontSize: 15.sp,
//                       fontFamily: fontMavenProMedium), //For Un-selected Tabs
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: TabBarView(
//                   physics: ScrollPhysics(),
//                   controller: tabController,
//                   children: const [
//                     RestoDetailOfferTab(),
//                     RestoDetailMenuTab(),
//                     RestoDetailReviewTab(),
//                     RestoDetailOfferTab(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void selectHours(BuildContext context) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         context: context,
//         builder: (
//           BuildContext context,
//         ) {
//           return Container(
//               margin: EdgeInsets.all(20.r),
//               decoration: BoxDecoration(
//                   color: Colors.transparent,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(13.r),
//                       topRight: Radius.circular(13.r),
//                       bottomRight: Radius.circular(13.r),
//                       bottomLeft: Radius.circular(13.r))),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(13)),
//                       child: Column(
//                         children: [BottomSheetOpeningHours()],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     CommonBorderButton(
//                         "Close".toUpperCase(),
//                         () => Navigator.pop(context, false),
//                         Colors.white,
//                         Colors.white,
//                         red_dc3642),
//                   ],
//                 ),
//               ));
//         });
//   }
// }
