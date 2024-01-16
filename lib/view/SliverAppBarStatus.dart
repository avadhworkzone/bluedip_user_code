// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../Model/CityListModel.dart';
// import '../Styles/my_colors.dart';
// import '../Styles/my_font.dart';
// import '../Styles/my_icons.dart';
// import '../Widget/back_button_square.dart';
// import '../Widget/common_border_button.dart';
// import 'bottomsheets/BottomSheetOpeningHours.dart';
// import 'home/resto_details/RestoDetailAmenitiesTab.dart';
// import 'home/resto_details/RestoDetailMenuTab.dart';
// import 'home/resto_details/RestoDetailOfferTab.dart';
// import 'home/resto_details/RestoDetailReviewTab.dart';
//
// class SliverAppBarStatus extends StatefulWidget {
//   const SliverAppBarStatus({Key? key}) : super(key: key);
//
//   @override
//   _SliverAppBarStatusState createState() => _SliverAppBarStatusState();
// }
//
// class _SliverAppBarStatusState extends State<SliverAppBarStatus>
//     with TickerProviderStateMixin {
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
//
//     _scrollController = ScrollController()
//       ..addListener(() {
//         setState(() {
//           _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
//         });
//       });
//   }
//
//   @override
//   void dispose() {
//     tabController!.dispose();
//     super.dispose();
//   }
//
//   late ScrollController _scrollController;
//   Color _textColor = Colors.white;
//   static const kExpandedHeight = 380.0;
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //
//   //   _scrollController = ScrollController()
//   //     ..addListener(() {
//   //       setState(() {
//   //         _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
//   //       });
//   //     });
//   // }
//
//   bool get _isSliverAppBarExpanded {
//     return _scrollController.hasClients &&
//         _scrollController.offset > kExpandedHeight - kToolbarHeight;
//   }
//
//   List<CityListModel> cityList = [
//     CityListModel("Burger"),
//     CityListModel("Chicken"),
//     CityListModel("Fast Food"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white_ffffff,
//       body: NestedScrollView(
//         controller: _scrollController,
//         headerSliverBuilder: (context, innerBoxIsScrolled) {
//           return <Widget>[
//             SliverAppBar(
//               backgroundColor: Colors.white,
//               elevation: 1,
//               leading: Padding(
//                 padding: EdgeInsets.only(
//                     left: 20.w, right: 3.w, bottom: 10.h, top: 10),
//                 child: back_button_square(),
//               ),
//
//               title: _isSliverAppBarExpanded
//                   ? Text("Pizza Hut",
//                       style: TextStyle(
//                           color: black_504f58,
//                           fontFamily: fontOverpassBold,
//                           fontSize: 18.sp,
//                           letterSpacing: 0.18),
//                       textAlign: TextAlign.left)
//                   : null,
//               pinned: true,
//               snap: false,
//               floating: false,
//               expandedHeight: kExpandedHeight,
//               // show and hide FlexibleSpaceBar title
//               flexibleSpace: _isSliverAppBarExpanded
//                   ? null
//                   : FlexibleSpaceBar(
//                       centerTitle: false,
//                       //titlePadding: EdgeInsets.only(bottom: 105, left: 16),
//                       collapseMode: CollapseMode.pin,
//                       // title: Text(
//                       //     "Pizza Hut",
//                       //     style: TextStyle(
//                       //         color: black_504f58,
//                       //         fontFamily: fontOverpassBold,
//                       //         fontSize: 12.sp,
//                       //         letterSpacing: 0.18
//                       //     ),
//                       //     textAlign: TextAlign.left
//                       // ),
//                       background: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Stack(
//                             alignment: Alignment.topRight,
//                             children: [
//                               Image.asset(
//                                 img_pizza_hut,
//                                 width: double.infinity,
//                                 height: 250.h,
//                                 fit: BoxFit.fill,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 48.h, left: 24.w, right: 20.w),
//                                 child: SvgPicture.asset(icon_red_heart),
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(16.r),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // McDonald’s
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       flex: 1,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text("Pizza Hut",
//                                               style: TextStyle(
//                                                   color: black_504f58,
//                                                   fontFamily: fontOverpassBold,
//                                                   fontSize: 18.sp,
//                                                   letterSpacing: 0.18),
//                                               textAlign: TextAlign.left),
//                                           SizedBox(
//                                             height: 6.h,
//                                           ),
//                                           // Sec 16, Dwarka, New Delhi
//                                           Text(
//                                               "Sec 16, Dwarka, New Delhi - 2.5km",
//                                               style: TextStyle(
//                                                   color: grey_5f6d7b,
//                                                   fontFamily:
//                                                       fontMavenProRegular,
//                                                   fontStyle: FontStyle.normal,
//                                                   fontSize: 12.sp),
//                                               textAlign: TextAlign.left),
//                                         ],
//                                       ),
//                                     ),
//                                     Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             // 4.5
//                                             Text("4.5",
//                                                 style: TextStyle(
//                                                     color: black_504f58,
//                                                     fontFamily:
//                                                         fontMavenProMedium,
//                                                     fontSize: 14.sp),
//                                                 textAlign: TextAlign.left),
//                                             SizedBox(
//                                               width: 2.w,
//                                             ),
//                                             SvgPicture.asset(
//                                               icon_small_rating_bar,
//                                               width: 14.w,
//                                               height: 14.h,
//                                             )
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 3.h,
//                                         ),
//                                         Text("(25+)",
//                                             style: TextStyle(
//                                                 color: grey_77879e,
//                                                 fontFamily: fontMavenProMedium,
//                                                 fontSize: 12.sp),
//                                             textAlign: TextAlign.left)
//                                       ],
//                                     )
//                                   ],
//                                 ),
//
//                                 SizedBox(
//                                   height: 12.h,
//                                 ),
//
//                                 Row(
//                                   children: [
//                                     Image.asset(
//                                       icon_takeaway_png,
//                                       width: 14.w,
//                                       height: 14.h,
//                                     ),
//                                     SizedBox(
//                                       width: 4.w,
//                                     ),
//                                     // Takeaway
//                                     Text("Takeaway",
//                                         style: TextStyle(
//                                             color: grey_5f6d7b,
//                                             fontFamily: fontMavenProRegular,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.left),
//
//                                     SizedBox(
//                                       width: 12.w,
//                                     ),
//
//                                     Image.asset(
//                                       icon_dinein_png,
//                                       width: 14.w,
//                                       height: 14.h,
//                                     ),
//                                     SizedBox(
//                                       width: 4.w,
//                                     ),
//                                     // Takeaway
//                                     Text("Dine-in",
//                                         style: TextStyle(
//                                             color: grey_5f6d7b,
//                                             fontFamily: fontMavenProRegular,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.left),
//                                   ],
//                                 ),
//
//                                 SizedBox(
//                                   height: 8.h,
//                                 ),
//
//                                 SizedBox(
//                                   height: 20.h,
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     primary: false,
//                                     shrinkWrap: true,
//                                     itemCount: cityList.length,
//                                     itemBuilder: (context, i) => Container(
//                                       margin: EdgeInsets.only(right: 8.w),
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5.r),
//                                           color: Color(0xfff6f6f6)),
//                                       child: // Chicken
//                                           Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 6.w, vertical: 2.h),
//                                         child: Text(cityList[i].title,
//                                             style: TextStyle(
//                                                 color: grey_77879e,
//                                                 fontFamily: fontMavenProRegular,
//                                                 fontSize: 12.sp),
//                                             textAlign: TextAlign.center),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 SizedBox(
//                                   height: 12.h,
//                                 ),
//
//                                 Row(
//                                   children: [
//                                     // Now Open
//                                     Text("Now Open",
//                                         style: TextStyle(
//                                             color: green_5cb85c,
//                                             fontFamily: fontMavenProMedium,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.left),
//
//                                     SizedBox(
//                                       width: 8.w,
//                                     ),
//
//                                     Expanded(
//                                       flex: 1,
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           selectHours(context);
//                                         },
//                                         child: Row(
//                                           children: [
//                                             Text("Close 10:00 PM",
//                                                 style: TextStyle(
//                                                     color: black_504f58,
//                                                     fontFamily:
//                                                         fontMavenProMedium,
//                                                     fontSize: 12.sp),
//                                                 textAlign: TextAlign.left),
//                                             SizedBox(
//                                               width: 2.w,
//                                             ),
//                                             SvgPicture.asset(
//                                               icon_down_arrow,
//                                               width: 5.w,
//                                               height: 5.h,
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//
//                                     Image.asset(
//                                       icon_rupee_slim,
//                                       width: 9.w,
//                                       height: 9.h,
//                                     ),
//                                     // 500 for 2
//                                     Text("500 for 2",
//                                         style: TextStyle(
//                                             color: black_504f58,
//                                             fontFamily: fontMavenProMedium,
//                                             fontSize: 12.sp),
//                                         textAlign: TextAlign.left)
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const Divider(
//                             height: 1,
//                             thickness: 1,
//                             color: divider_d4dce7,
//                           ),
//                         ],
//                       ),
//                     ),
//
//               // bottom: PreferredSize(
//               //   preferredSize: new Size(35.0, 35.0),
//               //   child: Container(
//               //     height: 35,
//               //
//               //     child: TabBar(
//               //       padding: EdgeInsets.only(right: 24.w),
//               //       labelPadding: EdgeInsets.zero,
//               //       isScrollable: true,
//               //       labelColor: Colors.white,
//               //       unselectedLabelColor: grey_969da8,
//               //       controller: tabController,
//               //
//               //       indicatorSize: TabBarIndicatorSize.label,
//               //       indicator: BoxDecoration(
//               //           borderRadius: BorderRadius.circular(6.r),
//               //           color:blue_007add),
//               //       tabs: [
//               //         Padding(
//               //           padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //           child: const Tab(
//               //             child: Text("Offers"),
//               //           ),
//               //         ),
//               //
//               //         Tab(
//               //           child: Padding(
//               //             padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //             child: const Text("Menu"),
//               //           ),
//               //         ),
//               //
//               //         Tab(
//               //           child: Padding(
//               //             padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //             child: const Text("Review"),
//               //           ),
//               //         ),
//               //
//               //         Tab(
//               //           child: Padding(
//               //             padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //             child: const Text("Amenities"),
//               //           ),
//               //         ),
//               //       ],
//               //       // indicatorWeight: 10,
//               //       labelStyle: TextStyle(fontSize: 15.sp,fontFamily:fontMavenProMedium),  //For Selected tab
//               //       unselectedLabelStyle: TextStyle(fontSize: 15.sp,fontFamily:fontMavenProMedium), //For Un-selected Tabs
//               //     ),
//               //   ),
//               // ),
//             ),
//             SliverAppBar(
//               pinned: true,
//               stretch: false,
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.green,
//               elevation: 1,
//               titleSpacing: 0,
//               toolbarHeight: 0,
//               expandedHeight: 0,
//               flexibleSpace: FlexibleSpaceBar(
//                 collapseMode: CollapseMode.pin,
//                 background: Container(
//                   //  margin: EdgeInsets.only(top: 16.h,bottom: 16.h),
//                   height: 35.h,
//                   color: Colors.white,
//                   width: double.infinity,
//                   child: TabBar(
//                     padding: EdgeInsets.only(left: 16.w, right: 16.w),
//                     labelPadding: EdgeInsets.zero,
//                     isScrollable: true,
//                     labelColor: Colors.white,
//                     unselectedLabelColor: grey_969da8,
//                     controller: tabController,
//                     indicatorSize: TabBarIndicatorSize.label,
//                     indicator: BoxDecoration(
//                         borderRadius: BorderRadius.circular(6.r),
//                         color: blue_007add),
//                     tabs: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 14.w),
//                         child: const Tab(
//                           child: Text("Offers"),
//                         ),
//                       ),
//                       Tab(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 14.w),
//                           child: const Text("Menu"),
//                         ),
//                       ),
//                       Tab(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 14.w),
//                           child: const Text("Review"),
//                         ),
//                       ),
//                       Tab(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 14.w),
//                           child: const Text("Amenities"),
//                         ),
//                       ),
//                     ],
//                     // indicatorWeight: 10,
//                     labelStyle: TextStyle(
//                         fontSize: 15.sp,
//                         fontFamily: fontMavenProMedium), //For Selected tab
//                     unselectedLabelStyle: TextStyle(
//                         fontSize: 15.sp,
//                         fontFamily: fontMavenProMedium), //For Un-selected Tabs
//                   ),
//                 ),
//               ),
//
//               // title:  Container(
//               //   // margin: EdgeInsets.only(left: 32.w,right: 0.w),
//               //   height: 35.h,
//               //   color: Colors.white,
//               //   width: double.infinity,
//               //   child:TabBar(
//               //     padding: EdgeInsets.only(left: 16.w,right: 16.w),
//               //     labelPadding: EdgeInsets.zero,
//               //     isScrollable: true,
//               //     labelColor: Colors.white,
//               //
//               //     unselectedLabelColor: grey_969da8,
//               //     controller: tabController,
//               //     indicatorSize: TabBarIndicatorSize.label,
//               //     indicator: BoxDecoration(
//               //         borderRadius: BorderRadius.circular(6.r),
//               //         color:blue_007add),
//               //     tabs: [
//               //       Padding(
//               //         padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //         child: const Tab(
//               //           child: Text("Offers"),
//               //         ),
//               //       ),
//               //
//               //       Tab(
//               //         child: Padding(
//               //           padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //           child: const Text("Menu"),
//               //         ),
//               //       ),
//               //
//               //       Tab(
//               //         child: Padding(
//               //           padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //           child: const Text("Review"),
//               //         ),
//               //       ),
//               //
//               //       Tab(
//               //         child: Padding(
//               //           padding: EdgeInsets.symmetric(horizontal: 14.w),
//               //           child: const Text("Amenities"),
//               //         ),
//               //       ),
//               //     ],
//               //     // indicatorWeight: 10,
//               //     labelStyle: TextStyle(fontSize: 15.sp,fontFamily:fontMavenProMedium),  //For Selected tab
//               //     unselectedLabelStyle: TextStyle(fontSize: 15.sp,fontFamily:fontMavenProMedium), //For Un-selected Tabs
//               //   ),
//               // ),
//             )
//           ];
//         },
//         body: MediaQuery.removePadding(
//           removeTop: true,
//           context: context,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: TabBarView(
//                   physics: ScrollPhysics(),
//                   controller: tabController,
//                   children: const [
//                     RestoDetailOfferTab(),
//                     RestoDetailMenuTab(),
//                     RestoDetailReviewTab(),
//                     RestoDetailAmenitiesTab(),
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
